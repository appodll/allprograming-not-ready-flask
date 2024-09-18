import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/missionsController.dart';

class MissionsScreen extends StatelessWidget {
  final description;
  final status_function;
  const MissionsScreen({super.key, @required this.description, @required this.status_function});

  String cleanText(String text) {
    return text.replaceAll('\\r\\n', '\n');
  }

  @override
  Widget build(BuildContext context) {
    final _statusController = Get.put(MissionsGetController());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(()=>
      SizedBox(
          height: 55,
          width: 400,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      _statusController.button_color.value),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: this.status_function,
              child: Text(
                _statusController.button_text.value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Text(
        cleanText(this.description),
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ))),
    );
  }
}
