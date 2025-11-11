import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartpdf/app/data/models/user_profile.dart';
import 'package:smartpdf/app/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepository _userRepository = UserRepository();
  
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isEmailVerified = false.obs;
  final RxBool rememberMe = false.obs;
  final Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);
  
  Rx<User?> user = Rx<User?>(null);
  SharedPreferences? _prefs;

  @override
  void onInit() async {
    super.onInit();
    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();
    // Initialize remember me from preferences
    rememberMe.value = _prefs?.getBool('rememberMe') ?? false;
    
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) async {
      this.user.value = user;
      if (user != null) {
        isEmailVerified.value = user.emailVerified;
        // Load user profile
        userProfile.value = await _userRepository.getProfile(user.uid);
        if (userProfile.value == null) {
          // Create profile if it doesn't exist
          final profile = UserProfile(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            photoURL: user.photoURL,
            isEmailVerified: user.emailVerified,
            provider: _getAuthProvider(user),
            rememberMe: rememberMe.value,
            createdAt: DateTime.now(),
            lastLoginAt: DateTime.now(),
          );
          await _userRepository.createProfile(profile);
          userProfile.value = profile;
        }
      }
    });
  }
  


  AuthProvider _getAuthProvider(User user) {
    if (user.isAnonymous) return AuthProvider.anonymous;
    if (user.providerData.any((element) => element.providerId == 'google.com')) {
      return AuthProvider.google;
    }
    return AuthProvider.email;
  }
  
  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      // Validate email format
      if (!GetUtils.isEmail(email)) {
        error.value = 'Please enter a valid email address';
        return;
      }
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (!userCredential.user!.emailVerified) {
        error.value = 'Please verify your email before signing in';
        await signOut();
        return;
      }

      // Update last login
      await _userRepository.updateLastLogin(userCredential.user!.uid);
      
      // Save remember me preference
      if (_prefs != null) {
        if (rememberMe.value) {
          await _prefs!.setBool('rememberMe', true);
          await _prefs!.setString('lastEmail', email);
        } else {
          await _prefs!.remove('rememberMe');
          await _prefs!.remove('lastEmail');
        }
      }
      
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      // Validate email format
      if (!GetUtils.isEmail(email)) {
        error.value = 'Please enter a valid email address';
        return;
      }
      
      // Validate password strength
      if (!_isPasswordStrong(password)) {
        error.value = 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character';
        return;
      }
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create user profile
      final profile = UserProfile(
        uid: userCredential.user!.uid,
        email: email,
        isEmailVerified: false,
        provider: AuthProvider.email,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      
      await _userRepository.createProfile(profile);
      
      // Send email verification
      await userCredential.user!.sendEmailVerification();
      
      Get.snackbar(
        'Verification Required',
        'Please check your email to verify your account',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      
      // Sign out until email is verified
      await signOut();
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        error.value = 'Google sign in cancelled';
        return;
      }
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);
      
      // Update or create user profile
      await _userRepository.updateLastLogin(userCredential.user!.uid);
      
      if (rememberMe.value && _prefs != null) {
        await _prefs!.setBool('rememberMe', true);
      }
      
      Get.offAllNamed('/home');
    } catch (e) {
      error.value = 'Error signing in with Google';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> signInAnonymously() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      // Sign in anonymously with Firebase
      final userCredential = await _auth.signInAnonymously();
      final User? anonymousUser = userCredential.user;
      
      if (anonymousUser == null) {
        error.value = 'Failed to sign in as guest';
        return;
      }
      
      // Create guest profile
      final profile = UserProfile(
        uid: anonymousUser.uid,
        provider: AuthProvider.anonymous,
        displayName: 'Guest User',
        isEmailVerified: false,
        rememberMe: false,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      
      try {
        await _userRepository.createProfile(profile);
        userProfile.value = profile;
        user.value = anonymousUser;
        
        // Navigate to home page with error handling
        print('Attempting to navigate to home page...'); // Debug log
        try {
          await Get.offAllNamed('/home');
          print('Navigation successful'); // Debug log
        } catch (error) {
          print('Navigation error: $error'); // Debug log
          throw Exception('Failed to navigate to home page: $error');
        }
      } catch (e) {
        // If profile creation fails, delete the anonymous user
        await anonymousUser.delete();
        error.value = 'Failed to create guest profile';
      }
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'Error signing in as guest';
      print('Guest sign-in error: $e'); // For debugging
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> resetPassword(String email) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      if (!GetUtils.isEmail(email)) {
        error.value = 'Please enter a valid email address';
        return;
      }
      
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'Password reset email has been sent',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
      if (_prefs != null) {
        await _prefs!.clear(); // Clear all preferences
      }
      Get.offAllNamed('/login');
    } catch (e) {
      error.value = 'Error signing out';
    }
  }
  
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      if (user.value == null) return;
      
      // Update Firebase Auth profile
      await user.value!.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      
      // Update Firestore profile
      await _userRepository.updateProfile(user.value!.uid, {
        if (displayName != null) 'displayName': displayName,
        if (photoURL != null) 'photoURL': photoURL,
      });
      
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Error updating profile';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      if (user.value == null || user.value!.email == null) return;
      
      // Validate new password strength
      if (!_isPasswordStrong(newPassword)) {
        error.value = 'New password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character';
        return;
      }
      
      // Reauthenticate user
      final credential = EmailAuthProvider.credential(
        email: user.value!.email!,
        password: currentPassword,
      );
      await user.value!.reauthenticateWithCredential(credential);
      
      // Change password
      await user.value!.updatePassword(newPassword);
      
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'Error changing password';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> deleteAccount(String password) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      if (user.value == null) return;
      
      if (user.value!.email != null) {
        // Reauthenticate user
        final credential = EmailAuthProvider.credential(
          email: user.value!.email!,
          password: password,
        );
        await user.value!.reauthenticateWithCredential(credential);
      }
      
      // Delete Firestore profile
      await _userRepository.deleteProfile(user.value!.uid);
      
      // Delete Firebase Auth account
      await user.value!.delete();
      
      if (_prefs != null) {
        await _prefs!.clear(); // Clear all preferences
      }
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      error.value = _getMessageFromErrorCode(e.code);
    } catch (e) {
      error.value = 'Error deleting account';
    } finally {
      isLoading.value = false;
    }
  }
  
  void setRememberMe(bool value) {
    rememberMe.value = value;
    if (_prefs != null) {
      _prefs!.setBool('rememberMe', value);
    }
  }
  
  bool _isPasswordStrong(String password) {
    // At least 8 characters
    if (password.length < 8) return false;
    
    // At least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    
    // At least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    
    // At least one number
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    
    // At least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    
    return true;
  }
  
  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Invalid password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Please enter a stronger password';
      default:
        return 'An error occurred. Please try again';
    }
  }
}
