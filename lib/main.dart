import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'common/config.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(const LandNFTRegisterApp());
}

class LandNFTRegisterApp extends StatefulWidget {
  const LandNFTRegisterApp({super.key});

  @override
  State<LandNFTRegisterApp> createState() => _LandNFTRegisterAppState();
}

class _LandNFTRegisterAppState extends State<LandNFTRegisterApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LandNFT Register',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: LandNFTConfig.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromRGBO(68, 97, 242, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
          ),
        ),
      ),
    );
  }
}
