import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth_Screen/login_screen.dart';
import '../Screen/HomeScreen.dart';

class SaveData{

  Future<void>saveData()async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("User", true);
  }

  Future<void>getData()async{
    var prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("User") == true){
      Get.off(HomeScreen());
    }else{
      Get.off(Login());
    }
  }
}