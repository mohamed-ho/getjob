import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/app_injection.dart';
import 'package:getjob/config/themes/app_theme.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/applications/presentation/bloc/application_bloc.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';
import 'package:getjob/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/jobOrder/presentation/bloc/joborder_bloc.dart';
import 'package:getjob/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjection().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedpref = await SharedPreferences.getInstance();

  runApp(const GetJob());
}

class GetJob extends StatelessWidget {
  const GetJob({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: size,
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ls<UserBloc>()),
          BlocProvider(create: (context) => ls<JobBloc>()),
          BlocProvider(create: (context) => ls<ApplicationBloc>()),
          BlocProvider(create: (context) => ls<ChatBloc>()),
          BlocProvider(create: (context) => ls<JoborderBloc>()),
        ],
        child: SafeArea(
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.myAppThem(),
                onGenerateRoute: MyRoute.route,
                initialRoute: ls<UserLocalDataSource>().checkFirstStart()
                    ? Routes.splashScreen
                    : ls<UserLocalDataSource>().checkLogin()
                        ? Routes.controlScreen
                        : Routes.loginScreen)),
      ),
    );
  }
}
