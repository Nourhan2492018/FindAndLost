import 'package:find_and_lost/components/toast.dart';
import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';

class TxtBox extends StatefulWidget {
  var txtController;
  TextInputType keyboardType;
  IconData icon;
  String label;
  bool visible = false;
  TxtBox({
    required this.label,
    required this.txtController,
    required this.keyboardType,
    required this.icon,
  });

  @override
  State<TxtBox> createState() => _TxtBoxState();
}

class _TxtBoxState extends State<TxtBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.textBoxBackgroundColor,
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            MyToast.getToast("Please fill data");
            return;
          }
          return null;
        },
        controller: widget.txtController,
        keyboardType: widget.keyboardType,
        obscureText:
        widget.keyboardType == TextInputType.visiblePassword ? (widget.visible == true ? false : true) : false,
        cursorColor: AppColor.defaultColor,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: widget.keyboardType == TextInputType.visiblePassword ? IconButton(
              onPressed: (){
                setState(() {
                  widget.visible =!widget.visible;
                });
              },
              icon: widget.visible == true? Icon(Icons.visibility, color: AppColor.iconsColor,):Icon(Icons.visibility_off,color: AppColor.iconsColor,)): null,
          prefixIcon: Icon(
            widget.icon,
            color: AppColor.iconsColor,
          ),
          labelStyle: TextStyle(
            color: AppColor.txtShade,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColor.defaultColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.defaultColor,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
