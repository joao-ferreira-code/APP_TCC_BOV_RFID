
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import '../componentes/Textos.dart';
import 'PoliticaPrivacidade_PageView.dart';

class SobreAPP_PageView extends StatefulWidget {
  const SobreAPP_PageView({Key? key}) : super(key: key);

  @override
  _SobreAPP_PageView createState() => _SobreAPP_PageView();
}

//============================================================================//

class _SobreAPP_PageView extends State<SobreAPP_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: "Sobre APP"),

      body:Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column( children: [

              SizedBox( height: 25.0, ),

              Texto.titulo(context: context, title: "Next"),

              SizedBox( height: 20.0, ),

              Container(
                width: 175, height: 175,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(88.0)),
                  border: new Border.all(
                    color: Colors.black87,
                    width: 1.0,
                  ),
                ),
              ),


              SizedBox( height: 30.0, ),

              Text('Versão 1.0.0', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Palette.colorBeckground),),


              SizedBox( height: 90.0, ),

              TextButton(
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute( builder: (context) => PoliticaPrivacidade_PageView()), );
                },
                child: const Text('Política de Privacidade', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blueAccent)),
              ),


              SizedBox( height: 10.0, ),

              Text('Copyright © 2022 - by Joao Ferreira.\n', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),

              SizedBox( height: 20.0, ),


            ],
          )
        )
      )
    );
  }

//=========================================================================================//

}