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
    apiKey: 'AIzaSyC1AIFmXPfMiCJVTFe8EUuv2FAynmnJjNA',
    appId: '1:336608851935:web:4a160da9ea6539b727766a',
    messagingSenderId: '336608851935',
    projectId: 'akari-94230',
    authDomain: 'akari-94230.firebaseapp.com',
    storageBucket: 'akari-94230.appspot.com',
    measurementId: 'G-JCT0EB84R4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADxD0Kvcxsap1G0GngcC6WAHNfBws7Nto',
    appId: '1:336608851935:android:9f2ac0e837c54b3727766a',
    messagingSenderId: '336608851935',
    projectId: 'akari-94230',
    storageBucket: 'akari-94230.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM0lDEP3YDl2Id21Kg-K8ro9xxSLB7IdA',
    appId: '1:336608851935:ios:7a44e67dfc04329f27766a',
    messagingSenderId: '336608851935',
    projectId: 'akari-94230',
    storageBucket: 'akari-94230.appspot.com',
    iosBundleId: 'com.example.akari',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM0lDEP3YDl2Id21Kg-K8ro9xxSLB7IdA',
    appId: '1:336608851935:ios:7a44e67dfc04329f27766a',
    messagingSenderId: '336608851935',
    projectId: 'akari-94230',
    storageBucket: 'akari-94230.appspot.com',
    iosBundleId: 'com.example.akari',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1AIFmXPfMiCJVTFe8EUuv2FAynmnJjNA',
    appId: '1:336608851935:web:0b006aba49cb8c9827766a',
    messagingSenderId: '336608851935',
    projectId: 'akari-94230',
    authDomain: 'akari-94230.firebaseapp.com',
    storageBucket: 'akari-94230.appspot.com',
    measurementId: 'G-MNBZ6XS2GL',
  );
}
