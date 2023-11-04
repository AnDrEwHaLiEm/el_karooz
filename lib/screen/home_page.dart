import 'package:flutter/material.dart';
import 'package:el_karooz/widgets/original.button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Home();
}


class _Home extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/photo1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          OriginalButton(
            text: 'أسره الكاروز',
            onPressed: () => Navigator.pushNamed(context, 'login'),
            textColor: const Color(0xFF003554),
            bgColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
