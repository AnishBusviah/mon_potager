import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'CapitaliseFirstLetter.dart';
import 'package:http/http.dart' as http;

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
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
    // final baseUrl = 'https://api.openweathermap.org';
    // final endpoint = 'data/2.5/forecast';
    // final queryParameters = {'lat': lat.toString(), 'lon': lon.toString(), 'units': 'metric', 'appid': 'ab6573ef328b0df8804ffcee0190a562'};
    // final queryString = queryParameters.keys.map((key) => '$key=${queryParameters[key]}').join('&');
    //
    // final openWeatherMapURL = '$baseUrl/$endpoint?$queryString';
    // print(openWeatherMapURL);
    //
    // print(Uri.parse(openWeatherMapURL));
    //
    // final openWeatherMapResponse = await http.post(Uri.parse(openWeatherMapURL));
    //
    //
    //
    // print(openWeatherMapResponse.statusCode);
    //print(openWeatherMapResponse.body);

    final weatherListData =
        await rootBundle.loadString("assets/currentWeather.json");
    final decodedWeatherData = await jsonDecode(weatherListData);

    city = decodedWeatherData["name"];
    countryCode = decodedWeatherData["sys"]["country"];
    weather = decodedWeatherData["weather"][0]["description"];

    //weather = CapitaliseFirstLetter(weather);

    weather = CapitaliseFirstLetter(weather);

    temperature = decodedWeatherData["main"]["temp"];
    temperature = temperature.toStringAsFixed(0);
    humidity = decodedWeatherData["main"]["humidity"];
    windSpeed = decodedWeatherData["wind"]["speed"];
    windDirectionDegrees = decodedWeatherData["wind"]["deg"];

    icon = decodedWeatherData["weather"][0]["icon"];

    //print(icon);

    final countryNames =
        await rootBundle.loadString("assets/CountryNameAndCode.json");
    final decodedCountryNames = await jsonDecode(countryNames);

    country = decodedCountryNames[countryCode];

    windSpeed = windSpeed * 3.6;

    if (windDirectionDegrees >= 0 && windDirectionDegrees < 11.25) {
      windDirection = "North";
    } else if (windDirectionDegrees >= 11.25 && windDirectionDegrees < 33.75) {
      windDirection = "North North East";
    } else if (windDirectionDegrees >= 33.75 && windDirectionDegrees < 56.25) {
      windDirection = "North East";
    } else if (windDirectionDegrees >= 56.25 && windDirectionDegrees < 78.75) {
      windDirection = "East North East";
    } else if (windDirectionDegrees >= 78.75 && windDirectionDegrees < 101.25) {
      windDirection = "East";
    } else if (windDirectionDegrees >= 101.25 &&
        windDirectionDegrees < 123.75) {
      windDirection = "East South East";
    } else if (windDirectionDegrees >= 123.75 &&
        windDirectionDegrees < 146.25) {
      windDirection = "South East";
    } else if (windDirectionDegrees >= 146.25 &&
        windDirectionDegrees < 168.75) {
      windDirection = "South South East";
    } else if (windDirectionDegrees >= 168.75 &&
        windDirectionDegrees < 191.25) {
      windDirection = "South";
    } else if (windDirectionDegrees >= 191.25 &&
        windDirectionDegrees < 213.75) {
      windDirection = "South South West";
    } else if (windDirectionDegrees >= 213.75 &&
        windDirectionDegrees < 236.25) {
      windDirection = "South West";
    } else if (windDirectionDegrees >= 236.25 &&
        windDirectionDegrees < 258.75) {
      windDirection = "West South West";
    } else if (windDirectionDegrees >= 258.75 &&
        windDirectionDegrees < 281.25) {
      windDirection = "West";
    } else if (windDirectionDegrees >= 281.25 &&
        windDirectionDegrees < 303.75) {
      windDirection = "West North West";
    } else if (windDirectionDegrees >= 303.75 &&
        windDirectionDegrees < 326.25) {
      windDirection = "North West";
    } else if (windDirectionDegrees >= 326.25 &&
        windDirectionDegrees < 348.75) {
      windDirection = "North North West";
    }
    if (windDirectionDegrees >= 348.75) {
      windDirection = "North";
    }

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
    //   ),
    // );

    Color bgColor = Color.fromRGBO(129, 164, 131, 0.4);

    //Widget style 2
    return icon ==null? Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Center(child: CircularProgressIndicator()),
    ) :  Stack(
      children: [
        //Card background
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1 / 4 * MediaQuery.of(context).size.height,
                width: 9 / 10 * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: bgColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(8, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Weather Data
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 30),
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    //Location
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: icon == null
                              ? CircularProgressIndicator()
                              : country == null
                                  ? CircularProgressIndicator()
                                  : city == null
                                      ? CircularProgressIndicator()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              city,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              country,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                        )
                      ],
                    ),

                    //Icon
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [icon == null? CircularProgressIndicator() :
                          Image.network(
                            'https://openweathermap.org/img/wn/' +
                                icon +
                                '@4x.png',
                            width: 160,
                            height: 160,
                          )
                          // Icon(
                          //   CupertinoIcons.cloud_sun_rain,
                          //   size: 100,
                          // ),
                        ],
                      ),
                    ),

                    //Current Weather and temperature
                    Padding(
                      padding: const EdgeInsets.only(top: 180, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            weather,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              "$temperature\u2103",
                              style: TextStyle(fontSize: 44),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Humidity etc
                    Padding(
                      padding: const EdgeInsets.only(top: 250, left: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Humidity",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Wind Speed",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Wind Direction",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$humidity%",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "$windSpeed km/h",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "$windDirection",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
