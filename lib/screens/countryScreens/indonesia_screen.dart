import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';


class Indonesia_screen extends StatefulWidget {
  const Indonesia_screen({Key? key}) : super(key: key);

  @override
  State<Indonesia_screen> createState() => _IndonesiaScreenState();
}

class _IndonesiaScreenState extends State<Indonesia_screen> {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('TravelTrip'),
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

            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned(
                    left: 20,
                    top: 20,
                    child: Image(
                      image: AssetImage('assets/images/Indonesia.jpg'),
                    )),
              ],
            )));
  }
}
