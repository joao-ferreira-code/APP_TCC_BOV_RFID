
import 'package:bovinocultura_corte/pageView/private/animal/vacinacao/Resumo_Vacinacao_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Card.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Paineis.dart';
import 'List_ConsultaVacinacao_PageView.dart';
import 'NewVacinacao_PageView.dart';

class Vacinacao_Main_PageView extends StatefulWidget {
  const Vacinacao_Main_PageView({Key? key, required this.usuario, required this.fazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _Vacinacao_Main_PageView createState() => _Vacinacao_Main_PageView();
}

//============================================================================//

class _Vacinacao_Main_PageView extends State<Vacinacao_Main_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Vacinação'), ),
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
                        builder: (context) => NewVacinacao_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda)),
                  );
                },
              ),

              Cards.click(text: "Consultar", icon: Icons.search,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_ConsultaVacinacao_PageView(
                              usuario: widget.usuario, fazenda: widget.fazenda)),
                  );
                },
              ),

              Cards.click(text: "Resumo", icon: Icons.account_balance_wallet_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Resumo_Vacinacao_PageView(
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