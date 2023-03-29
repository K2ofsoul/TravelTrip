import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';

class Vietnam_screen extends StatefulWidget {
  const Vietnam_screen({Key? key}) : super(key: key);

  @override
  State<Vietnam_screen> createState() => _VietnamScreenState();
}

class _VietnamScreenState extends State<Vietnam_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('TravelTrip'),
        ),
        body:Center(
            child: Stack(
              children: [
                Positioned(left:20, top: 20, child:Image(image:AssetImage('assets/images/Vietnam.jpg'),
                )
                ),
              ],
            )
        )
    );
  }
}