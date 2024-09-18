import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController{
  RxString username = "".obs;
  

  Future<void>saveGetusername()async{
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var password = prefs.getString("password");
    if (email != "" && password != ""){
      get_username(email, password);
    }
  }



  Future<void>get_username(email, password)async{
    try{
      var url = Uri.parse("https://appoaep.space/get_username?email=${email}&&password=${password}");
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
      );
    var data = jsonDecode(response.body);

    username.value = data['username'];
    }catch(e){
      print(e.toString());
    }

  }

  

}