import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/init/di/locator.dart';
import 'core/init/navigation/navigation_routes.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/theme/app_theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['API_KEY'];
  final appId = dotenv.env['APP_ID'];
  final messagingSenderId = dotenv.env['MESSAGING_SENDER_ID'];
  final projectId = dotenv.env['PROJECT_ID'];
  await Firebase.initializeApp(options: 
  FirebaseOptions(apiKey: apiKey ?? '', 
  appId: appId ?? '', 
  messagingSenderId: messagingSenderId ?? '', 
  projectId: projectId ?? ''));
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeManager.instance.lightTheme,
        darkTheme: AppThemeManager.instance.darkTheme,
        themeMode: ThemeMode.dark,
        navigatorKey: NavigationService.instance.navigatorKey,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
      ),
    );
  }
}
