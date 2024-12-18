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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAHmVmbTSAIk-uPCGBJ7wv_EIo_roQ8WDo',
    appId: '1:61823440788:web:8f127bc6fe5dc601fda181',
    messagingSenderId: '61823440788',
    projectId: 'soed-market',
    authDomain: 'soed-market.firebaseapp.com',
    storageBucket: 'soed-market.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCcAC1wKlrhwQ8ylQzCqPjagkLx4-MKKA',
    appId: '1:61823440788:android:7b768c07b3acf848fda181',
    messagingSenderId: '61823440788',
    projectId: 'soed-market',
    storageBucket: 'soed-market.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAR94mXbmLqSd7orxgVzKSP_BVRR9Pqk9I',
    appId: '1:61823440788:ios:dbf1d02f6ef14d3efda181',
    messagingSenderId: '61823440788',
    projectId: 'soed-market',
    storageBucket: 'soed-market.firebasestorage.app',
    iosBundleId: 'com.example.soedmarket',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHmVmbTSAIk-uPCGBJ7wv_EIo_roQ8WDo',
    appId: '1:61823440788:web:7ce83d2ff5106423fda181',
    messagingSenderId: '61823440788',
    projectId: 'soed-market',
    authDomain: 'soed-market.firebaseapp.com',
    storageBucket: 'soed-market.firebasestorage.app',
  );
}
