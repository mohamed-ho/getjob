//responsive
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/worker_features/presentation/widgets/apply_widget.dart';

class PopularJopWidget extends StatelessWidget {
  const PopularJopWidget({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        applyWidget(job: job, context: context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          width: .8.sw,
          height: .3.sh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.w),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: Image.network(
                          job.companyImage,
                          width: 50.w,
                          height: 50.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    ],
                  ),
                  Text(
                    job.companyName,
                    style: TextStyle(fontSize: 12.spMax),
                  ),
                  Text(
                    job.title,
                    style: TextStyle(fontSize: 16.spMax),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${job.salary}/m',
                        style: TextStyle(fontSize: 12.spMax),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      job.address.length > 35
                          ? Text(
                              '${job.address.substring(0, 35)}...',
                              style: TextStyle(fontSize: 12.spMax),
                            )
                          : Text(
                              job.address,
                              style: TextStyle(fontSize: 12.spMax),
                            ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
