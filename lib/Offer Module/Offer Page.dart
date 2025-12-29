import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BottomNavigation.dart';

class Offers_page extends StatelessWidget {
  const Offers_page({super.key});

  @override
  Widget build(BuildContext context) {

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Get.offAll(
                () => Bottomnavigation(bottomvalue: 0,),

            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 500),
          );
        },
        child: Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body:Center(
        child: Text('Offers',
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
