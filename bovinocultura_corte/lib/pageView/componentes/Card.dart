
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaletaCores.dart';
import 'Textos.dart';

class Cards{
//----------------------------------------------------------------------------------------------------//

  static padrao(
      {required String text, required VoidCallback? onPressed, Color? textColor,
        double? fontSize, IconData? icon, iconColor, double? larg}) {

    return Card(child:
      Row(children: [
        Texto.textoPadrao(title: text),
        Expanded(child: Text("")),
        Icon(Icons.arrow_right_sharp)
      ],)
    );
  }

//----------------------------------------------------------------------------------------------------//

  static click({required String text, required VoidCallback? onPressed, Color? textColor,
    double? fontSize, IconData? icon, iconColor, double? larg}) {

    if(icon==null){
      icon = Icons.ac_unit;
    }if(iconColor==null){
      iconColor = Palette.main.shade900;
    }
    if(larg == null){
      larg = 10;
    }

    return Card(child:
      InkWell(onTap: onPressed,
        child:
        Row(children: [
          Padding(padding: EdgeInsets.only( left: 12.0, right: 12.0, top: larg, bottom: larg),
              child: Icon(icon, color: iconColor, )
          ),
          Text(text, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
          Expanded(child: Text("")),
          Icon(Icons.arrow_right_sharp)
        ],)
      )
    );
  }

//----------------------------------------------------------------------------------------------------//
}