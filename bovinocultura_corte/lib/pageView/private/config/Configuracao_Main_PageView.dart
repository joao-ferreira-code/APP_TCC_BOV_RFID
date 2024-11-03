
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dataModel/Usuario.dart';
import '../../componentes/Card.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Paineis.dart';

class Configuracao_Main_PageView extends StatefulWidget {
  const Configuracao_Main_PageView({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  _Configuracao_Main_PageView createState() => _Configuracao_Main_PageView();
}

//============================================================================//

class _Configuracao_Main_PageView extends State<Configuracao_Main_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Pesagem'), ),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Cards.click(text: ">><<", icon: Icons.add,
                onPressed: (){
                  /*Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewPesagem_PageView(usuario: widget.usuario,)),
                  );*/
                },
              ),

              Cards.click(text: "<<>>", icon: Icons.search,
                onPressed: (){
                  /*Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => LoteVacina_PageView()),
                  );*/
                },
              ),


            ],
          )
        ),

      )
    );
  }

//=========================================================================================//

  emDesenvolvimento() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Em Desenvolvimeno!'),
            content: const Text(
                'Funcionalidade em desenvolvimento, solicitamos que aguarde atualizações!'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary: Colors.teal,),
                onPressed: () {
                  Navigator.pop(context, "Ok");
                },
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }

//=========================================================================================//

}