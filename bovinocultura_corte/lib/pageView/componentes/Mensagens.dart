
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Botoes.dart';

class Mensagens {

//====================================================================================================================//

  static ComportamentoInesperado(
      {required BuildContext context, required VoidCallback tentarNovamente, VoidCallback? contatarSuporte,}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .7,
              decoration: new BoxDecoration(color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),),
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 25.0, left: 5.0, right: 5.0),
                  child: Column(
                      children: [

                        Icon(Icons.check_circle, color: Colors.red, size: 50,),

                        SizedBox(height: 5,),
                        Text("Oops...", style: TextStyle(fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),),
                        SizedBox(height: 25,),

                        Container(child: Text(
                          "Comportamento Inesperado.\nTente novamente ou contate nosso "
                              "time de suporte para solicitar ajuda.",
                          style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center,),),

                        SizedBox(height: 30,),

                        BotaoTipo.padrao(text: ' Tentar Novamente ',
                          onPressed: tentarNovamente,),

                        SizedBox(height: 10,),

                        BotaoTipo.desfocado(text: '  Contatar Suporte  ',
                            onPressed: () {
                              /*Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SupportTecnico_PageView()),
                              );*/
                            }
                        ),

                      ]
                  )
              )

          ),

        ]
    );
  }

//====================================================================================================================//

  static DialogoInformativo_OK(
      {required BuildContext context, required String title, required String content,}) {

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content, textAlign: TextAlign.justify),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom( primary: Colors.black54, ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),

        ],
      ),
    );
  }


  static DialogoInformativo_SIM_NAO(
      {required BuildContext context, required String title, required String content,
                      required VoidCallback? onPressed_Sim, VoidCallback? onPressed_Nao}) {

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom( primary: Colors.black54, ),
            onPressed: () {
              Navigator.pop(context);
              onPressed_Sim;
            },
            child: const Text('Sim'),
          ),

          TextButton(
            style: TextButton.styleFrom( primary: Colors.teal, ),
            onPressed: () {
              Navigator.pop(context,"Não");
              onPressed_Nao;
            },
            child: const Text('Não'),
          ),

        ],
      ),
    );
  }

//=================================================================================================================//

  static rodape({required BuildContext context, required String msg}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${msg}"),backgroundColor: Colors.green.shade800,
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      )
    );
  }

//=================================================================================================================//

}