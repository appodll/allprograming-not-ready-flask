import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MissionSearch extends StatelessWidget {
  final title;
  final leading;
  final function;
  const MissionSearch(
      {super.key, 
      @required this.title, 
      @required this.leading,
      @required this.function
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
            height: 60,
            width: Get.width - 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(211, 38, 88, 206),
                  const Color.fromARGB(199, 11, 187, 245)
                ]),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(this.leading))),
                    ),
                    Text(
                      this.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: function,
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 40,
                    ))
              ],
            )),
      ],
    );
  }
}
