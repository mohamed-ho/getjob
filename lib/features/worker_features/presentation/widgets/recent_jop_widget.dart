//responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/worker_features/presentation/widgets/apply_widget.dart';

class RecentJopWidget extends StatelessWidget {
  const RecentJopWidget({super.key, required this.job});
  final Job job;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        applyWidget(job: job, context: context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          width: .9.sw,
          height: .12.sh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.w),
            color: Colors.white,
          ),
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: Image.network(
                  job.companyImage,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.fill,
                )),
            title: Text(
              job.title,
              style: TextStyle(fontSize: 16.spMax),
            ),
            subtitle: Text(
              job.type,
              style: TextStyle(fontSize: 12.spMax),
            ),
            trailing: Text(
              '\$${job.salary}/m',
              style: TextStyle(fontSize: 12.spMax),
            ),
          ),
        ),
      ),
    );
  }
}
