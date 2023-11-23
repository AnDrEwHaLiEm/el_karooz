import 'package:el_karooz/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Home();
}


class _Home extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الكاروز'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/photo1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCardRow([
                HomeCard(
                  title: 'اجبيه',
                  subtitle: 'Answers',
                  icon: Icons.question_answer, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Answers
                  },
                ),
                HomeCard(
                  title: 'ترانيم اليوم',
                  subtitle: "Today's Hymns",
                  icon: Icons.music_note, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Today's Hymns
                  },
                ),
                HomeCard(
                  title: 'الاعتراف',
                  subtitle: "Confession",
                  icon: Icons
                      .playlist_add_check, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Confession
                  },
                ),
              ]),
              const SizedBox(height: 16), // Add some margin between rows
              buildCardRow([
                HomeCard(
                  title: 'مواعيد الكينسة',
                  subtitle: 'Church Schedule',
                  icon: Icons.event, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Church Schedule
                  },
                ),
                HomeCard(
                  title: 'اباء الكينسة',
                  subtitle: 'Church Fathers',
                  icon: Icons.people, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Church Fathers
                  },
                ),
                HomeCard(
                  title: 'الاشعارات',
                  subtitle: 'Notifications',
                  icon: Icons.notifications, // Replace with your desired icon
                  onTap: () {
                    // Handle onTap for Notifications
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardRow(List<Widget> cards) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: cards,
      ),
    );
  }
}
