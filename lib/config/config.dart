import 'package:flutter/material.dart';

String serverApi = "http://10.0.32.170:8000/graphql/";
String serverUrl = "http://10.0.32.170:8000";

// String serverApi = "http://10.0.35.200:8000/graphql/";
// String serverUrl = "http://10.0.35.200:8000";

Map<int, Color> myColor = {
  50: Color.fromRGBO(206, 36, 66, .1),
  100: Color.fromRGBO(206, 36, 66, .2),
  200: Color.fromRGBO(206, 36, 66, .3),
  300: Color.fromRGBO(206, 36, 66, .4),
  400: Color.fromRGBO(206, 36, 66, .5),
  500: Color.fromRGBO(206, 36, 66, .6),
  600: Color.fromRGBO(206, 36, 66, .7),
  700: Color.fromRGBO(206, 36, 66, .8),
  800: Color.fromRGBO(206, 36, 66, .9),
  900: Color.fromRGBO(206, 36, 66, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFCE2442, myColor);
