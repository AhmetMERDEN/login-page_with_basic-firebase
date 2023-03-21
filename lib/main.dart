import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/Screens/Auth/register_screen.dart';
import 'package:firebase/Screens/Home/home_screen.dart';
import 'package:firebase/Styles/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/Auth/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomeScreen()
      },
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
