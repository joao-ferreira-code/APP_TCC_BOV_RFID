
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import '../componentes/Textos.dart';


class Creditos_PageView extends StatefulWidget {
  const Creditos_PageView({Key? key}) : super(key: key);

  @override
  _Creditos_PageView createState() => _Creditos_PageView();
}

//============================================================================//

class _Creditos_PageView extends State<Creditos_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: 'Creditos'),

      body:Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column( children: [

              SizedBox( height: 25.0, ),

              Texto.titulo(context: context, title: "CREDITOS"),

              SizedBox( height: 20.0, ),

              Texto.textoPadrao(title: "Reservamos um ambiente especial para todos aqueles que nós ajudaram diretamente e/ou indiretamente neste projeto."),

              Row(children: [
                Icon(Icons.email_outlined),
                TextButton(
                  onPressed: () { //PoliticaPrivacidade_PageView
                    //Navigator.push( context,
                      //MaterialPageRoute( builder: (context) => PoliticaPrivacidade_PageView()), );
                  },
                  child: const Text('Nome organizacao ou Pessoa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blueAccent)),
                ),
              ],),

              Row(children: [
                Icon(Icons.email_outlined),
                TextButton(
                  onPressed: () { //PoliticaPrivacidade_PageView
                    //Navigator.push( context,
                      //MaterialPageRoute( builder: (context) => PoliticaPrivacidade_PageView()), );
                  },
                  child: const Text('Nome organizacao ou Pessoa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blueAccent)),
                ),
              ],),



              SizedBox( height: 20.0, ),


            ],
          )
        )
      )
    );
  }

//=========================================================================================//

}