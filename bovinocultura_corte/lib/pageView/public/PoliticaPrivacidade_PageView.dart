
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import 'TermosDeServico_PageView.dart';

class PoliticaPrivacidade_PageView extends StatefulWidget {
  const PoliticaPrivacidade_PageView({Key? key}) : super(key: key);

  @override
  _PoliticaPrivacidade_PageView createState() =>  _PoliticaPrivacidade_PageView();
}

//============================================================================//

class _PoliticaPrivacidade_PageView extends State<PoliticaPrivacidade_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: "Política de Privacidade"),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),

              Row(children: [
                Expanded(child: Text("")),
                TextButton(
                  style: TextButton.styleFrom( primary: Colors.blue, textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  onPressed: () {
                    Navigator.push( context,
                      MaterialPageRoute(
                          builder: (context) => TermosDeServico_PageView()),
                    );
                  },
                  child: const Text('Termo de Uso', ),
                ),
                Icon( Icons.search, color: Palette.main, size: 30),
              ],),

              SizedBox( height: 20.0, ),


              Text('POLÍTICA DE PRIVACIDADE', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,),
              SizedBox( height: 18.0, ),


              Text('SEÇÃO 01 - INFORMAÇÕES GERAIS', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,),
              SizedBox( height: 18.0, ),

              Text('SEÇÃO 02 - COMO RECOLHEMOS OS DADOS PESSOAIS DO USUÁRIO E DO VISITANTE?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

              SizedBox( height: 18.0, ),
              Text('SEÇÃO 03 - QUAIS DADOS PESSOAIS RECOLHEMOS SOBRE O USUÁRIO E VISITANTE?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

              SizedBox( height: 18.0, ),
              Text('SEÇÃO 04 - PARA QUE FINALIDADES UTILIZAMOS OS DADOS PESSOAIS DO USUÁRIO E VISITANTE?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

              SizedBox( height: 18.0, ),
              Text('SEÇÃO 05 - POR QUANTO TEMPO OS DADOS PESSOAIS FICAM ARMAZENADOS?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

              SizedBox( height: 18.0, ),
              Text('SEÇÃO 6 - SEGURANÇA DOS DADOS PESSOAIS ARMAZENADOS',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),
              SizedBox( height: 10.0, ),

            ],

          ),
        ),
      )

    );

  }

//=========================================================================================//

}
