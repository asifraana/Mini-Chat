import 'package:flutter/material.dart';

class Offers_page extends StatelessWidget {
  const Offers_page({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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

    );
  }
}
