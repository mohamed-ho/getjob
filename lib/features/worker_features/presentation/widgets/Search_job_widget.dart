//responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/worker_features/presentation/widgets/apply_widget.dart';

class SearchJobWidget extends StatelessWidget {
  const SearchJobWidget({super.key, required this.job});
  final Job job;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: () {
          applyWidget(job: job, context: context);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
          height: .15.sh,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.w),
                  child: Image.network(
                    job.companyImage,
                    fit: BoxFit.fill,
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 280.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(job.companyName),
                                Text(
                                  job.category,
                                  style: TextStyle(
                                      fontSize: 18.spMax,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 280.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${job.salary.toString()} \$'),
                            Text(job.address.length > 20
                                ? '${job.address.substring(0, 20)}.'
                                : job.address),
                            const Text('12.h'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
