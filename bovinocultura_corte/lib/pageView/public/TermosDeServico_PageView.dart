
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import 'PoliticaPrivacidade_PageView.dart';

class TermosDeServico_PageView extends StatefulWidget {
  const TermosDeServico_PageView({Key? key}) : super(key: key);

  @override
  _TermosDeServico_PageView createState() =>  _TermosDeServico_PageView();
}

//============================================================================//

class _TermosDeServico_PageView extends State<TermosDeServico_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ("Termo de Uso"),),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 15,),
              Row(children: [
                Expanded(child: Text("")),
                TextButton(
                  style: TextButton.styleFrom( primary: Colors.blue, textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ),
                  onPressed: () {
                    Navigator.push( context,
                      MaterialPageRoute(
                          builder: (context) => PoliticaPrivacidade_PageView()), );
                  },
                  child: const Text('Politica Privacidade'),
                ),
                Icon( Icons.search, color: Palette.main, size: 30),
              ],),

              SizedBox( height: 20.0, ),


              Text('TERMOS E CONDIÇÕES DE USO', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,),
              SizedBox( height: 18.0, ),

              SizedBox( height: 18.0, ),
              Text('SEÇÃO 01 - DO OBJETIVO',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),


              SizedBox( height: 18.0, ),
              Text('SEÇÃO 02 - DA ACEITAÇÃO',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),


              SizedBox( height: 18.0, ),
              Text('SEÇÃO 03 - DO ACESSO DOS USUARIOS',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),


              SizedBox( height: 18.0, ),
              Text('SEÇÃO 04 - DO CADASTRO',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),



            ],

          ),
        ),
      )

    );

  }

//=========================================================================================//

}
