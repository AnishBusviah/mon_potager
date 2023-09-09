import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

final FlutterTts flutterTts = FlutterTts();

bool announcedWeather = false;
bool spokenSeeMore = false;

var currentWeather;
var currentTemperature;
var currentHumidity;
var currentWindSpeed;
var currentWindDirection;

void speak(String text) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1); // 0.5 to 1.5
  // HapticFeedback.vibrate();
  Vibration.vibrate(duration: 200);
  await flutterTts.speak(text);
}