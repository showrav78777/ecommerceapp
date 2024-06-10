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
    apiKey: 'AIzaSyDy0g90Z5Aa8OXh4xFZ9WRq9C0sXG1tww4',
    appId: '1:973941658938:web:7165b4359b7400af232c03',
    messagingSenderId: '973941658938',
    projectId: 'simple-1cbd6',
    authDomain: 'simple-1cbd6.firebaseapp.com',
    databaseURL: 'https://simple-1cbd6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'simple-1cbd6.appspot.com',
    measurementId: 'G-QZSCQWYM9Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxs_BCG2pqYajnkkvowH7B7IoNXNty39g',
    appId: '1:973941658938:android:121770677a7ef762232c03',
    messagingSenderId: '973941658938',
    projectId: 'simple-1cbd6',
    databaseURL: 'https://simple-1cbd6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'simple-1cbd6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6hh73d3YEFxL8c7EtSpz9RBxO_9IMol4',
    appId: '1:973941658938:ios:0816706657eb3517232c03',
    messagingSenderId: '973941658938',
    projectId: 'simple-1cbd6',
    databaseURL: 'https://simple-1cbd6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'simple-1cbd6.appspot.com',
    androidClientId: '973941658938-08deohnpr0v7iqppqobf86g2fmhaghfr.apps.googleusercontent.com',
    iosClientId: '973941658938-l43ubmt9ajkcve594jtc5ckbk8tjk775.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6hh73d3YEFxL8c7EtSpz9RBxO_9IMol4',
    appId: '1:973941658938:ios:c68e617dff3fa1d0232c03',
    messagingSenderId: '973941658938',
    projectId: 'simple-1cbd6',
    databaseURL: 'https://simple-1cbd6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'simple-1cbd6.appspot.com',
    androidClientId: '973941658938-08deohnpr0v7iqppqobf86g2fmhaghfr.apps.googleusercontent.com',
    iosClientId: '973941658938-38ubc17iutkail0opir8f186tmndkjdl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
