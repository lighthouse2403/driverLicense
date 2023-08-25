import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClTNyWbqAh0yWsfrGEi8iCz0kqKbkoXoE',
    appId: '1:855984490695:android:6643027bc44252d53856e2',
    messagingSenderId: '490028130190',
    projectId: 'golfzon-gsm',
    storageBucket: 'golfzon-gsm.appspot.com',
    androidClientId: '490028130190-mdagqnl1gfk3ohb0qvdokntrsho57n6o.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDI5gYkmW7od5GYj7MGK9truWICrx4OMDg',
    appId: '1:855984490695:ios:70f09987c05a6d773856e2',
    messagingSenderId: '855984490695',
    projectId: 'driver-licens',
    storageBucket: 'driver-licens.appspot.com',
    iosClientId: 'com.googleusercontent.apps.855984490695-r2ghgkhjnjcp6f93dfopk70uote87f9u',
    iosBundleId: 'com.driver.license',
  );
}
