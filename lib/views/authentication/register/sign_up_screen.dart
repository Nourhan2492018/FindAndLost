import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:find_and_lost/blocs/authentication/register/user_register_cubit.dart';
import 'package:find_and_lost/views/google_map/map_view.dart';
import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/register/user_register_state.dart';
import '../../../components/toast.dart';
import '../../../components/txt_box.dart';
import '../../../models/user/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String location = "Choose your city";
  var email = TextEditingController();
  var pass = TextEditingController();
  var phone = TextEditingController();
  var name = TextEditingController();
  var address = TextEditingController();
  var age = TextEditingController();
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
      body: BlocConsumer<UserRegisterCubit, UserRegisterState>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Test(),
              ),
            );
          }
          if (state is UserRegisterErrorState) {
            MyToast.getToast(state.error);
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
                    height: 620,
                    color: Colors.white,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TxtBox(
                                    label: 'Full Name',
                                    //validError: 'please enter your name',
                                    txtController: name,
                                    icon: Icons.person_rounded,
                                    keyboardType: TextInputType.name),
                                SizedBox(
                                  height: 25,
                                ),
                                TxtBox(
                                    label: 'Age',
                                    //validError: 'please enter your age',
                                    txtController: age,
                                    icon: Icons.person,
                                    keyboardType: TextInputType.number),
                                SizedBox(
                                  height: 25,
                                ),
                                TxtBox(
                                    label: 'Phone Number',
                                    //validError: 'please enter your phone',
                                    txtController: phone,
                                    icon: Icons.phone_rounded,
                                    keyboardType: TextInputType.phone),
                                SizedBox(
                                  height: 25,
                                ),
                                TxtBox(
                                    label: 'Email Address',
                                    //validError: 'please enter your email',
                                    txtController: email,
                                    icon: Icons.email_rounded,
                                    keyboardType: TextInputType.emailAddress),
                                SizedBox(
                                  height: 25,
                                ),
                                TxtBox(
                                  label: 'Password',
                                  //validError: 'please enter your password',
                                  txtController: pass,
                                  icon: Icons.lock,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: 340,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColor.textBoxBackgroundColor,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      location = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MapView(),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: AppColor.iconsColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          location,
                                        ),
                                      ],
                                    ),
                                    textColor: location == "Choose your city"
                                        ? AppColor.txtShade
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! UserRegisterLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UserModel user = new UserModel(
                                  email: email.value.text,
                                  age: age.value.text,
                                  address: location,
                                  password: pass.value.text,
                                  phone: phone.value.text,
                                  name: name.value.text,
                                );
                                UserRegisterCubit.get(context)
                                    .UserRegister(user);
                              }
                            },
                            child: Text(
                              'Sign Up',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Text('Test'),
      ),
    );
  }
}