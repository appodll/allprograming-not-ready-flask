import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/missionsController.dart';
import '../Controller/userDataController.dart';
import '../Model/missionsSearch.dart';
import '../Model/missonsScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _userData = Get.put(UserController());
    final _getMission = Get.put(MissionsGetController());
    _userData.saveGetusername();
    _getMission.get_missions();
    return Scaffold(
      body: Obx(()=>
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/Image/background.png"), fit: BoxFit.cover)
          ),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      Text(_userData.username.value, style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),)],
                  ),
                ),
                Text("Allahın izniyle birşey eklenicek", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(height: Get.height / 2,),
                
                Expanded(
                  child: ListView.builder(
                    itemCount: _getMission.data.value.length,
                    itemBuilder: (context, index) {
                      var mission_name = _getMission.data.value[index]['mission'];
                      return InkWell(
                        onTap: (){
                          _getMission.check_status(_userData.username.value,_getMission.data.value[index]['id']);
                          Get.to(MissionsScreen(
                          description: _getMission.data.value[index]['description'],
                          status_function: ()async{
                             if(_getMission.status.value == 0){
                                await  _getMission.update_mission(_userData.username.value,
                                _getMission.data.value[index]['id'], context);
                                Get.off(HomeScreen());
                             }else{
                              Get.off(HomeScreen());
                             }
                          },));
                        },
                        child: MissionSearch(title: mission_name, 
                        leading: _getMission.data.value[index]['image'],
                        function: (){
                          _getMission.check_status(_userData.username.value,_getMission.data.value[index]['id']);
                          Get.to(MissionsScreen(
                            description: _getMission.data.value[index]['description'],
                              status_function: ()async{
                               if(_getMission.status.value == 0){
                                await  _getMission.update_mission(_userData.username.value,
                                _getMission.data.value[index]['id'], context);
                                Get.off(HomeScreen());
                             }else{
                              Get.off(HomeScreen());
                             }
                          },));
                        },));
                  },),
                )
              ],
            )),
        ),
      ),
    );
  }
}