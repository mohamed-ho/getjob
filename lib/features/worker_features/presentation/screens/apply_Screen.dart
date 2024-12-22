//responsive
import 'dart:io';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/widgets/custom_Error_dialog.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/presentation/bloc/application_bloc.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key, required this.job});
  final Job job;
  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  String address = '';

  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String email = '';

  File? file;

  String message = '';

  FilePickerResult? result;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    final firstNamelength =
        UserLocalDataSourceImpl().getUser().name.indexOf(' ');
    firstController.text =
        UserLocalDataSourceImpl().getUser().name.substring(0, firstNamelength);
    final lastNamelength = UserLocalDataSourceImpl()
        .getUser()
        .name
        .substring(firstNamelength + 1)
        .indexOf(' ');
    if (lastNamelength == -1) {
      lastController.text = UserLocalDataSourceImpl()
          .getUser()
          .name
          .substring(firstNamelength + 1);
    } else {
      lastController.text = UserLocalDataSourceImpl()
          .getUser()
          .name
          .substring(firstNamelength + 1);
    }
    emailController.text = UserLocalDataSourceImpl().getUser().email;
    //hosny hassan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is ApplicationErrorState) {
          setState(() {
            isloading = false;
          });

          if (state.message == 'Exception: you actually send an Application') {
            customErrorDialog(context, state.message, 'failed process');
          } else {
            customErrorDialog(
                context, 'you have Error please try agian', 'failed process');
          }
        } else if (state is ApplicationLoadingState) {
          setState(() {
            isloading = true;
          });
        } else if (state is ApplicationLoadedState) {
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('order the job is sucess'),
            backgroundColor: Colors.green,
          ));
          Navigator.pop(context);
        }
      },
      child: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
              child: Form(
                key: globalKey,
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: .01.sh),
                    child: SizedBox(
                      height: .05.sh,
                      width: double.infinity,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              )),
                          const SizedBox(
                            width: 80,
                          ),
                          const Text(
                            'Jobs Apply',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                                fontSize: 16.spMax,
                                color: Colors.black.withOpacity(.6)),
                          ),
                          SizedBox(
                            width: .35.sw,
                            height: .08.sh,
                            child: TextFormField(
                              controller: firstController,
                              validator: (value) {
                                if (value!.length < 2) {
                                  return 'please enter first Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.w)),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: TextStyle(
                                fontSize: 16.spMax,
                                color: Colors.black.withOpacity(.6)),
                          ),
                          SizedBox(
                            width: .35.sw,
                            height: .08.sh,
                            child: TextFormField(
                              controller: lastController,
                              validator: (value) {
                                if (value!.length < 2) {
                                  return 'please enter last Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.w)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.w)),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: .02.sh),
                    child: Text(
                      'Your Email',
                      style: TextStyle(
                          fontSize: 16.spMax,
                          color: Colors.black.withOpacity(.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: .02.sh),
                    child: TextFormField(
                      controller: emailController,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.replaceAll(' ', '').isEmpty) {
                          return 'please enter your Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.w)),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.w)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  Text(
                    'Address',
                    style: TextStyle(
                        fontSize: 16.spMax,
                        color: Colors.black.withOpacity(.6)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.w),
                        border: Border.all(color: Colors.white, width: 2.w)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: SelectState(onCountryChanged: (country) {
                        address = country;
                      }, onStateChanged: (state) {
                        address = '$address/$state';
                      }, onCityChanged: (city) {
                        address = '$address/$city';
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: .02.sh),
                    child: Text(
                      'Message',
                      style: TextStyle(
                          fontSize: 16.spMax,
                          color: Colors.black.withOpacity(.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: .02.h),
                    child: SizedBox(
                      height: .2.sh,
                      child: ListView(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              message = value;
                            },
                            maxLines: 50,
                            minLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.w)),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.w)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'CV',
                    style: TextStyle(
                        fontSize: 16.spMax,
                        color: Colors.black.withOpacity(.6)),
                  ),
                  InkWell(
                    onTap: () async {
                      result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['docx', 'pdf', 'doc'],
                      );
                      if (result != null) {
                        String path = result!.files.first.path!;
                        file = File(path);
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: file == null ? Colors.white : Colors.green,
                          borderRadius: BorderRadius.circular(10.w)),
                      height: .08.sh,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              file == null ? 'Upload Here' : 'file is uploaded',
                              style: TextStyle(
                                  color: file == null
                                      ? Colors.black.withOpacity(.6)
                                      : Colors.white),
                            ),
                            Icon(Icons.file_copy,
                                color: file == null
                                    ? Colors.black.withOpacity(.6)
                                    : Colors.white)
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: .02.sh),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          if (address != '') {
                            if (file != null || result != null) {
                              if (UserLocalDataSourceImpl().getUser().id !=
                                  widget.job.companyId) {
                                BlocProvider.of<ApplicationBloc>(context).add(
                                  AddApplicationEvent(
                                      application: Application(
                                          address: address,
                                          applicationOwnerId:
                                              UserLocalDataSourceImpl()
                                                  .getUser()
                                                  .id,
                                          applicationOwnerImage:
                                              UserLocalDataSourceImpl()
                                                  .getUser()
                                                  .image,
                                          email: emailController.text,
                                          filePath: 'filepath',
                                          firstName: firstController.text,
                                          lastName: lastController.text,
                                          id: 'id',
                                          jobId: widget.job.id,
                                          message: message,
                                          cvFile: file),
                                      jobOrder: JobOrder(
                                          id: 'id',
                                          companyName: widget.job.companyName,
                                          jobTitle: widget.job.title,
                                          companyImage: widget.job.companyImage,
                                          isDelivered: false,
                                          salary: widget.job.salary,
                                          address: address,
                                          userId: ls<UserLocalDataSource>()
                                              .getUser()
                                              .id,
                                          applicationId: 'applicationId',
                                          jobId: widget.job.id)),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'you can not add application becouse you are the job order'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('please choose you CV'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('please enter your Address'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(.8.sw, .06.sh),
                          backgroundColor: MyColors.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.w))),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    firstController.dispose();
    lastController.dispose();
    emailController.dispose();
  }
}
