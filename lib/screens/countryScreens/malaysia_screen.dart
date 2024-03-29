import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_trip_application/reusable_widgets/side_menu.dart';
import 'package:travel_trip_application/reusable_widgets/exchange_coin.dart';
import 'package:travel_trip_application/screens/countryScreens/weatherapp_screen.dart';
import 'package:travel_trip_application/screens/malaysia/Destinations/Cameron%20Highlands.dart';
import 'package:travel_trip_application/screens/malaysia/Destinations/Kinabalu.dart';
import 'package:travel_trip_application/screens/malaysia/Destinations/Kuala%20Lumpur%20Bird%20Park.dart';
import 'package:travel_trip_application/screens/malaysia/Destinations/langkawi.dart';
import 'package:travel_trip_application/screens/malaysia/Destinations/Mantanani.dart';
import 'package:travel_trip_application/screens/malaysia/hotels/HarkRockHotel.dart';
import 'package:travel_trip_application/screens/malaysia/hotels/MOVHotel.dart';
import 'package:travel_trip_application/screens/malaysia/hotels/PacificSuteraHotel.dart';
import 'package:travel_trip_application/screens/malaysia/hotels/SunwayPutraHotel.dart';
import 'package:travel_trip_application/screens/malaysia/hotels/TROVE%20Johor%20Bahru.dart';
import 'package:travel_trip_application/screens/malaysia/restaurants/Azmie%20Wawa.dart';
import 'package:travel_trip_application/screens/malaysia/restaurants/Caf%C3%A9%20BLD.dart';
import 'package:travel_trip_application/screens/malaysia/restaurants/EnakKL.dart';
import 'package:travel_trip_application/screens/malaysia/restaurants/LeQue.dart';
import 'package:travel_trip_application/screens/malaysia/restaurants/Samy.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../reusable_widgets/dark_mode.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'ExchangeApp.dart';

class Malaysia_screen extends StatefulWidget {
  const Malaysia_screen({Key? key}) : super(key: key);
  @override
  State<Malaysia_screen> createState() => _MalaysiaScreenState();
}

class _MalaysiaScreenState extends State<Malaysia_screen> {
  int currentIndex = 0;
  String currentTemperature = "Loading...";
  double exchangeRate = 0.0;
  late List<Map<String, String>> destinations;
  late List<Map<String, String>> hotels;
  late List<Map<String, String>> restaurants;
  List<String> events = [
    'malaysia.jfif',
    'malaysia1.jfif',
    'malaysia2.jfif',
    'malaysia3.jfif',
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    destinations = [
      {
        'name': AppLocalizations.of(context).LangkawiScreen,
        'image': 'assets/malaysia/destinations/pulau langkawi1.jpg',
      },
      {
        'name': AppLocalizations.of(context).MountKinabaluScreen,
        'image': 'assets/malaysia/destinations/kinabalu1.jpg',
      },
      {
        'name': AppLocalizations.of(context).MantananiScreen,
        'image': 'assets/malaysia/destinations/mantani1.jpg',
      },
    ];
    hotels = [
      {
        'name': AppLocalizations.of(context).MovHotels,
        'image':'assets/malaysia/hotels/Mov1.jpg',
      },
      {
        'name': AppLocalizations.of(context).SunwayPutraHotel,
        'image': 'assets/malaysia/hotels/sunway1.jpg',
      },
      {
        'name': AppLocalizations.of(context).PacificSuteraHotel,
        'image': 'assets/malaysia/hotels/PacificSuteraHotel1.jpg',
      },
    ];
    restaurants = [
      {
        'name': AppLocalizations.of(context).EnakKL,
        'image': 'assets/malaysia/restaurants/enak1.jpg',
      },
      {
        'name': AppLocalizations.of(context).RestoranSamy,
        'image': 'assets/malaysia/restaurants/samy1.jpg',
      },
      {
        'name': AppLocalizations.of(context).LeQueRestaurant,
        'image': 'assets/malaysia/restaurants/leque1.jpg',
      },
    ];

  }


  @override
  void initState() {
    super.initState();
    getCurrentTemperature();
    fetchExchangeRate();
  }

  Future<void> getCurrentTemperature() async {
    try {
      const apiKey = "";
      const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=Vietnam&appid=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final temperature = data['main']['temp'];
        setState(() {
          currentTemperature = "$temperature°C";
        });
      } else {
        setState(() {
          currentTemperature = "Error";
        });
      }
    } catch (e) {
      setState(() {
        currentTemperature = "Error";
      });
    }
  }

  Future<void> fetchExchangeRate() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.exchangerate-api.com/v4/latest/MYR'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          exchangeRate = data['rates']['MYR'];
        });
      } else {
        setState(() {
          exchangeRate = 0.0;
        });
      }
    } catch (e) {
      setState(() {
        exchangeRate = 0.0;
      });
    }
  }

  void navigateToDestinationDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const langkawiScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const kinabaluScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MantananiScreen()),
      );
        } else if (index == 3) {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Cameron()),
        );
        } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BirdPark()),
      );
    }
  }

  void navigateToHotelsDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MovHotels()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SunwayPutraHotel()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PacificSuteraHotel()),
      );
    }else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Hard()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Trove()),
      );
    }
    // Add more conditions for other items as needed
  }

  void navigateToRestaurantDetail(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EnakKL()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RestoranSamy()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LeQueRestaurant()),
      );
    }else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Azmie()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Bld()),
      );
    }
  }

  // Future<void> getCurrentTemperature() async {
  //   try {
  //     const apiKey = "fe65bdcc943ea9296fb86ce7009d0216";
  //     const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=Vietnam&appid=$apiKey";
  //     final response = await http.get(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final temperature = data['main']['temp'];
  //       setState(() {
  //         currentTemperature = "$temperature°C";
  //       });
  //     } else {
  //       setState(() {
  //         currentTemperature = "Error";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       currentTemperature = "Error";
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeExample>(context);
    final isDarkMode = darkModeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).malaysia),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFF306550),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: isDarkMode
                ? [
              Colors.black38,
              Colors.black38
            ]
                : [
              hexStringToColor("F1F9F6"),
              hexStringToColor("D1EEE1"),
              hexStringToColor("AFE1CE")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 210,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                initialPage: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: events.map((event) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      'assets/images/events/$event',
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: events.map((event) {
                int index = events.indexOf(event);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.green : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).currentTemperature,
                  style: TextStyle(fontSize: 16),
                ),

              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherApp()),
                );
              },
              child: Card(
                child: Container(
                  child: Image.asset('assets/images/Malaysia_weather.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Text(
            //   currentTemperature,
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  AppLocalizations.of(context).exchangeRate,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Text(
            //   '1 VND = ${exchangeRate.toStringAsFixed(2)} TWD',
            //   style: TextStyle(fontSize: 16),
            // ),
            Card(
              child: GestureDetector(
                onTap: () {
                  // Navigate to the exchange rate screen when the text is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExchangeApp()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    // Your decoration properties...
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '1 MYR = 6.755 TWD',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations
                      .of(context)
                      .destinations,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .moreDetail,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle the destination image click here
                      navigateToDestinationDetail(index);
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              destinations[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            destinations[index]['name']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.black : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations
                      .of(context)
                      .hotels,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .moreDetail,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        // Handle the destination image click here
                        navigateToHotelsDetail(index);
                      },
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                hotels[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hotels[index]['name']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.black : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      )
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations
                      .of(context)
                      .restaurants,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .moreDetail,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        // Handle the destination image click here
                        navigateToRestaurantDetail(index);
                      },
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                restaurants[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              restaurants[index]['name']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.black : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}