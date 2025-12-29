import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_chat/Home%20Module/HomePage.dart';
import 'package:mini_chat/Offer%20Module/Offer%20Page.dart';
import 'package:get/get.dart';
import 'Home Module/Userlist/userlist_controller.dart';
import 'Settings Module/Settings.dart';

class Bottomnavigation extends StatefulWidget {
   Bottomnavigation({required this.bottomvalue,super.key});
  int bottomvalue;

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  final UserlistController userlist=Get.put(UserlistController());
   late int bottom=0;
   @override
   void initState() {
     super.initState();
     bottom = widget.bottomvalue;

   }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );


    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: bottom == 0
                ? HomePage():
            bottom == 1
                ? Offers_page():
            bottom == 2
                ? Settings()
                : const SizedBox.shrink(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          child:BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            _bottombarapp(context, 'Home', Icons.message, 0),
            const SizedBox(width: 10),
            _bottombarapp(
                context, 'Offers', Icons.local_offer, 1),
            const SizedBox(width: 10),
            _bottombarapp(context, 'Settings', Icons.settings, 2),
            const SizedBox(width: 5),
          ],
        ),
      )),
       floatingActionButton: bottom==0? FloatingActionButton(
         backgroundColor:const Color(0xff2769FC) ,
         foregroundColor:const Color(0xffFFFFFF) ,
          shape: CircleBorder(),
          onPressed: () {userlist.showAddUserDialog(context);},
          child: const Icon(Icons.add),
        ):null
    );
  }



  Widget _bottombarapp(BuildContext context, String title, IconData icon,
      int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigation(index);
      },
      child: Container(
        alignment: Alignment.topCenter,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
              size: bottom == index ? 25 : 22,
              color: bottom == index ? const Color(0xff2769FC) : const Color(
                  0xff868484),
            ),


            Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: bottom == index
                      ? const Color(0xff2769FC)
                      : const Color(0xff868484),
                ),
              ),
            ),
          ],
        ),),
    );
  }

  void Navigation(int index) {
    setState(() {
      bottom = index;
    });
  }





}
