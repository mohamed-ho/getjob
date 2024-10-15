import 'package:getjob/features/applications/presentation/screens/applications_of_job_screen.dart';
import 'package:getjob/features/chat/data/models/friend_model.dart';
import 'package:getjob/features/chat/presentation/Screens/chat_screen.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/presentation/screens/add_job_screen.dart';
import 'package:getjob/features/job/presentation/screens/my_jobs_screen.dart';
import 'package:getjob/features/job/presentation/screens/update_job_screen.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/presentation/screens/job_orders_screen.dart';
import 'package:getjob/features/jobOrder/presentation/screens/update_application_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/apply_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/control_screen.dart';
import 'package:getjob/features/applications/presentation/screens/cv_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/home_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/more_populare_job_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/more_recent_jobs_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/profile_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/search_screen.dart';
import 'package:getjob/features/worker_features/presentation/screens/search_screen_with_more_item.dart';
import 'package:getjob/features/auth/presentation/screens/login_screen.dart';
import 'package:getjob/features/auth/presentation/screens/signup_screen.dart';
import 'package:getjob/features/chat/presentation/Screens/message_person.dart';
import 'package:getjob/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String addJobScreen = 'AddJobScreen';
  static const String splashScreen = 'splashScreen';
  static const String loginScreen = 'loginScreen';
  static const String signUpScreen = 'signUpScreen';
  static const String controlScreen = 'controlScreen';
  static const String homeScreen = 'homeScreen';
  static const String messagesScreen = 'messagesScreen';
  static const String messagePersonScreen = 'messagePersonScreen';
  static const String applicationsOfJobScreen = 'ApplicationsOfJobScreen';
  static const String myJobsScreen = 'myJobsScreen';
  static const String updateJobScreen = 'updateJobScreen';
  static const String searchScreen = 'SearchScreen';
  static const String searchScreenWithMoreItem = 'searchScreenWithMoreItem';
  static const String applyScreen = 'applyScreen';
  static const String profileScreen = 'profileScreen';
  static const String jobOrederScreen = 'jobOrderScreen';
  static const String updateApplicationScreen = 'updateApplicationScreen';
  static const String cvScreen = 'cvScreen';
  static const String chatScreen = 'chatScreen';
  static const String morePopulareJobScreen = 'morePopulareJobScreen';
  static const String moreRecentJobScreen = 'moreRecentJobScreen';
}

class MyRoute {
  static Route<dynamic>? route(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.controlScreen:
        return MaterialPageRoute(builder: (context) => const ControlScreen());
      case Routes.addJobScreen:
        return MaterialPageRoute(builder: (context) => const AddJobScreen());
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.morePopulareJobScreen:
        return MaterialPageRoute(
            builder: (context) => const MorePopulareJobScreen());
      case Routes.moreRecentJobScreen:
        return MaterialPageRoute(
            builder: (context) => const MoreRecentJobsScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUPScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routes.jobOrederScreen:
        return MaterialPageRoute(builder: (context) => const JobOrdersScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.messagePersonScreen:
        final friend = routeSettings.arguments as FriendModel;
        return MaterialPageRoute(
            builder: (context) => MessagePerson(
                  friend: friend,
                ));
      case Routes.applicationsOfJobScreen:
        final job = routeSettings.arguments as Job;
        return MaterialPageRoute(
            builder: (context) => ApplicationsOfJobScreen(
                  job: job,
                ));
      case Routes.myJobsScreen:
        return MaterialPageRoute(builder: (context) => const MyJobsScreen());
      case Routes.updateJobScreen:
        Job job = routeSettings.arguments as Job;
        return MaterialPageRoute(
            builder: (context) => UpdateJobScreen(
                  job: job,
                ));
      case Routes.searchScreen:
        String category = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => SearchScreen(searchItem: category));
      case Routes.searchScreenWithMoreItem:
        FilterJob filterJob = routeSettings.arguments as FilterJob;
        return MaterialPageRoute(
            builder: (context) =>
                SearchScreenWithMoreItem(filterJob: filterJob));
      case Routes.applyScreen:
        Job job = routeSettings.arguments as Job;
        return MaterialPageRoute(builder: (context) => ApplyScreen(job: job));
      case Routes.updateApplicationScreen:
        JobOrder jobOrder = routeSettings.arguments as JobOrder;
        return MaterialPageRoute(
            builder: (context) => UpdateApplicationScreen(jobOrder: jobOrder));
      case Routes.cvScreen:
        String cvUrl = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CvScreen(filePath: cvUrl));
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
    }
    return null;
  }
}
