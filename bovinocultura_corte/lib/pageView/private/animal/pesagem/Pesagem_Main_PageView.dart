
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Card.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Paineis.dart';
import 'List_ConsultaPesagem_PageView.dart';
import 'NewPesagem_PageView.dart';
import 'Resumo_Pesagem_PageView.dart';

class Pesagem_Main_PageView extends StatefulWidget {
  const Pesagem_Main_PageView({Key? key, required this.usuario, required this.fazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _Pesagem_Main_PageView createState() => _Pesagem_Main_PageView();
}

//============================================================================//

class _Pesagem_Main_PageView extends State<Pesagem_Main_PageView> {

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

              Cards.click(text: "Cadasto", icon: Icons.add,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewPesagem_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Consulta", icon: Icons.search,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_ConsultaPesagem_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Resumo", icon: Icons.account_balance_wallet_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Resumo_Pesagem_PageView(
                          usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
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