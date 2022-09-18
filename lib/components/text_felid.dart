import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';
class TextFromFiled extends StatelessWidget {
  final preicon,suficon,type;
  TextEditingController email;
  String label,hint;
  final isScure;
  final  suffixPressed;
  String validError='';
  TextFromFiled(
       this.preicon, this.email, this.label, this.hint, this.type,
      this.validError,{this.isScure=false,this.suficon=null,this.suffixPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: TextFormField(
        validator:  (value) {
          if (value == null || value.isEmpty) {
            return validError;
          }
          return null;
        },
        obscureText: isScure,
        controller: email,
        keyboardType: type,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          prefixIcon: preicon,
          labelText: label,
          suffixIcon:suficon !=null ?IconButton(onPressed: suffixPressed, icon: suficon):null,
          hintText:hint,
        ),
      ),
    );
  }
}
