import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/presentation/bloc/joborder_bloc.dart';

class JobOrderWidget extends StatelessWidget {
  const JobOrderWidget({
    super.key,
    required this.jobOrder,
  });
  final JobOrder jobOrder;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(.02.sw),
        padding: EdgeInsets.all(.02.sw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: Image.network(
                    jobOrder.companyImage,
                    width: .2.sw,
                    height: .2.sw,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${jobOrder.companyName} ',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        jobOrder.jobTitle,
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        jobOrder.address,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        '\$ ${jobOrder.salary} Monthly',
                        style: TextStyle(fontSize: 14.sp, color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              jobOrder.isDelivered ? Colors.green : Colors.grey,
                          disabledForegroundColor: Colors.white,
                          foregroundColor: Colors.white),
                      child: jobOrder.isDelivered
                          ? const Text(
                              'Delivered',
                            )
                          : const Text('pending')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.updateApplicationScreen,
                          arguments: jobOrder);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[300],
                        foregroundColor: Colors.white),
                    child: const Text(
                      'Edit',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<JoborderBloc>(context)
                          .add(DeleteJobOrderEvent(jobOrder: jobOrder));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text(
                      'Delete',
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
