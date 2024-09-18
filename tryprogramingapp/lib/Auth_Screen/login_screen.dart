import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/auth_controller.dart';
import '../Controller/LoginRegisterController.dart';
import 'register_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  RxBool visibilityy = true.obs;
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginRegisterCont());
    final _auth = Get.put(Auth());
    return Scaffold(
      body: Obx(()=>
        _auth.loading.value == true?Center(child: CircularProgressIndicator()):Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/Image/background.png"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Container(
              width: Get.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(height: 50,),
                  Image.asset("lib/Image/login photo.png"),
                  ],),
                  Column(
                    children: [
                      TextField(
                        controller: _controller.login_email.value,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            hintText: "Eposta girin",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 114, 243)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 33, 163, 243)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _controller.login_password.value,
                        obscureText: visibilityy.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){ 
                            setState(() {
                              visibilityy.value = !visibilityy.value;
                            });
                          }, icon: visibilityy.value == true? Icon(Icons.visibility): Icon(Icons.visibility_off)),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Şifre girin",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 114, 243)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 33, 163, 243)))),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 400,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    const Color.fromARGB(255, 50, 193, 255)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            onPressed: () {
                              _auth.login(
                                _controller.login_email.value.text, 
                                _controller.login_password.value.text,
                                context);
                            },
                            child: Text(
                              "Giriş yap",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Hesabınız yokmu?", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),),
                            TextButton(
                              onPressed: (){
                                
                                Get.off(Register(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 500)); 
                                
                                _controller.login_email.value.clear();
                                _controller.login_password.value.clear();
                              }, child: Text("Kayıt olun",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 33, 58, 243),
                              fontSize: 15),))
                          ],
                        ),
                      SizedBox(height: 30,)
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
