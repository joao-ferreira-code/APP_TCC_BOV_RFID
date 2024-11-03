
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaletaCores.dart';

class BotaoTipo{

//=========================================== BOTAO SIMPLES ===========================================//

  static createButton(
      {required String? text, required VoidCallback? onPressed, VoidCallback? onLongPress,
        Color? textColor, double? fontSize, double? size, Color? backColor, String? textDescricao,
        Color? shadowColor, double? padding, double? altura}) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backColor == null ? Palette.colorBeckground : backColor,
        onPrimary: textColor == null ? Palette.main.shade300 : textColor,
        shadowColor: shadowColor == null ? Colors.black: shadowColor,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(45)),
        minimumSize: Size(size == null?40:size, altura==null?43:altura),
        maximumSize: Size(size == null?400:size, 43),
        padding: padding==null?EdgeInsets.only(left: 30, right: 30):EdgeInsets.only(left: padding, right: padding),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Text(text!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize==null? 18:fontSize, color: textColor == null ? Palette.main.shade300 : textColor)),
    );

  }

//----------------------------------------------------------------------------------------------------//

  static padrao(
      {required String text, required VoidCallback? onPressed, VoidCallback? onLongPress,
        Color? textColor, double? size, Color? backColor, String? textDescricao,}) {

    return createButton(
        text: text, size: size, textDescricao: textDescricao,
        onPressed: onPressed, onLongPress: onLongPress, textColor: Colors.white);
  }

//----------------------------------------------------------------------------------------------------//

  static desfocado(
      {required String text, required VoidCallback? onPressed, VoidCallback? onLongPress,
        Color? textColor, double? fontSize, double? size, Color? backColor, String? textDescricao,}) {

    return createButton(
        text: text, textColor: Colors.black, fontSize: fontSize,
        size: size, backColor: Colors.grey.shade300/*Color(0xb3ffffff)*/, textDescricao: textDescricao,
        onPressed: onPressed, onLongPress: onLongPress);
  }

//----------------------------------------------------------------------------------------------------//

  static transparente(
      {required String text, required VoidCallback? onPressed, VoidCallback? onLongPress,
        Color? textColor, double? fontSize, double? size, Color? backColor, String? textDescricao,}) {

    print(size);
    return createButton(
        text: text, textColor: textColor==null?Colors.black:textColor, fontSize: fontSize,
        size: size, backColor: Colors.transparent, shadowColor: Colors.transparent, textDescricao: textDescricao,
        onPressed: onPressed, onLongPress: onLongPress);
  }

//=====================================================================================================//

  static fullLinha(
    {required String text, required VoidCallback? onPressed, Color? textColor,
        double? fontSize, IconData? icon, iconColor, double? larg}) {

    if(icon==null){
      icon = Icons.ac_unit;
    }if(iconColor==null){
      iconColor = Palette.main.shade900;
    }

    if(larg == null){
      larg = 5;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0
      ),
      onPressed: onPressed,

      child: Row(
        children: [
          Padding(padding: EdgeInsets.only( left: 0.0, right: 15.0, top: larg, bottom: larg),
              child: Icon(icon, color: iconColor, )
          ),
          Text(text, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
        ]
      ),
    );


  }

//=====================================================================================================//


  static createBlocoPrincipal({Widget? child}) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, .7),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 7),
                blurRadius: 10
            )
            ]
        ),
        child: child
    );
  }

//=====================================================================================================//

}