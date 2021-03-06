// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD_an8jXX82z6P5_vyQx1RURiyp6SPzYEc',
    appId: '1:913394926277:web:7cbd9ee2271a4e5ee7a6ac',
    messagingSenderId: '913394926277',
    projectId: 'icho-shop',
    authDomain: 'icho-shop.firebaseapp.com',
    storageBucket: 'icho-shop.appspot.com',
    measurementId: 'G-EL1LKJLGLN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1LjTVGs2jCOd2WmjMy-bl2MPrcqR-a_Q',
    appId: '1:913394926277:android:338b8020206b34efe7a6ac',
    messagingSenderId: '913394926277',
    projectId: 'icho-shop',
    storageBucket: 'icho-shop.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZ02pVi0J-mjNG5CQlznWVXjlMowbAOwg',
    appId: '1:913394926277:ios:51131c7e3a53cda2e7a6ac',
    messagingSenderId: '913394926277',
    projectId: 'icho-shop',
    storageBucket: 'icho-shop.appspot.com',
    androidClientId: '913394926277-52p4l6qr9j28vvk0ks50eifj8poj4d1i.apps.googleusercontent.com',
    iosClientId: '913394926277-7598i3irksj8qbpblk1egt5og76l2jcg.apps.googleusercontent.com',
    iosBundleId: 'com.example.shop',
  );
}
