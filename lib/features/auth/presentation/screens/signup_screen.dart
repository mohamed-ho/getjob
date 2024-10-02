import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/widgets/custom_button.dart';
import 'package:getjob/core/widgets/custom_error_dialog.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';
import 'package:getjob/features/auth/presentation/widgets/custom_icon_button.dart';
import 'package:getjob/features/auth/presentation/widgets/auth_password_textfomfield.dart';
import 'package:getjob/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({super.key});
  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  String userName = '';

  String email = '';

  String password = '';

  GlobalKey<FormState> globalKey = GlobalKey();

  bool progresshud = false;

  TextEditingController useNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progresshud,
      child: Scaffold(
        body: BlocListener<UserBloc, UserState>(
          bloc: BlocProvider.of<UserBloc>(context),
          listener: (context, state) {
            if (state is UserErrorState) {
              progresshud = false;
              setState(() {});
              customErrorDialog(context, state.message, 'you have error');
            } else if (state is SignUpUserState) {
              progresshud = false;
              setState(() {});
              useNameController.text = '';
              emailController.text = '';
              passwordController.text = '';
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'create account success',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                backgroundColor: Colors.green,
              ));

              Navigator.of(context).pop();
            } else if (state is LoadingUserState) {
              setState(() {});
              progresshud = true;
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: .06.sw),
            child: Form(
              key: globalKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: .02.sh, horizontal: .02.sw),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: (() {
                            Navigator.of(context).pop();
                          }),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: .06.sw,
                          )),
                    ),
                  ),
                  Text(
                    'Register Account',
                    style: TextStyle(
                      fontSize: 30.sp,
                    ),
                  ),
                  Text('Fill your details or continue with\nsocial media',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(.6))),
                  AuthTextFormField(
                    controller: useNameController,
                    hintText: 'user Name',
                    icon: const Icon(Icons.person),
                    onchanged: (value) {
                      userName = value;
                    },
                  ),
                  AuthTextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'this field can not be Empty';
                      } else if (!value.contains('@')) {
                        return 'this email not abailable';
                      }
                      return null;
                    },
                    controller: emailController,
                    hintText: 'Email Address',
                    icon: const Icon(Icons.email_outlined),
                    onchanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: .03.sh,
                  ),
                  AuthPasswordTextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'this field can not be Empty';
                      } else if (value.length < 6) {
                        return 'the password is week it should be long than 6 character';
                      }
                      return null;
                    },
                    hintText: 'password',
                    onChange: (value) {
                      password = value;
                    },
                    controller: passwordController,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: .04.sw, vertical: .04.sh),
                    child: CustomButton(
                        onpressed: () async {
                          if (globalKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            BlocProvider.of<UserBloc>(context)
                                .add(SignUpUserEvent(
                              user: UserModel(
                                  verify: false,
                                  name: useNameController.text,
                                  image: "image",
                                  password: passwordController.text,
                                  email: emailController.text,
                                  id: "id"),
                            ));
                          }
                        },
                        textChild: 'SIGN UP'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: .04.sh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: .08.sw,
                          child: Divider(
                            color: Colors.black.withOpacity(.6),
                            thickness: .003.sw,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: .02.sw),
                          child: Text(
                            'Or Continue with',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(.6),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: .08.sw,
                          child: Divider(
                            color: Colors.black.withOpacity(.6),
                            thickness: .003.sw,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        iconPath: 'assets/images/Google.png',
                        onpressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Soon......'),
                            duration: Duration(microseconds: 200),
                          ));
                        },
                      ),
                      SizedBox(
                        width: .06.sw,
                      ),
                      CustomIconButton(
                          iconPath: 'assets/images/Facebook.png',
                          onpressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Soon......'),
                              duration: Duration(microseconds: 200),
                            ));
                          })
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: .03.sh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New User?',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 14.sp, color: MyColors.mainColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
