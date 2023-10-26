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
        return macos;
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
    apiKey: 'AIzaSyB1JLQl6SHffOka8z97r9gG2a74yhlJKyc',
    appId: '1:442511002985:web:aaea74fa38f36bbbd241f8',
    messagingSenderId: '442511002985',
    projectId: 'firestoredemo-16c50',
    authDomain: 'firestoredemo-16c50.firebaseapp.com',
    databaseURL: 'https://firestoredemo-16c50.firebaseio.com',
    storageBucket: 'firestoredemo-16c50.appspot.com',
    measurementId: 'G-TW8TXHXRQ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGTP4AH02qGgVClzFX2KpGYSY5jVND584',
    appId: '1:442511002985:android:666e224d150e6b6ad241f8',
    messagingSenderId: '442511002985',
    projectId: 'firestoredemo-16c50',
    databaseURL: 'https://firestoredemo-16c50.firebaseio.com',
    storageBucket: 'firestoredemo-16c50.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCotiEm6SO3efWEY0iuW1CIcBh8VKC_J5c',
    appId: '1:442511002985:ios:667407b36ce5cea2d241f8',
    messagingSenderId: '442511002985',
    projectId: 'firestoredemo-16c50',
    databaseURL: 'https://firestoredemo-16c50.firebaseio.com',
    storageBucket: 'firestoredemo-16c50.appspot.com',
    iosBundleId: 'com.example.src23',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCotiEm6SO3efWEY0iuW1CIcBh8VKC_J5c',
    appId: '1:442511002985:ios:c6ce90bfb981904dd241f8',
    messagingSenderId: '442511002985',
    projectId: 'firestoredemo-16c50',
    databaseURL: 'https://firestoredemo-16c50.firebaseio.com',
    storageBucket: 'firestoredemo-16c50.appspot.com',
    iosBundleId: 'com.example.src23.RunnerTests',
  );
}