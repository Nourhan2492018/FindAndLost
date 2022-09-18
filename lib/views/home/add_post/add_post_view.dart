import 'package:find_and_lost/blocs/post/post_cubit.dart';
import 'package:find_and_lost/components/submit_button_decoration.dart';
import 'package:find_and_lost/components/list_of_items.dart';
import 'package:find_and_lost/components/lost_or_found_countainer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_and_lost/views/google_map/map_view.dart';

import '../../../blocs/post/post_state.dart';
import '../../../src/app_color.dart';
import 'make_mcq_screen.dart';


class AddPostView extends StatefulWidget {

  AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  bool isLost = true;

  String location = 'Location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                        children: [
                          InkWell(
                              onTap: (){isLost = true;setState(() {});},
                              child: LostOrFoundContainer(image: 'assets/images/lost.png', text: 'Lost',selected: isLost)
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap: (){isLost = false;setState(() {});},
                              child: LostOrFoundContainer(image: 'assets/images/found.png',text: 'Found',selected: !isLost)
                          )
                        ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child:  ListOfAvailableItems(isLost: isLost),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                        isLost == true ? 'Where have you lost it ?': 'Where have you found it ?',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Container(
                    width: double.infinity,
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
                      textColor: location == "Location"
                          ? AppColor.txtShade
                          : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35, bottom: 20,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: const TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          cursorColor: AppColor.defaultColor,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.defaultColor),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),

                  if(PostCubit.get(context).postImageFile!=null)
                    isLost ?Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height:250.0 ,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image:DecorationImage(
                                image:Image.file(PostCubit.get(context).postImageFile!).image,
                                fit: BoxFit.cover),

                          ),

                        ),
                        IconButton(onPressed: (){

                          PostCubit.get(context).RemovePostImage();
                        },
                          icon: CircleAvatar(
                            backgroundColor:Colors.redAccent ,
                            radius:10,
                            child: Icon(Icons.close,size:13,)
                            ,),
                        ),
                      ],
                    ) : Container(),
                  SizedBox(height:25,),
                  isLost?  Row(
                    children: [
                      Expanded(child:TextButton(onPressed: (){
                        PostCubit.get(context).getpostImage();
                      },
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              Icons.image,
                            color: AppColor.defaultColor,
                          ),
                          SizedBox(width:5,),
                          Text(
                              'Add Pohto',
                            style: TextStyle(
                              color: AppColor.defaultColor,
                            ),
                          ),

                        ],
                      ),
                      ),
                      ),
                    ],
                  ) : Container(),

                  SizedBox(
                    height:isLost? 10: 57,
                  ),
                  Center(
                    child:SubmitButtonDecoration(
                      child: isLost ? MaterialButton(
                        onPressed: () {},
                        child: Text('Share'),
                        textColor: AppColor.secondaryColor,
                      ) : MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MakeMcqScreen()),);
                        },
                        child: Text('Make MCQ'),
                        textColor: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
