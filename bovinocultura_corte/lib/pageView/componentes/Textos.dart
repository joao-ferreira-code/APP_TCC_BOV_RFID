
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/material.dart';

class Texto{

//====================================================================================================================//

  static titulo({required BuildContext context, required String title, double? fontSize, FontWeight? fontWeight, Color? color}){

    if(fontSize==null){
      fontSize = 30.0;
    }if(fontWeight==null){
      fontWeight = FontWeight.bold;
    }if(color==null){
      color = Colors.black;
    }

    return Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),);

  }

//====================================================================================================================//

  static subtitulo({required BuildContext context, required String title, double? fontSize, FontWeight? fontWeight, Color? color}){

    if(fontSize==null){
      fontSize = 26.0;
    }if(fontWeight==null){
      fontWeight = FontWeight.bold;
    }if(color==null){
      color = Colors.indigo;
    }

    return Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),);

  }

//====================================================================================================================//

  static textoButton({required BuildContext context, required String title, VoidCallback? onPressed,}){
    return TextButton(
      onPressed: onPressed,
      child:Text(title,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }

  static textoPadrao({ required String title, double? fontSize}){
    if(fontSize == null){
      fontSize = 12.0;
    }
    return Text(title, style: TextStyle(fontSize: fontSize),);
  }

//====================================================================================================================//

  static referenciaConteudo({ required String referencia, required String conteudo, fontSize}){
    if(fontSize == null){
      fontSize = 12.0;
    }

    return Row(
        children: [
      Text( "${referencia}: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Palette.primary.shade500),) ,
      Text( "${conteudo}", style: TextStyle(fontSize: fontSize), )
    ]);
  }

//====================================================================================================================//

}