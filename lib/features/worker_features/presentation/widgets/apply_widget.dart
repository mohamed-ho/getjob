//responsive
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/core/widgets/custom_error_dialog.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

applyWidget({required Job job, required BuildContext context}) {
  int buttonIndex = 0;
  bool isLoading = false;
  showModalBottomSheet(
      backgroundColor: MyColors.backgroundcolor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.w), topRight: Radius.circular(40.w))),
      builder: (context) {
        return BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatLoadingState) {
              isLoading = true;
            } else if (state is ChatErrorState) {
              customErrorDialog(
                  context, 'you have error please try agian', 'Error Message');
            } else if (state is ChatLoadedState) {
              Navigator.pushReplacementNamed(context, Routes.chatScreen);
            }
          },
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
                  child: SizedBox(
                    height: 700.h,
                    child: StatefulBuilder(
                      builder: (context, setState) => ListView(
                        children: [
                          CircleAvatar(
                            radius: 40.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(320),
                              child: CachedNetworkImage(
                                imageUrl: job.companyImage,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/icons/error.png'),
                                width: 80.w,
                                height: 80.w,
                              ),
                            ),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                itemCount: job
                                                    .jobQualifications.length,
                                                itemBuilder: (context, index) {
                                                  return Text(
                                                    '${index + 1}- ${job.jobQualifications[index]}',
                                                    style: TextStyle(
                                                        fontSize: 16.spMax),
                                                  );
                                                }))
                                      ],
                                    ),
                                  ),
                                )
                              : buttonIndex == 1
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: SizedBox(
                                        height: 300,
                                        child: ListView(children: [
                                          const Text(
                                            'Company Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            job.companyName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Text('Work at',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "${job.category} Company",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: SizedBox(
                                        height: 300,
                                        child: ListView(children: [
                                          Text(
                                            'this job oredrer by ${job.numberOfOrders} person ',
                                            style: const TextStyle(
                                                fontSize: 18,
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
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                child: const Text(
                                  'Apply Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (ls<UserLocalDataSource>().getUser().id !=
                                      job.companyId) {
                                    BlocProvider.of<ChatBloc>(context).add(
                                        AddFriendEvent(
                                            friendId: job.companyId));
                                  } else {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'you cann\'t chat with your self'),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(.16.sw, .16.sw),
                                    backgroundColor: MyColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
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
                ),
        );
      });
}
