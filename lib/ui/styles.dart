import 'package:flutter/material.dart';

TextStyle textStyle(){
  return TextStyle(
    color: Colors.white
  );
}

InputDecoration inputDecoration(){
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.white
      )
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.white
      )
    ),
  );
}

ButtonStyle buttonStyle(){
  return ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.black),
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )
    )
  );
}