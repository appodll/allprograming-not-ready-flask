import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryprogramingapp/Screen/splashscreen.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MAIN());
}

class MAIN extends StatelessWidget {
  const MAIN({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      title: "APP",
    );
  }
}