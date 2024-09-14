//responsive
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/widgets/custem_Button.dart';
import 'package:getjob/core/widgets/custom_Error_dialog.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';
import 'package:getjob/features/worker_features/presentation/widgets/profile_text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool readOnly = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? file;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController.text = UserLocalDataSourceImpl().getUser().name;
    emailController.text = UserLocalDataSourceImpl().getUser().email;
    passwordController.text = UserLocalDataSourceImpl().getUser().password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UpdateUserState) {
            setState(() {
              isLoading = false;
            });
            CustomCorrectDialog(
                context, 'updated profile success', 'success process');
          } else if (state is UserErrorState) {
            setState(() {
              isLoading = false;
            });
            CustomErrorDialog(
                context, "update profiel is fiald ", 'faild process');
          } else if (state is LoadingUserState) {
            setState(() {
              isLoading = true;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: .03.sw, vertical: .05.sh),
          child: Scaffold(
              backgroundColor: MyColors.backgroundcolor,
              body: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: .02.sw),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: .2.sw,
                                  backgroundImage: file != null
                                      ? FileImage(file!)
                                      : NetworkImage(UserLocalDataSourceImpl()
                                          .getUser()
                                          .image),
                                ),
                                !readOnly
                                    ? Positioned(
                                        bottom: .04.sw,
                                        right: .04.sw,
                                        child: CircleAvatar(
                                          backgroundColor: MyColors.mainColor,
                                          radius: .04.sw,
                                          child: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      height: .18.sh,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: .01.sw),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.w),
                                                          color: MyColors
                                                              .SenderMessageColor),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final imagePicker = await ImagePicker().pickImage(
                                                                      source: ImageSource
                                                                          .camera,
                                                                      maxHeight:
                                                                          200,
                                                                      maxWidth:
                                                                          200);
                                                                  if (imagePicker !=
                                                                      null) {
                                                                    file = File(
                                                                        imagePicker
                                                                            .path);
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      'Camera',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.sp),
                                                                    ),
                                                                    SizedBox(
                                                                      width: .02
                                                                          .sw,
                                                                    ),
                                                                    Image.asset(
                                                                      'assets/icons/camera.png',
                                                                      width: .08
                                                                          .sw,
                                                                      height:
                                                                          .08.sw,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: .02.sh,
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final imagePicker = await ImagePicker().pickImage(
                                                                      source: ImageSource
                                                                          .gallery,
                                                                      maxHeight:
                                                                          200,
                                                                      maxWidth:
                                                                          200);
                                                                  if (imagePicker !=
                                                                      null) {
                                                                    file = File(
                                                                        imagePicker
                                                                            .path);
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      'Gallery',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.sp),
                                                                    ),
                                                                    SizedBox(
                                                                      width: .03
                                                                          .sw,
                                                                    ),
                                                                    Image.asset(
                                                                      'assets/icons/gallery.png',
                                                                      width: .08
                                                                          .sw,
                                                                      height:
                                                                          .08.sw,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.edit_outlined,
                                              size: .04.sw,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                    : const SizedBox()
                              ],
                            ),
                            Text(
                              UserLocalDataSourceImpl().getUser().name,
                              style: TextStyle(fontSize: 22.sp),
                            ),
                            TextButton(
                                onPressed: () {
                                  readOnly = false;
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: MyColors.mainColor),
                                child: const Text('Edit Profile')),
                            ProfileTextFormField(
                                label: 'Name',
                                readOnly: readOnly,
                                textController: nameController),
                            ProfileTextFormField(
                                label: 'Your Email',
                                readOnly: true,
                                textController: emailController),
                            ProfileTextFormField(
                              label: "Password",
                              readOnly: readOnly,
                              textController: passwordController,
                              hide: readOnly,
                            ),
                            Visibility(
                                visible: !readOnly,
                                child: CustomButton(
                                    onpressed: () {
                                      BlocProvider.of<UserBloc>(context).add(
                                          UpdateUserEvent(
                                              user: Users(
                                                  name: nameController.text,
                                                  image:
                                                      UserLocalDataSourceImpl()
                                                          .getUser()
                                                          .image,
                                                  password:
                                                      passwordController.text,
                                                  email: emailController.text,
                                                  id: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  verify: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .emailVerified,
                                                  file: file)));
                                      readOnly = true;
                                      setState(() {});
                                    },
                                    textChild: 'Save Now'))
                          ],
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
