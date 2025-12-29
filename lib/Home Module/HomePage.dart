import 'package:flutter/material.dart';
import 'Userlist/UserList.dart';
import 'Chat History/chat history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // needed for FAB update
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(

        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(

              pinned: _tabController.index==0?false:true,
              elevation: 0,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 65,
              floating: _tabController.index==0?true:false,
              snap: _tabController.index==0?true:false,
              title: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 44,
                width: MediaQuery.of(context).size.width * 0.64,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: "Users"),
                    Tab(text: "Chat History"),
                  ],
                ),
              ),

              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            UsersTab(),        // ListView inside → scrolls fully
            ChatHistoryTab(),  // ListView inside → scrolls fully
          ],
        ),
      ),

    );
  }
}
