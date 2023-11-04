// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:el_karooz/model/user_interface.dart';
import 'package:el_karooz/service/user_service.dart';
import 'package:el_karooz/widgets/login_form.dart';
import 'package:el_karooz/widgets/register_form.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
  final userService = UserService();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool isLogin = true;

  void toggleLoginRegister() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void onLoginSubmit(String email, String password) async {
    //final fcmToken = await FirebaseMessaging.instance.getToken();
    const String fcmToken =
        "eIonbUh5SNSwM2Dlk6P7ZZ:APA91bFkOk6oopuA_dBlqwyQfaT3x2gvSQhxoA4AvZAKWxNBotAU0JFvgMQY_xd3tuZcZLhUVAGOMzOMc29wTU1KkSsl2NhJ-PScXJoFo9GRGnFCz2P4HjPGepBQkm-qUeEF18lFv_3J";
    final response =
        await widget.userService.loginUser(email, password, fcmToken);

    if (response) {
      navigateToHome();
    } else {
      const String invalidEmailOrPassword =
          'البريد الالكتروني او كلمه المرور غير صحيحة';
      showErrorMessage(invalidEmailOrPassword);
    }
  }

  void navigateToHome() {
    Navigator.pushNamed(context, 'home');
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            Colors.red.withOpacity(0.7), // Set background color with opacity
        content: Row(
          children: <Widget>[
            const Icon(Icons.error, color: Colors.white), // Error icon
            const SizedBox(width: 8.0), // Spacing between icon and text
            Text(
              message,
              style: const TextStyle(color: Colors.white), // Set text color
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            Colors.green.withOpacity(0.7), // Set background color with opacity
        content: Row(
          children: <Widget>[
            const Icon(Icons.check, color: Colors.white), // Success icon
            const SizedBox(width: 8.0), // Spacing between icon and text
            Text(
              message,
              style: const TextStyle(color: Colors.white), // Set text color
            ),
          ],
        ),
      ),
    );
  }

  void onRegisterSubmit(UserModel user) async {
    //final fcmToken = await FirebaseMessaging.instance.getToken();
    const String fcmToken =
        "eIonbUh5SNSwM2Dlk6P7ZZ:APA91bFkOk6oopuA_dBlqwyQfaT3x2gvSQhxoA4AvZAKWxNBotAU0JFvgMQY_xd3tuZcZLhUVAGOMzOMc29wTU1KkSsl2NhJ-PScXJoFo9GRGnFCz2P4HjPGepBQkm-qUeEF18lFv_3J";
    final response = await widget.userService.registerUser(user, fcmToken);
    if (response['status']) {
      const String createUserSuccessMessage =
          'تم تسجيل المستخدم بنجاح فى انتظار قبولك من قبل المسئول';
      showSuccessMessage(createUserSuccessMessage);
    } else {
      String createUserErrorMessage = response['message'];
          showErrorMessage(createUserErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(77),
                  bottomRight: Radius.circular(77),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/photo_che.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLogin)
              LoginForm(
                  onLoginSubmit: onLoginSubmit,
                  toggleForm: toggleLoginRegister),
            // Use LoginForm widget for login form
            if (!isLogin)
              RegisterForm(
                  onRegisterSubmit: onRegisterSubmit,
                  toggleForm:
                      toggleLoginRegister), // Use RegisterForm widget for registration form
          ],
        ),
      ),
    );
  }
}
