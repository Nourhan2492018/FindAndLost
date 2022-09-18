
import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';

class LostOrFoundContainer extends StatefulWidget {
  final String image;
  final String text;
  final bool selected;
  const LostOrFoundContainer({required this.image,required this.text,required this.selected,Key? key}) : super(key: key);

  @override
  State<LostOrFoundContainer> createState() => _LostOrFoundContainerState();
}

class _LostOrFoundContainerState extends State<LostOrFoundContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: widget.selected? AppColor.defaultColor: AppColor.questionsShade,width: widget.selected? 3 : 2),
      ),
      width: MediaQuery.of(context).size.width/2.34,
      height: MediaQuery.of(context).size.height/5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 11.0,top: 7.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.verified_rounded,color: widget.selected? AppColor.defaultColor : AppColor.secondaryColor),
            ),
          ),
          Image(
            image: AssetImage(widget.image),
            width: 100,
            height: 100,
          ),
          Text(
              widget.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}