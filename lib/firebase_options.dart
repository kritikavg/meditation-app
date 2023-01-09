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
    apiKey: 'AIzaSyAre3KlJErTvLdf0kmJLNKtmC6vcuXo0bE',
    appId: '1:362829069186:web:f0da544804d8cdcf376d9b',
    messagingSenderId: '362829069186',
    projectId: 'fit-memoir',
    authDomain: 'fit-memoir.firebaseapp.com',
    storageBucket: 'fit-memoir.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMzjzafqPYd3WN1G6lrJnS3k-7h5TEzgI',
    appId: '1:362829069186:android:defd5d2a3495b8fd376d9b',
    messagingSenderId: '362829069186',
    projectId: 'fit-memoir',
    storageBucket: 'fit-memoir.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeF7YZLGRfnT4iUEuYelnf7CTdyPe-6wo',
    appId: '1:362829069186:ios:4d9f499b19e3f6da376d9b',
    messagingSenderId: '362829069186',
    projectId: 'fit-memoir',
    storageBucket: 'fit-memoir.appspot.com',
    iosClientId: '362829069186-nj4cmsdk9jdrh61v342g2qdqd167hcp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitMemoir',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDeF7YZLGRfnT4iUEuYelnf7CTdyPe-6wo',
    appId: '1:362829069186:ios:4d9f499b19e3f6da376d9b',
    messagingSenderId: '362829069186',
    projectId: 'fit-memoir',
    storageBucket: 'fit-memoir.appspot.com',
    iosClientId: '362829069186-nj4cmsdk9jdrh61v342g2qdqd167hcp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitMemoir',
  );
}