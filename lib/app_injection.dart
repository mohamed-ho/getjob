import 'package:getjob/features/applications/applications_enjection_container.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/chat/chat_enjection_container.dart';
import 'package:getjob/features/job/job_enjection_container.dart';
import 'package:getjob/features/jobOrder/job_order_injection.dart';

class AppInjection {
  void init() {
    AuthEnjectionContainer().init();
    JobEnjectionContainer().init();
    ChatEnjectionContainer().init();
    ApplicationsEnjectionContainer().init();
    JobOrderInjection().init();
  }
}
