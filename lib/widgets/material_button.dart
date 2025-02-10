import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../utils/palettes.dart';

class Buttons{
  Widget button({required String text,String family = "semibold" ,required Function ontap,bool isValidate = false,double height = 55, Color color = Colors.grey, Color fontColor = Colors.white, double radius = 10}){
    return ZoomTapAnimation(
      end: 0.99,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: isValidate ? BoxDecoration(
        color: palettes.secondary,
        borderRadius: BorderRadius.circular(radius)
        ) : BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius)
        ),
        child: Center(child: Text(text,style: TextStyle(color: fontColor,fontFamily: family,fontSize: 15.5),)),
        ),
      onTap:()=> ontap()
    );
  }

  Widget secondary_button({required String text,required Function ontap}){
    return InkWell(
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(text,style: TextStyle(fontSize: 16,color: palettes.secondary,fontFamily: "semibold"),),
          ),
        ),
        onTap:()=> ontap()
    );
  }
}