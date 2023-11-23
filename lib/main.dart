// ignore_for_file: avoid_print
import 'package:el_karooz/screen/home_page.dart';
import 'package:el_karooz/screen/login_register.dart';
import 'package:el_karooz/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UserService userService = UserService();
  final isUserLoggedIn = await userService.userIsLoggedIn();
  runApp(MyApp(isUserLoggedIn: isUserLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(243, 238, 238, 238)),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(238, 238, 238, 0.963)),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(238, 238, 238, 0.954)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        key: UniqueKey(),
        child: isUserLoggedIn ? const HomePage() : LoginRegisterPage(),
      ),
      routes: <String, WidgetBuilder>{
        'login': (BuildContext context) => Directionality(
            textDirection: TextDirection.rtl,
            key: UniqueKey(),
            child: LoginRegisterPage()),
        'home': (BuildContext context) => const HomePage(),
      },
    );
  }
}
