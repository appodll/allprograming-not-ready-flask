import 'dart:convert';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth_Screen/login_screen.dart';
import '../Auth_Screen/otp_screen.dart';
import '../Controller/UserSaveController.dart';
import '../Controller/userDataController.dart';
import '../Screen/HomeScreen.dart';

class Auth extends GetxController{
  final _userData = Get.put(UserController());
  RxBool loading = false.obs;
  Future<void> register(username, email, password,context)async{
    loading.value = true;
    try{
    var url = Uri.parse("https://appoaep.space/register");
    var response = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "username" : username,
        "email" : email,
        "password" : password
      })
      );
    
    var data = jsonDecode(response.body);
    if (response.statusCode == 200){
      Get.to(OTP(email: email,));
    }
    
    DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      animationCurve: Curves.elasticOut,
      builder: (context) {
        return ToastCard(
        leading: Icon(Icons.notification_important_rounded),
        title: Text(data['message'].toString()));
      }  , ).show(context);
    }catch(e){
      print(e.toString());
    }
    loading.value = false;
  }

  Future<void> login(email, password,context)async{
    try{
      loading.value = true;
    var url = Uri.parse('https://appoaep.space/login');
    var response = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "email" : email,
        "password" : password
      })
      );
      loading.value = false;
      var data = jsonDecode(response.body);
      if (response.statusCode == 200){
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("password", password);
        SaveData().saveData();
        Get.to(HomeScreen());
      }else if (data['message'] == "Epostayı doğrulaman gerek"){
        Get.to(OTP(email: email,));
      }

      DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      animationCurve: Curves.elasticOut,
      builder: (context) {
        return ToastCard(
        leading: Icon(Icons.notification_important_rounded),
        title: Text(data['message'].toString()));
      }  , ).show(context);
    }catch(e){
      print(e.toString());
    }
  }

  

  Future<void>verify_OTP(otp,context)async{
    try{
      loading.value = true;
    var url = Uri.parse("https://appoaep.space/verify_OTP");
    var response = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "OTP" : otp
      })
    );
    loading.value = false;
    var data = jsonDecode(response.body);
    if (response.statusCode == 200){
      Get.off(Login());
    }else{
      DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      animationCurve: Curves.elasticOut,
      builder: (context) {
        return ToastCard(
        leading: Icon(Icons.notification_important_rounded),
        title: Text(data['message'].toString()));
      }  , ).show(context);
    }
    DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      animationCurve: Curves.elasticOut,
      builder: (context) {
        return ToastCard(
        leading: Icon(Icons.notification_important_rounded),
        title: Text(data['message'].toString()));
      }  , ).show(context);
    }catch(e){
      print(e.toString());
    }
  }

}