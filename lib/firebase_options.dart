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
    apiKey: 'AIzaSyCxsBNpHuFm5vVg5Tfkb3nysSvZIUp08Vw',
    appId: '1:1055089073970:web:26e3ba082e610db41cc12b',
    messagingSenderId: '1055089073970',
    projectId: 'e-commerce-food-application',
    authDomain: 'e-commerce-food-application.firebaseapp.com',
    storageBucket: 'e-commerce-food-application.appspot.com',
    measurementId: 'G-JXV07GR8M9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMweslJx8InTsRFUT2-RFxorUFl_AjWkw',
    appId: '1:1055089073970:android:94c9d0e96475aa051cc12b',
    messagingSenderId: '1055089073970',
    projectId: 'e-commerce-food-application',
    storageBucket: 'e-commerce-food-application.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdXOFCH0hJes2hvXptSVq5VpScgamSrKo',
    appId: '1:1055089073970:ios:af4b5b62088d9e121cc12b',
    messagingSenderId: '1055089073970',
    projectId: 'e-commerce-food-application',
    storageBucket: 'e-commerce-food-application.appspot.com',
    iosClientId: '1055089073970-opt033stcll7d6js4ns064c4l5s8jf9r.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodApp.eCommerceFoodApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdXOFCH0hJes2hvXptSVq5VpScgamSrKo',
    appId: '1:1055089073970:ios:af4b5b62088d9e121cc12b',
    messagingSenderId: '1055089073970',
    projectId: 'e-commerce-food-application',
    storageBucket: 'e-commerce-food-application.appspot.com',
    iosClientId: '1055089073970-opt033stcll7d6js4ns064c4l5s8jf9r.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodApp.eCommerceFoodApp',
  );
}
