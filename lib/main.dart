import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_application/Fcm/fcm.dart';
import 'package:to_do_application/core/provider/app_provider.dart';
import 'package:to_do_application/core/services/loading_service.dart';
import 'package:to_do_application/core/theme/application_theme.dart';
import 'package:to_do_application/layout/home_layout.dart';
import 'package:to_do_application/pages/edit_task/edit_task.dart';
import 'package:to_do_application/pages/login/login_screen.dart';
import 'package:to_do_application/pages/register/register_screen.dart';
import 'package:to_do_application/pages/splash_screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FCM.fcmInit();
  runApp(ChangeNotifierProvider(
      create: (context) => AppProvider(prefs), child: const MyApplication()));
  configLoading();
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        EditTask.routeName: (context) => const EditTask(),
      },
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      theme: ApplicationTheme.lightTheme,
      darkTheme: ApplicationTheme.darkTheme,
      themeMode: appProvider.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appProvider.currentLocal),
    );
  }
}
