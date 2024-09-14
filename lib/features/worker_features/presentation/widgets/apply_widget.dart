//responsive
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

ApplyWidget({required Job job, required BuildContext context}) {
  int buttonIndex = 0;
  showModalBottomSheet(
      backgroundColor: MyColors.backgroundcolor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.w), topRight: Radius.circular(40.w))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
          child: SizedBox(
            height: 700.h,
            child: StatefulBuilder(
              builder: (context, setState) => ListView(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      job.companyImage,
                    ),
                    radius: 40.w,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 20.spMax,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(job.address),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.alarm),
                            Text(job.type,
                                style: TextStyle(fontSize: 16.spMax)),
                          ],
                        ),
                        Text(
                          '\$${job.salary}/m',
                          style: TextStyle(fontSize: 16.spMax),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            backgroundColor: buttonIndex == 0
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          ),
                          child: Text('Description',
                              style: TextStyle(
                                  color: buttonIndex == 0
                                      ? Colors.white
                                      : Colors.black))),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            backgroundColor: buttonIndex == 1
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          ),
                          child: Text('Company',
                              style: TextStyle(
                                  color: buttonIndex == 1
                                      ? Colors.white
                                      : Colors.black))),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonIndex = 2;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            backgroundColor: buttonIndex == 2
                                ? MyColors.mainColor
                                : MyColors.backgroundcolor,
                          ),
                          child: Text('Reviews',
                              style: TextStyle(
                                  color: buttonIndex == 2
                                      ? Colors.white
                                      : Colors.black))),
                    ],
                  ),
                  buttonIndex == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: SizedBox(
                            height: 270.h,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(job.description),
                                  Text(
                                    'Qualifications:',
                                    style: TextStyle(
                                        fontSize: 18.spMax,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              job.jobQualifications.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              '${index + 1}- ${job.jobQualifications[index]}',
                                              style:
                                                  TextStyle(fontSize: 16.spMax),
                                            );
                                          }))
                                ],
                              ),
                            ),
                          ),
                        )
                      : buttonIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                height: 300,
                                child: ListView(children: [
                                  const Text(
                                    'Company Name:-',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    job.companyName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Text('Company Email',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    job.companyId,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                height: 300,
                                child: ListView(children: const [
                                  Text(
                                    'this job oredrer by 43 person ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.applyScreen,
                              arguments: job);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(.6.sw, 60.h),
                            backgroundColor: MyColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: const Text(
                          'Apply Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(.16.sw, .16.sw),
                            backgroundColor: MyColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: const Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
