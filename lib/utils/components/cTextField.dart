import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CtextField{

  static CoustomeTextField(
      String hint,
      TextEditingController controller,
      TextInputType type,
      IconData piconData,

      )
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 13),
      child: TextFormField(
        obscureText:false ,
        controller: controller,
        keyboardType:type ,
       validator: (value)
        {
         if(value==null || value.isEmpty)
           {
             return 'please enter valid data';
           }
         return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(piconData,),
            hintText: hint,
            labelText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            )

      ),
      )
    ) ;
  }

}