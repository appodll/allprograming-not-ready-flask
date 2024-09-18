import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/auth_controller.dart';
import '../Controller/LoginRegisterController.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RxBool visibilityy = true.obs;
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginRegisterCont());
    final _auth = Get.put(Auth());
    return Scaffold(
      body: Obx(()=>
        _auth.loading.value == true?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/Image/background.png"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Center(
                child: Container(
                  width: Get.width - 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("lib/Image/register photo.png"),
                      SizedBox(
                        height: Get.height / 7,
                      ),
                      TextField(
                        controller: _controller.register_username.value,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: "Kullanıcı adınızı girin",
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
                        height: 5,
                      ),
                      TextField(
                        controller: _controller.register_email.value,
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
                        height: 5,
                      ),
                      TextField(
                        controller: _controller.register_password.value,
                        obscureText: visibilityy.value,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                visibilityy.value =! visibilityy.value;
                              });
                            }, icon: visibilityy.value == true ? Icon(Icons.visibility):Icon(Icons.visibility_off)),
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
                      SizedBox(height: 150,),
                      Column(
                        children: [
                          SizedBox(
                        height: 55,
                        width: 400,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    const Color.fromARGB(255, 50, 193, 255)),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ))
                                ),
                            onPressed: () async{
                              await  _auth.register(
                                _controller.register_username.value.text,
                                _controller.register_email.value.text,
                                _controller.register_password.value.text,
                                context);
                                
                              
                            },
                            child: Text(
                              "Kayıt ol",
                              style: TextStyle(color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                            )),
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Hesabınız zaten varmı?", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),),
                            TextButton(
                              onPressed: (){
                                Get.off(Login(),
                                transition: Transition.leftToRight,
                                duration: Duration(milliseconds: 500)); 
                                _controller.register_email.value.clear();
                                _controller.register_username.value.clear();
                                _controller.register_password.value.clear();
                              }, child: Text("Giriş yapın",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 33, 58, 243),
                              fontSize: 15),))
                          ],
                        ),
                        SizedBox(height: 15,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
