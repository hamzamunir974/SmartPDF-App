import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool isEmailVerified;
  final AuthProvider provider;
  final bool rememberMe;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  UserProfile({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.isEmailVerified = false,
    required this.provider,
    this.rememberMe = false,
    required this.createdAt,
    required this.lastLoginAt,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      email: data['email'],
      displayName: data['displayName'] ?? (data['provider'] == 'anonymous' ? 'Guest User' : null),
      photoURL: data['photoURL'],
      isEmailVerified: data['isEmailVerified'] ?? false,
      provider: AuthProvider.values.firstWhere(
        (e) => e.toString() == 'AuthProvider.${data['provider']}',
        orElse: () => AuthProvider.email,
      ),
      rememberMe: data['rememberMe'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isEmailVerified': isEmailVerified,
      'provider': provider.toString().split('.').last,
      'rememberMe': rememberMe,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': Timestamp.fromDate(lastLoginAt),
    };
  }
}

enum AuthProvider {
  email,
  google,
  anonymous,
}
