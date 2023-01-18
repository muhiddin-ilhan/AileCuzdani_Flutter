import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/providers/loading_provider.dart';
import 'package:aile_cuzdani/core/providers/notification_settings_provider.dart';
import 'package:aile_cuzdani/core/providers/user_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/auth/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'firebase_options.dart';

void main() async {
  await firebaseInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => BucketProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => NotificationSettingsProvider()),
      ],
      child: ShowCaseWidget(
        builder: Builder(
          builder: (context) => MaterialApp(
            title: 'Aile Cüzdanı',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            builder: (context, child) {
              LoadingUtils.instance.setBuildContext(context);
              return customLoadingBuilder(context, child);
            },
            supportedLocales: const [Locale('tr', 'TR')],
            home: const SplashView(),
          ),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future firebaseInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_87EW123M3',
            'Fazla Kurcalama Buraları',
            channelDescription: 'Önemli bildirimler kategorisine dahildir',
            playSound: true,
            priority: Priority.high,
            color: CustomColors.GREEN,
            importance: Importance.high,
            icon: '@drawable/ic_stat_name',
          ),
        ),
      );
    }
  });
}

Widget customLoadingBuilder(BuildContext context, Widget? child) {
  return Consumer<LoadingProvider>(
    builder: (_, provider, __) => Stack(
      children: [
        child!,
        if (provider.isLoading)
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.25),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(38.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: LoadingBouncingGrid.square(
                  backgroundColor: CustomColors.WHITE,
                  borderColor: CustomColors.DARK_GREEN,
                  borderSize: 6,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
