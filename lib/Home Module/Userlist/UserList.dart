import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/userlist.dart';
import 'chat.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  final UserlistController userlist=Get.put(UserlistController());
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 80),
      itemCount: users.length,
physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final user = users[index];
        final name = user["name"] as String;
        final status = user["status"] as String;
        final online = user["online"] as bool;

        return GestureDetector(
          onTap: (){
            Get.offAll(() => ChatScreen(),
              transition: Transition.leftToRight,
              duration: Duration(milliseconds: 500),
            );

          },
          child:Container(
          margin: const EdgeInsets.only(bottom: 25),

          child:  Row(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(
                              begin: AlignmentGeometry.topLeft,
                              end: AlignmentGeometry.bottomRight,
                              colors: [
                                Color(0xff6474FF),
                                Color(0xff7070FF),
                                Color(0xff9A59FF),
                                Color(0xff9959FF),
                              ])

                      ),
                      child: Text(
                        name[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (online)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 14),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}