import 'dart:convert';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class MissionsGetController{
  RxList data = [].obs;
  RxInt status = 0.obs;
  RxString button_text = "".obs;
  Rx<Color> button_color = Color.fromRGBO(57, 255, 50, 0.673).obs;
  
  Future<void>get_missions()async{
    try{
      var url = Uri.parse("https://appoaep.space/get_missions");
    var response = await http.get(
      url,
      headers: {"Content-Type" : "application/json"}
      );
    
    var jsonData = jsonDecode(response.body);
    data.value = jsonData;
    }catch(e){
      print(e.toString());
    }
  }

  Future<void>update_mission(username, id, context)async{
    try{
      var url = Uri.parse("https://appoaep.space/update_status");
    var response = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "username" : username,
        "id" : id
      })
      );

      var jsonData = jsonDecode(response.body);
      DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      animationCurve: Curves.elasticOut,
      builder: (context) {
        return ToastCard(
        leading: Icon(Icons.notification_important_rounded),
        title: Text(jsonData['message'].toString()));
      }  , ).show(context);
    }catch(e){
      print(e.toString());
    }
  }


  Future<void>check_status(username,id)async{
    try{
      var url = Uri.parse("https://appoaep.space/check_status?username=$username");
    var response = await http.get(
      url,
      headers: {"Content-Type" : "application/json"}
      );

      var jsonData = jsonDecode(response.body);
      status.value = jsonData['status_$id'];
      print(status);
      if (status == 1){
        button_text.value = "Tamamlandı";
        button_color.value = Color.fromRGBO(57, 255, 50, 0.673);
      }else{
        button_text.value = "Görevi Bitir";
        button_color.value = Color.fromRGBO(50, 183, 255, 0.671);
      }
    }catch(e){
      print(e.toString());
    }
  }
}