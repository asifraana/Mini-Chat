import 'package:flutter/material.dart';
import 'package:get/get.dart';





class PopAlert extends StatefulWidget {
  final String? title,subtext;

  final String? image,buttontext;
  PopAlert( {this.title,this.subtext,  this.image,this.buttontext}):super();

  @override
  _PopAlertState createState() => new _PopAlertState();
}

class _PopAlertState extends State<PopAlert> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(scale: scaleAnimation,
        child: AlertDialog(contentPadding:EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
          content: WillPopScope(
            onWillPop: (){return Future.value(false);},
            child: Container(
              decoration: BoxDecoration(color:Colors.white.withOpacity(0.2),borderRadius: new BorderRadius.all( Radius.circular(20.0)),
              

              ),
              height:190,
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.title != null && widget.title!.isNotEmpty)
                      Center(
                        child: Text(
                          widget.title!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),


                    Text(widget.subtext!,
                      style:TextStyle(color:Color(0xff000000) ,fontSize:15 ,fontWeight:FontWeight.w500 ) ,textAlign: TextAlign.center,),
                    ElevatedButton (

                      child: Text("Ok".toUpperCase(),
                        style:TextStyle(color:Color(0xff0360F0) ,fontSize:16 ,fontWeight:FontWeight.bold ) ,),
                      onPressed: () async {
                            Get.back();


                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}