import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/features/worker_features/presentation/screens/home_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/profile_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/setting_screen.dart';
import 'package:getjob/features/worker_features/presentation/widgets/button_navigation_bar_icon.dart';
import 'package:getjob/features/chat/presentation/Screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final pages = [
    HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
    const SettingScreen()
  ];

  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageindex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.w),
                  topRight: Radius.circular(32.w)),
              color: Colors.white),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonNavigationBarIcon(
                  icon: pageindex == 0
                      ? const Icon(
                          Icons.home,
                          color: MyColors.mainColor,
                        )
                      : Icon(
                          Icons.home,
                          color: Colors.grey.shade600,
                        ),
                  discreption: pageindex == 0
                      ? Image.asset('assets/images/Vector 3.png')
                      : const Text('home'),
                  onTap: () {
                    setState(() {
                      pageindex = 0;
                    });
                  }),
              CustomButtonNavigationBarIcon(
                  icon: pageindex == 1
                      ? const Icon(
                          Icons.textsms_rounded,
                          color: MyColors.mainColor,
                        )
                      : const Icon(
                          Icons.textsms_rounded,
                          color: Colors.grey,
                        ),
                  discreption: pageindex == 1
                      ? Image.asset('assets/images/Vector 3.png')
                      : const Text('Message'),
                  onTap: () {
                    setState(() {
                      pageindex = 1;
                    });
                  }),
              CustomButtonNavigationBarIcon(
                  icon: pageindex == 2
                      ? const Icon(
                          Icons.person,
                          color: MyColors.mainColor,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                  discreption: pageindex == 2
                      ? Image.asset('assets/images/Vector 3.png')
                      : const Text('profile'),
                  onTap: () {
                    setState(() {
                      pageindex = 2;
                    });
                  }),
            ],
          ),
        ));
  }
}
