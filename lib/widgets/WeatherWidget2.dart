import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import '../CapitaliseFirstLetter.dart';
import 'package:http/http.dart' as http;

class WeatherInfo2 extends StatefulWidget {
  const WeatherInfo2({Key? key}) : super(key: key);

  @override
  State<WeatherInfo2> createState() => _WeatherInfo2State();
}

class _WeatherInfo2State extends State<WeatherInfo2> {
  LocationData? locationData;
  var latitude;
  var longitude;
  bool notLoaded = true;

  Future<void> GetPermission() async {
    if (!await Permission.location.isGranted) {
      Permission.location.request();
      GetLocation();
    } else {
      GetLocation();
    }
  }

  void GetLocation() async {
    locationData = await Location.instance.getLocation();
    setState(() {
      notLoaded = false;
      latitude = locationData!.latitude;
      longitude = locationData!.longitude;
    });

    GetWeatherData(latitude, longitude);
  }

  var city;
  var country;
  var countryCode;
  var weather;
  var temperature;
  var humidity;
  var windSpeed;
  var windDirectionDegrees;
  var windDirection;
  var icon;

  void GetWeatherData(var lat, var lon) async {
    final baseUrl = 'https://api.openweathermap.org';
    final endpoint = 'data/2.5/forecast';
    final queryParameters = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': 'metric',
      'appid': 'ab6573ef328b0df8804ffcee0190a562'
    };
    final queryString = queryParameters.keys
        .map((key) => '$key=${queryParameters[key]}')
        .join('&');

    final openWeatherMapURL = '$baseUrl/$endpoint?$queryString';
    print(openWeatherMapURL);

    print(Uri.parse(openWeatherMapURL));

    final openWeatherMapResponse =
        await http.post(Uri.parse(openWeatherMapURL));
    //
    //
    //
    // print(openWeatherMapResponse.statusCode);
    //print(openWeatherMapResponse.body);

    ///data from local json
    // final weatherListData =
    //     await rootBundle.loadString("assets/currentWeather.json");
    // final decodedWeatherData = await jsonDecode(weatherListData);

    ///data online
    final weatherListData = openWeatherMapResponse.body;
    final decodedWeatherData = await jsonDecode(weatherListData);

    setState(() {
      city = decodedWeatherData["city"]["name"];
      countryCode = decodedWeatherData["city"]["country"];
      weather = decodedWeatherData["list"][0]["weather"][0]["description"];

      weather = CapitaliseFirstLetter(weather);

      temperature = decodedWeatherData["list"][0]["main"]["temp"];
      temperature = temperature.toStringAsFixed(0);
      humidity = decodedWeatherData["list"][0]["main"]["humidity"];
      windSpeed = decodedWeatherData["list"][0]["wind"]["speed"];
      windDirectionDegrees = decodedWeatherData["list"][0]["wind"]["deg"];

      icon = decodedWeatherData["list"][0]["weather"][0]["icon"];
    });

    //weather = CapitaliseFirstLetter(weather);

    //print(icon);

    final countryNames =
        await rootBundle.loadString("assets/CountryNameAndCode.json");
    final decodedCountryNames = await jsonDecode(countryNames);

    setState(() {
      country = decodedCountryNames[countryCode];

      windSpeed = windSpeed * 3.6;
      windSpeed = windSpeed.toStringAsFixed(2);

      if (windDirectionDegrees >= 0 && windDirectionDegrees < 11.25) {
        windDirection = "North";
      } else if (windDirectionDegrees >= 11.25 &&
          windDirectionDegrees < 33.75) {
        // windDirection = "North North East";
        windDirection = "North East";
      } else if (windDirectionDegrees >= 33.75 &&
          windDirectionDegrees < 56.25) {
        windDirection = "North East";
      } else if (windDirectionDegrees >= 56.25 &&
          windDirectionDegrees < 78.75) {
        // windDirection = "East North East";
        windDirection = "North East";
      } else if (windDirectionDegrees >= 78.75 &&
          windDirectionDegrees < 101.25) {
        windDirection = "East";
      } else if (windDirectionDegrees >= 101.25 &&
          windDirectionDegrees < 123.75) {
        // windDirection = "East South East";
        windDirection = "South East";
      } else if (windDirectionDegrees >= 123.75 &&
          windDirectionDegrees < 146.25) {
        windDirection = "South East";
      } else if (windDirectionDegrees >= 146.25 &&
          windDirectionDegrees < 168.75) {
        // windDirection = "South South East";
        windDirection = "South East";
      } else if (windDirectionDegrees >= 168.75 &&
          windDirectionDegrees < 191.25) {
        windDirection = "South";
      } else if (windDirectionDegrees >= 191.25 &&
          windDirectionDegrees < 213.75) {
        // windDirection = "South South West";
        windDirection = "South West";
      } else if (windDirectionDegrees >= 213.75 &&
          windDirectionDegrees < 236.25) {
        windDirection = "South West";
      } else if (windDirectionDegrees >= 236.25 &&
          windDirectionDegrees < 258.75) {
        // windDirection = "West South West";
        windDirection = "South West";
      } else if (windDirectionDegrees >= 258.75 &&
          windDirectionDegrees < 281.25) {
        windDirection = "West";
      } else if (windDirectionDegrees >= 281.25 &&
          windDirectionDegrees < 303.75) {
        // windDirection = "West North West";
        windDirection = "North West";
      } else if (windDirectionDegrees >= 303.75 &&
          windDirectionDegrees < 326.25) {
        windDirection = "North West";
      } else if (windDirectionDegrees >= 326.25 &&
          windDirectionDegrees < 348.75) {
        // windDirection = "North North West";
        windDirection = "North West";
      }
      if (windDirectionDegrees >= 348.75) {
        windDirection = "North";
      }
    });

    setState(() {});

    // print(city);
    // print(country);
    // print(weather);
    // print(temperature);
    // print(humidity);

    // print(weatherListData);
    // print(decodedWeatherData);

    // final String openWeatherMapAPIKey = "ab6573ef328b0df8804ffcee0190a562";
    // https:///37.4219983-122.084
    // final openWeatherMapURL = Uri.https("api.openweathermap.org", "data/2.5/weather");
    // //+ "lat=" + lat.toString() + "&lon=" + lon.toString() + "&appid=ab6573ef328b0df8804ffcee0190a562");
    //
    // print(openWeatherMapURL);
    //
    // final openWeatherMapResponse = await http.post(openWeatherMapURL, headers: {
    //   "Content-Type": "application/json",
    //   "lat": lat.toString(),
    //   "lon": lon.toString(),
    //   "appid": "ab6573ef328b0df8804ffcee0190a562"
    // });
    //
    // print(openWeatherMapResponse.statusCode);
    // print(openWeatherMapResponse.body);
  }

  @override
  void initState() {
    super.initState();

    GetPermission();
  }

  Widget build(BuildContext context) {
    // Widget style 1
    // return Padding(
    //   padding: const EdgeInsets.only(top: 400, left: 10, right: 10),
    //   child: Container(
    //     height: 1 / 3 * MediaQuery.of(context).size.height,
    //     //color: Colors.lightBlueAccent,
    //     decoration: BoxDecoration(
    //         color: CupertinoColors.lightBackgroundGray,
    //         borderRadius: BorderRadius.all(Radius.circular(25))),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(top: 15, left: 15),
    //               child: Container(
    //                 child: Column(
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 20),
    //                       child: Icon(
    //                         CupertinoIcons.cloud_sun_rain,
    //                         size: 84,
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 10),
    //                       child: Text(
    //                         "Light Showers",
    //                         style: TextStyle(
    //                             fontSize: 25, fontWeight: FontWeight.bold),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 35,
    //               ),
    //               child: Container(
    //                 child: Text(
    //                   "30\u2103",
    //                   style: TextStyle(fontSize: 64),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(top: 10, left: 15),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Humidity: ",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                   Text(
    //                     "Wind Speed: ",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                   Text(
    //                     "Wind Direction: ",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 10, left: 15),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Val",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                   Text(
    //                     "Val",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                   Text(
    //                     "Val",
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 10, left: 10),
    //           child: Row(
    //             children: [
    //               Icon(Icons.pin_drop_rounded),
    //               Text(
    //                 "Roches Noires, Mauritius",
    //                 style: TextStyle(fontSize: 20),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),.
    // );

    Color bgColor = Color.fromRGBO(129, 164, 131, 0.4);

    //Widget style 2
    return icon == null
        ? Padding(
            padding: const EdgeInsets.only(),
            child: Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(0, 102, 51, 12),
            )),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10+3),
            child: Stack(
              children: [
                Container(
                  height: 0.13 * MediaQuery.of(context).size.height,
                  width: 0.94 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: bgColor.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(8, 5), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: icon == null
                        ? CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(0, 102, 51, 1),
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 75-5),
                                child: SizedBox(
                                  // height: 200,
                                  width: 160,
                                  child: Image.network(
                                    'https://openweathermap.org/img/wn/' +
                                        icon +
                                        '@4x.png',
                                    fit: BoxFit.fitWidth,
                                    // width: 160,
                                    // height: 160,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$temperature\u2103",
                                      style: TextStyle(fontSize: 35),
                                    ),
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        weather,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(

                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 190, top: 15-5-2),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10, left: 15+40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.water_drop),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.wind),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text(
                                        "$windSpeed km/h",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "$windDirection",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],),
                                  )
                                ],
                              ),
                            ),

                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageIcon(AssetImage("assets/icons/humidity_icon.png")),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 2),
                                  child: Text(
                                    "$humidity%",
                                    style: TextStyle(fontSize: 15,),

                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 0, top: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "",
                      //         style: TextStyle(fontSize: 15),
                      //       ),
                      //       Text(
                      //         "",
                      //         style: TextStyle(fontSize: 15),
                      //       ),
                      //       Text(
                      //         "",
                      //         style: TextStyle(fontSize: 15),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );

    // Center(
    //   child: notLoaded? Center(child: CircularProgressIndicator(),) : Container(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 300.0),
    //           child: Text("Lat: "+ latitude.toString(), textScaleFactor: 2,),
    //         ),
    //         Text("Lon: "+ longitude.toString(), textScaleFactor: 2,),
    //
    //       ],
    //     ),),
    // );
  }
}
