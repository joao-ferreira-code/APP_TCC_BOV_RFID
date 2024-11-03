
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaletaCores.dart';

class Paineis{

//====================================================================================================================//

  static Pagina( {required BuildContext context,  required Widget child, bool? isPlanoFundo_01, AlignmentGeometry? alignment } ) {
    if(alignment == null){
      alignment = Alignment.center;
    }

    if(isPlanoFundo_01 ==null ){
      return Pagina_Padrao( context: context, child: child, alignment: alignment );
    }else if(isPlanoFundo_01){
      return Pagina_PlanoFundo_01( context: context, child: child, alignment: alignment );
    }else{
      return Pagina_PlanoFundo_02( context: context, child: child, alignment: alignment );
    }
  }

//====================================================================================================================//

  static Pagina_Padrao( {required BuildContext context, required Widget child, required AlignmentGeometry? alignment } ) {
    return Container( color: Palette.main.shade100,
        alignment: alignment,
        child: SingleChildScrollView( scrollDirection: Axis.vertical,
            child: child
        )
    );
  }

//====================================================================================================================//

  static Pagina_PlanoFundo_01(
      {required BuildContext context, required Widget child, required AlignmentGeometry? alignment} ){

    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(alignment: Alignment.topCenter,
              angle: 35,
              child: Row(children: [
                Image.asset(width: 250, height: 250,
                    "imagens/undraw_handcrafts_tree.png"
                ),
                //Expanded(child: Text("")),
              ],),
            ),

            Expanded(child: Text("")),

            Row(children: [
              Image.asset(width: 250, height: 250,
                  "imagens/undraw_handcrafts_tree.png"
              ),
              Expanded(child: Text("")),
            ],),
        ],),

        Container( alignment: alignment, color: Palette.main.shade100,
          child: SingleChildScrollView( scrollDirection: Axis.vertical,
            child: child
          )
        ),

      ]
    );
  }

//====================================================================================================================//

  static Pagina_PlanoFundo_02(
      {required BuildContext context, required Widget child, required AlignmentGeometry? alignment} ){

    return Container( alignment: alignment,
        child: SingleChildScrollView( scrollDirection: Axis.vertical,
            child: child
        )
    );
  }

//====================================================================================================================//
  static Pagina_Statica(
      {required BuildContext context, required Widget child} ){
    return Container( alignment: Alignment.center,
        child: child
    );
  }

//====================================================================================================================//

  static appBar( {required BuildContext context, required String text} ){

    return AppBar( foregroundColor: Palette.main.shade300, backgroundColor: Palette.main.shade200,
      title: Text( text, style: TextStyle(fontWeight: FontWeight.bold,) ),
    );
  }

//====================================================================================================================//


}