// App Configs
import 'package:flutter/material.dart';

const String APP_NAME = "Photo Gallery";

// Theme Configs
const Color PRIMARY_COLOR = Color(0xFFC86FC9);
const Color SECONDARY_COLOR = Color(0xFF8E518D);
//
const Color matteBlackColor = Color(0xFF3A3A3A);

//
Size screenSize(context) => MediaQuery.sizeOf(context);

// Server Configs
const String BASE_URL = "https://pixabay.com/api/";
const String AUTH_KEY = "43792888-bbf7a67e17bdcc192871fb706";
const int PER_PAGE_RESULT_COUNT = 20;