import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:find_and_lost/blocs/authentication/login/user_login_cubit.dart';
import 'package:find_and_lost/blocs/authentication/login/user_login_state.dart';
import 'package:find_and_lost/components/toast.dart';
import 'package:find_and_lost/components/txt_box.dart';
import 'package:find_and_lost/core/utils/app_navigator.dart';
import 'package:find_and_lost/models/user/user_model.dart';
import 'package:find_and_lost/src/app_color.dart';
import 'package:find_and_lost/views/authentication/register/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/cache_helper/cache.dart';
import '../../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isScure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColor.defaultColor,
      ),
      body: BlocConsumer<UserLoginCubit, UserLoginState>(
        listener: (context, state) {
          if (state is UserLoginErrorState) {
            MyToast.getToast(state.error.toString());
          }
          if (state is UserLoginSuccessState) {
            // cache
            CacheHelper.saveData('UId', state.UId).then((value) {
              AppNavigator.customNavigator(context: context, screen: HomeScreen(), finish: true);
            }).catchError(() {});
          }
        },
        builder: (context, state) {
          return Container(
            //padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                      color: AppColor.defaultColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Login to continue',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TxtBox(
                                    label: 'Email Address',
                                    //validError:'please enter your email address',
                                    txtController: email,
                                    icon: Icons.email_rounded,
                                    keyboardType: TextInputType.emailAddress),
                                SizedBox(
                                  height: 25,
                                ),
                                TxtBox(
                                  label: 'Password',
                                  //validError: 'please enter your email address',
                                  txtController: pass,
                                  icon: Icons.lock,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => HomeScreen(),
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    'Forget Password?',
                                  ),
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                    primary: AppColor.defaultColor,
                                    padding: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! UserLoginLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UserModel user = new UserModel(
                                  email: email.value.text,
                                  password: pass.value.text,
                                );
                                print(user.email);
                                print(user.password);
                                UserLoginCubit.get(context).Login(user);
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            color: AppColor.defaultColor,
                            height: 60,
                            minWidth: 250,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New User?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            ' Sign Up',
                          ),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            primary: AppColor.defaultColor,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

