import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:smartpdf/app/routes/app_pages.dart';
import 'package:smartpdf/app/themes/app_theme.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyDmfCgH4nzv3DcSajCaAq4_IENVSIMJZeE',
          appId: '1:195471786367:web:0029d7e154715120379a4a',
          messagingSenderId: '195471786367',
          projectId: 'smartpdf-beb9d',
          authDomain: 'smartpdf-beb9d.firebaseapp.com',
          storageBucket: 'smartpdf-beb9d.appspot.com',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing app: $e');
    // Show an error dialog or screen instead of crashing
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error initializing app: $e'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SmartPDF',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
