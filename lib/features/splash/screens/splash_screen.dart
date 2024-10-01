//responsive
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/splash/widget/custum_elevated_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: .02.sw, vertical: .04.sh),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/Logo.png',
                width: .07.sw,
                height: .07.sw,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: .08.sh),
            child: Image.asset(
              'assets/images/Ai.png',
              width: double.infinity,
              height: .4.sh,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: .02.sh),
            child: Text('Find a Perfact \nJob Match',
                style: TextStyle(fontSize: 34.spMax),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: .065.sh),
            child: Text(
                'Finding your dream job is more easire\n and faster with getJob',
                style: TextStyle(fontSize: 16.spMax),
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: .15.sw),
              child: CustomElevatedIconButton(
                buttonText: 'Let`s Get Start',
                onpress: () {
                  ls<UserLocalDataSource>().setFirstStart();
                  Navigator.pushNamed(context, Routes.loginScreen);
                },
              )),
        ],
      ),
    );
  }
}
