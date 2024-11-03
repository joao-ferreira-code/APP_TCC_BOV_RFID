
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'PaletaCores.dart';

class InputTipo{

  static Color textColor = Colors.black;
  static Color labelHint = Colors.grey;
  static double fontSize = 14.0;

  static Color? iconColor = Palette.main.shade300;

  static double paddingAltura = 7;
  static double paddingLargura = 0;

//====================================================================================================================//

  static createInputFull(
      {required String textoConteudo,
        required TextEditingController variavelArmazenaDado,
        required TextInputType inputType,
        required bool validar,
        required double tamCirculoBorda,
        VoidCallback? onPressed, //caso senha

        String? textoCabecalho,
        int? limiteMinText,
        int? limiteMaxText,

        int? minLinhas,
        int? maxLinhas,

        IconData? icon,
        List<TextInputFormatter>? inputFormatters,
        ValueChanged<String>? onFieldSubmitted,

        bool? isTextoVisivel,
        bool? isSenha,
      }) {

    if(icon==null){
      icon = Icons.text_fields;
    }if(validar == null){
      validar = false;
    }if(onFieldSubmitted ==null){
      onFieldSubmitted = (value){};
    }if(limiteMinText==null){
      limiteMinText = 1;
    }if(textoCabecalho==null){
      textoCabecalho = textoConteudo;
    }if(minLinhas==null){
      minLinhas = 1;
    }if(maxLinhas==null){
      maxLinhas = 1;
    }if(isTextoVisivel==null){
      isTextoVisivel = false;
    }if(isSenha==null){
      isSenha = false;
    }

    return TextFormField(
      inputFormatters: inputFormatters,
      controller: variavelArmazenaDado,
      keyboardType: inputType,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: limiteMaxText,
      minLines: minLinhas,
      maxLines: maxLinhas,
      obscureText: isTextoVisivel,

      style: TextStyle(color: textColor),

      decoration: InputDecoration(
        counterText: '',

        labelText: textoCabecalho,
        labelStyle: TextStyle( color: Colors.grey, fontSize: fontSize, fontWeight: FontWeight.bold ),

        hintText: textoConteudo,
        hintStyle: TextStyle( color: Colors.grey, fontSize: fontSize, fontWeight: FontWeight.bold ),

        filled: true, fillColor: Color(0xbfffffff),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(tamCirculoBorda)),
        ),
        prefixIcon: Container(
            padding: EdgeInsets.only(left: 12, right: 10), child: Icon(icon, color: iconColor)
        ),

        suffixIcon: isSenha ? IconButton(padding: EdgeInsets.only(right: 12),
            icon: Icon( isTextoVisivel ? Icons.visibility : Icons.visibility_off ),
            onPressed: onPressed
          ):Text(""),
      ),

      validator: (text) {
        if(validar){
          if (text!.isEmpty)
            return "Campo Obrigatório!";

          if (limiteMinText != null && text.toString().replaceAll(" ", "").length < limiteMinText)
            return "Obrigatório possuir no minimo ${limiteMinText} caractere.";

          if(inputType == TextInputType.emailAddress && (!text.contains("@") || text.length<11) ){
              return "E-mail inválido!";
          }
        }
      },
    );

  }

//====================================================================================================================//

  static createInputAreaText(
      {required String textoConteudo, String? textoCabecalho,
        required TextInputType inputType,
        required TextEditingController variavelArmazenaDado,
        required bool validar,

        double? tamCirculoBorda,
        IconData? icon,
        int? limiteText,
        double? padLargura,
        double? padAltura,
        List<TextInputFormatter>? inputFormatters,
      }) {

    if(padLargura == null){
      padLargura = paddingLargura;
    }if(padAltura ==  null){
      padAltura = paddingAltura;
    }if(tamCirculoBorda ==  null){
      tamCirculoBorda = 20;
    }

    return Padding(
      padding: new EdgeInsets.only(left: padLargura, right: padLargura, top: padAltura, bottom: padAltura),
      child: createInputFull( maxLinhas: 5, minLinhas: 3,
          textoConteudo: textoConteudo, textoCabecalho: textoCabecalho, inputType: TextInputType.multiline,
          variavelArmazenaDado: variavelArmazenaDado, validar: validar,
          icon: icon, tamCirculoBorda: tamCirculoBorda, inputFormatters: inputFormatters,
      ),
    );

  }

//====================================================================================================================//

  static createInputText(
      {required String textoConteudo, String? textoCabecalho,
        required TextInputType inputType,
        required TextEditingController variavelArmazenaDado,
        required bool validar,

        IconData? icon,
        int? limiteText,
        double? padLargura,
        double? padAltura,
        List<TextInputFormatter>? inputFormatters,

        ValueChanged<String>? onFieldSubmitted,
      }) {

    if(padLargura == null){
      padLargura = paddingLargura;
    }if(padAltura ==  null){
      padAltura = paddingAltura;
    }if(onFieldSubmitted ==null){
      onFieldSubmitted = (value){};
    }

    return Padding(padding: new EdgeInsets.only(left: padLargura, right: padLargura, top: padAltura, bottom: padAltura),
      child: createInputFull(
          textoConteudo: textoConteudo, textoCabecalho: textoCabecalho, inputType: inputType,
          variavelArmazenaDado: variavelArmazenaDado, validar: validar,
          icon: icon, tamCirculoBorda: 25.0, inputFormatters: inputFormatters, onFieldSubmitted: onFieldSubmitted
      ),
    );

  }

//====================================================================================================================//


  static createInputSenha(
      { required String textoConteudo, String? textoCabecalho,
        required TextInputType inputType,
        required TextEditingController variavelArmazenaDado,
        required bool validar,
        required bool senhaVisivel,
        VoidCallback? onPressed,
        IconData? icon,
        int? limiteText,
        double? padLargura,
        double? padAltura,
        List<TextInputFormatter>? inputFormatters,

        ValueChanged<String>? onFieldSubmitted,
      }) {

    if(onFieldSubmitted ==null){
      onFieldSubmitted = (value){};
    }if(padLargura == null){
      padLargura = paddingLargura;
    }if(padAltura ==  null){
      padAltura = paddingAltura;
    }

    return Padding(padding: new EdgeInsets.only(left: padLargura, right: padLargura, top: padAltura, bottom: padAltura),
      child: createInputFull(
          isTextoVisivel: !senhaVisivel, onPressed: onPressed, onFieldSubmitted: onFieldSubmitted, isSenha: true,
          textoConteudo: textoConteudo, textoCabecalho: textoCabecalho, inputType: inputType,
          variavelArmazenaDado: variavelArmazenaDado, validar: validar,
          icon: icon, tamCirculoBorda: 25.0, inputFormatters: inputFormatters
      ),
    );

  }

//====================================================================================================================//


}