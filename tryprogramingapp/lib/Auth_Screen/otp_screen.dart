import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Auth/auth_controller.dart';

class OTP extends StatefulWidget {
  final email;
  OTP({super.key, @required this.email});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var otp_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _auth = Get.put(Auth());
    return Scaffold(
        body: 
          Obx(()=>
            _auth.loading.value == true?CircularProgressIndicator():Container(
                  width: Get.width,
                  decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/Image/background.png"),
                  fit: BoxFit.cover)),
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset("lib/Image/email.json"),
              Text("'${widget.email}' eposta adresine gönderdiğimiz doğrulama kodunu doğrulayın",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,),
              Container(
                width: Get.width - 40,
                child: PinCodeTextField(
                  cursorColor: Colors.transparent,
                  hintCharacter: "*",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6)),
                  controller: otp_controller,
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 6,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 55,
                    width: 400,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(255, 57, 255, 50)),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                        onPressed: () async{
                          await _auth.verify_OTP(otp_controller.value.text,context);
                          setState(() {
                            otp_controller.clear();
                          });
                        },
                        child: Text(
                          "Doğrula",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )
            ],
                  ),
                ),
          ),
        );
  }
}
