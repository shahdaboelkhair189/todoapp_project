import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/home/home_screen.dart';
import 'package:todoapp_project/my_theme.dart';
import 'package:todoapp_project/provider/app_config_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore import
import 'package:todoapp_project/provider/list_provider.dart';
import 'package:todoapp_project/provider/user_provider.dart';

import 'home/auth/login/login_screen.dart';
import 'home/auth/register/register_screen.dart';
import 'my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAKQV7Ihr3_7HHk0C2VsVIp20xXD-nqAY8',
        appId: 'com.example.todoapp_project',
        messagingSenderId: '189803992223',
        projectId: 'todo-app-project-91f77'),
  );
//2nd step lel firebase
  // await FirebaseFirestore.instance.disableNetwork();
  // 24t8l offline

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),

      ///rg3na object bel constructor
      ChangeNotifierProvider(
        create: (context) => ListProvider(),
      ),

      ChangeNotifierProvider(create: (context) => UserProvider()),

      ///rg3na object bel constructor
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    ///tempelate paramter no3 provider bta3y   ///class gowah atribute w method 3ayzeen nwslo (obj mn provider)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appMode,

      ///byt7km fe  mode
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
}
