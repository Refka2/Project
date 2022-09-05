import 'package:flutter/material.dart';
import 'package:flutter1/core/providers/authentication_provider.dart';
import 'package:flutter1/core/providers/folder_provider.dart';
import 'package:flutter1/ui/screens/authentication/views/sign_in_screen.dart';
import 'package:flutter1/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/providers/task_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (context) => FolderProvider()),
          ChangeNotifierProvider(create: (context) => TaskProvider()),
        ],
        builder: (context, _) {
          //final themeProvider = Provider.of<ThemeProvider>(context);
          return Consumer<ThemeProvider>(
            builder: (context, theme, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                themeMode: theme.themeMode,
                darkTheme: Themes.darkTheme,
                theme: Themes.lightTheme,
                debugShowCheckedModeBanner: false,
                home: const SignInScreen(),
              );
            },
          );
        },
      );
}
