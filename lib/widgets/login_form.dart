import 'package:el_karooz/widgets/original.button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {super.key, required this.onLoginSubmit, required this.toggleForm});
  final Function(String email, String password)
      onLoginSubmit;
  final Function toggleForm;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل البريد الالكترونى',
              hintText: 'ex: test@gmail.com',
            ),
            controller: emailController,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل كلمه المرور',
            ),
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 24),
          OriginalButton(
            text: 'تسجيل الدخول',
            textColor: Colors.white,
            bgColor: const Color(0xFF003554),
            onPressed: () {
              widget.onLoginSubmit(emailController.text, passwordController.text);
            },
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              widget.toggleForm();
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(
                    255, 236, 240, 242), // Set your desired color here
              ),
            ),
            child: const Text(
              ' تسجيل مستخدم جديد ',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
