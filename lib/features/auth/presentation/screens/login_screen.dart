//responsive
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/core/widgets/custom_error_dialog.dart';
import 'package:getjob/core/widgets/custom_button.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';
import 'package:getjob/features/auth/presentation/widgets/custom_icon_button.dart';
import 'package:getjob/features/auth/presentation/widgets/auth_password_textfomfield.dart';
import 'package:getjob/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  GlobalKey<FormState> globalKey = GlobalKey();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            isloading = false;
            customErrorDialog(context, state.message, 'you have error');
          } else if (state is LoadingUserState) {
            isloading = true;
            setState(() {});
          } else if (state is LoginUserState) {
            state.user.verify
                ? {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.controlScreen,
                      (route) => false,
                    ),
                  }
                : setState(() {
                    isloading = false;
                    customCorrectDialog(
                        context, 'please verify your email', 'verification');
                  });
          } else if (state is LoadedUserState) {
            isloading = false;
            customCorrectDialog(
                context,
                'please go to you email and change you password',
                'success process');
          } else {
            setState(() {});
            isloading = false;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: .05.sw, vertical: .06.sh),
          child: isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: globalKey,
                  child: ListView(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 30.spMax, fontWeight: FontWeight.bold),
                      ),
                      Text('Fill your details or continue\n with social media',
                          style: TextStyle(
                            fontSize: 16.spMax,
                            color: Colors.black.withOpacity(.6),
                          )),
                      SizedBox(
                        height: .04.sh,
                      ),
                      AuthTextFormField(
                        hintText: 'email',
                        icon: const Icon(Icons.email_outlined),
                        onchanged: (value) {
                          email = value;
                        },
                        controller: null,
                      ),
                      AuthPasswordTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field can not be Empty';
                          } else if (value.length < 6) {
                            return 'this password is week the password should be long than 6 character';
                          }
                          return null;
                        },
                        hintText: 'password',
                        onChange: (value) {
                          password = value;
                        },
                        controller: null,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: .01.sh, right: .03.sw, left: .6.sw),
                        child: InkWell(
                          onTap: () async {
                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('please enter you email first'),
                                backgroundColor: Colors.red,
                              ));
                            } else if (!email.contains('@')) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('this email is not correct'),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              BlocProvider.of<UserBloc>(context)
                                  .add(ChangePasswordEvent(email: email));
                            }
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.6),
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: .05.sw, vertical: .06.sh),
                        child: CustomButton(
                            onpressed: () async {
                              if (globalKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                BlocProvider.of<UserBloc>(context)
                                    .add(LoginUserEvent(
                                  email: email,
                                  password: password,
                                ));
                              }
                            },
                            textChild: 'LOG IN'),
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
                            onpressed: () {},
                          ),
                          SizedBox(
                            width: .05.sw,
                          ),
                          CustomIconButton(
                              iconPath: 'assets/images/Facebook.png',
                              onpressed: () {})
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: .06.sh),
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
                                Navigator.of(context)
                                    .pushNamed(Routes.signUpScreen);
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
    );
  }
}
