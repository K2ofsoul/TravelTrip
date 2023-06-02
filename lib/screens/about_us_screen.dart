import 'package:provider/provider.dart';
import 'package:travel_trip_application/screens/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/dark_mode.dart';
import '../reusable_widgets/side_menu.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _State();
}

class _State extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: isDarkMode?Colors.black:Color(0xFF306550),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: isDarkMode
                ? [
              Colors.black38,
              Colors.black38
            ]
                :[
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Team Members',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return buildMemberCard(teamMembers[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect with us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/instagram.jfif',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    launchUrl('https://www.instagram.com/phamkien2011/');
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/facebook.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    launchUrl('https://www.facebook.com/phamtrungkien1120/');
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/github.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    launchUrl('https://github.com/K2ofsoul/TravelTrip');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildMemberCard(TeamMember member) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Card(
      color: isDarkMode?Colors.black: Colors.white60,
      // shadowColor:  isDarkMode?Colors.black: Colors.grey,
      // elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(member.imageAsset),
            radius: 50,
          ),
          const SizedBox(height: 10),
          Text(
            member.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            member.position,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TeamMember {
  final String name;
  final String position;
  final String imageAsset;

  TeamMember({required this.name, required this.position, required this.imageAsset});
}

List<TeamMember> teamMembers = [
  TeamMember(
    name: 'Alex',
    position: 'Leader',
    imageAsset: 'assets/members/alex.jpg',
  ),
  TeamMember(
    name: 'Quinton',
    position: 'Developer',
    imageAsset: 'assets/members/quinton.jpg',
  ),
  TeamMember(
    name: 'Jason',
    position: 'Font-end',
    imageAsset: 'assets/members/jason.jpg',
  ),
  TeamMember(
    name: 'Jie',
    position: 'Back-end',
    imageAsset: 'assets/members/jie.jpg',
  ),
];





