// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCSP31PwUYIcXPP64H8uaPRSYruNg39Sm0',
    appId: '1:242959812349:web:a0953b1c46b4fa5d84a094',
    messagingSenderId: '242959812349',
    projectId: 'j-a-r-v-i-s-18bf9',
    authDomain: 'j-a-r-v-i-s-18bf9.firebaseapp.com',
    databaseURL: 'https://j-a-r-v-i-s-18bf9.firebaseio.com',
    storageBucket: 'j-a-r-v-i-s-18bf9.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsEFoFAutxeogOWjywEqGceGQpn8nxgKs',
    appId: '1:242959812349:android:35f9132dccccc4fa84a094',
    messagingSenderId: '242959812349',
    projectId: 'j-a-r-v-i-s-18bf9',
    databaseURL: 'https://j-a-r-v-i-s-18bf9.firebaseio.com',
    storageBucket: 'j-a-r-v-i-s-18bf9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_6k_RcPFsuSY59ijzvMVwx5PqxbFTs1o',
    appId: '1:242959812349:ios:3312158b99d0645d84a094',
    messagingSenderId: '242959812349',
    projectId: 'j-a-r-v-i-s-18bf9',
    databaseURL: 'https://j-a-r-v-i-s-18bf9.firebaseio.com',
    storageBucket: 'j-a-r-v-i-s-18bf9.firebasestorage.app',
    iosBundleId: 'com.example.annfsuJhapaApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_6k_RcPFsuSY59ijzvMVwx5PqxbFTs1o',
    appId: '1:242959812349:ios:3312158b99d0645d84a094',
    messagingSenderId: '242959812349',
    projectId: 'j-a-r-v-i-s-18bf9',
    databaseURL: 'https://j-a-r-v-i-s-18bf9.firebaseio.com',
    storageBucket: 'j-a-r-v-i-s-18bf9.firebasestorage.app',
    iosBundleId: 'com.example.annfsuJhapaApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCSP31PwUYIcXPP64H8uaPRSYruNg39Sm0',
    appId: '1:242959812349:web:278e87c6305bf1a084a094',
    messagingSenderId: '242959812349',
    projectId: 'j-a-r-v-i-s-18bf9',
    authDomain: 'j-a-r-v-i-s-18bf9.firebaseapp.com',
    databaseURL: 'https://j-a-r-v-i-s-18bf9.firebaseio.com',
    storageBucket: 'j-a-r-v-i-s-18bf9.firebasestorage.app',
  );
}
