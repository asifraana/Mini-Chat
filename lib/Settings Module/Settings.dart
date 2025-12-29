import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BottomNavigation.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return  PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Get.offAll(
                () => Bottomnavigation(bottomvalue: 0,),

            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 500),
          );
        },
        child:Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body:Center(
        child:  Text('Settings',
          style: TextStyle(
            fontFamily: 'poppins',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ));
  }
}
