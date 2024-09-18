import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginRegisterCont extends GetxController{

  Rx<TextEditingController> register_username = TextEditingController().obs;
  Rx<TextEditingController> register_email = TextEditingController().obs;
  Rx<TextEditingController> register_password = TextEditingController().obs;
 ////////////////////////////////////////////////////////////////////////////////////////////
  Rx<TextEditingController> login_email = TextEditingController().obs;
  Rx<TextEditingController> login_password = TextEditingController().obs;
}