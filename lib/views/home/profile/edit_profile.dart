import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/user/user_cubit.dart';
import '../../../blocs/user/user_state.dart';
import '../../../components/text_felid.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var email=TextEditingController();

  var pass=TextEditingController();

  var phone=TextEditingController();

  var name=TextEditingController();

  var address=TextEditingController();

  var age=TextEditingController();
  var bio=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isScure= true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=UserCubit.get(context).userModel;

         var profileImage=UserCubit.get(context).profileImage;

        name.text=UserCubit.get(context).userModel!.name!;
        age.text=userModel!.age.toString();
        address.text=userModel!.address.toString();
        phone.text=userModel!.phone.toString();
        pass.text=userModel!.password.toString();
        bio.text=userModel!.bio.toString();
        //print(" kllnlk");
        //print(userModel!.image);

        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0.0,
            leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right:15),
                child: TextButton(onPressed: (){

                  if(_formKey.currentState!.validate())
                  {

                    UserCubit.get(context).uploadProfileImage(
                         name.value.text,
                         age.value.text,
                         phone.value.text,
                         pass.value.text,
                         address.value.text,
                         bio.value.text,
                    );
                   // UsersInfoCubit.get(context).getUserData();
                  }
                }, child: Text('UPDATE')),
              )],
            title:  Text('Edit Profile',
              style: TextStyle(color: Colors.black),),),
          body: ConditionalBuilder(
            condition:state is! UserGetLoadingState ,
            builder: (context)
            {
              return Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        if(state is UsersUpdateProfileInfoLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(height: 10,),
                        Container(
                          height: 220,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height:170.0 ,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft:  Radius.circular(4.0),
                                          topRight:  Radius.circular(4.0),
                                        ),
                                        image:DecorationImage(
                                            image: NetworkImage('https://thumbs.dreamstime.com/b/bad-hair-day-crazy-young-woman-touching-head-looking-camera-her-funny-brunette-emotionally-reacting-to-news-standing-202075257.jpg') ,
                                            fit: BoxFit.cover),

                                      ),

                                    ),
                                    IconButton(onPressed: (){},
                                      icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(Icons.camera,size: 16,)
                                        ,),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [

                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(radius: 60.0,
                                      backgroundImage: (profileImage ==null)?NetworkImage('${userModel!.image}'):Image.file(profileImage).image,
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    UserCubit.get(context).getProfileImage();
                                  },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(Icons.camera,size: 16,)
                                      ,),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15,),
                        TextFromFiled(Icon(Icons.person), name, 'Name', 'enter your name',TextInputType.name,'Please Enter Your name'),
                        SizedBox(height: 15,),
                        TextFromFiled(Icon(Icons.account_circle_outlined), age, 'Age', 'enter your age',TextInputType.number,'Please Enter Your age'),
                        SizedBox(height: 15,),
                        TextFromFiled(Icon(Icons.phone), phone, 'Phone', 'enter your phone ',TextInputType.phone,'Please Enter Your phone'),
                        SizedBox(height: 15,),
                        TextFromFiled(Icon(Icons.location_on_outlined), address, 'Address', 'enter your Address',TextInputType.streetAddress,'Please Enter Your address'),
                        SizedBox(height: 15,),

                        TextFromFiled(Icon(Icons.edit), bio, 'Bio', 'enter your Bio',TextInputType.emailAddress,'Please Enter Your Bio'),
                        SizedBox(height: 15,),

                        //TextFromFiled(Icon(Icons.email_outlined), email, 'Email', 'enter your email',TextInputType.emailAddress,'Please Enter Your Email Address'),
                        SizedBox(height: 15,),
                        TextFromFiled(Icon(Icons.lock), pass, 'Password', 'enter your password',TextInputType.visiblePassword,'Please Enter Your Password',isScure: isScure,suficon:isScure?Icon(Icons.visibility_off):Icon(Icons.visibility),suffixPressed: (){
                          setState(() {
                            isScure=!isScure; ;
                          });}),

                      ],),
                    ),
                  ),
                ),
              );
            },
            fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),
          ),
        );
      },
    );
  }
}
