
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dataModel/Usuario.dart';
import '../../../dataModel/fazenda/Fazenda.dart';
import '../../componentes/Card.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/PaletaCores.dart';
import 'ConsultaAnimal_PageView.dart';
import 'List_Bovino_PageView.dart';
import 'cadastro/NewAnimal_Compra_PageView.dart';
import 'Resumo_Animal_PageView.dart';
import 'cadastro/NewAnimal_Nascido_PageView.dart';
import 'descarte/List_Descarte_Bovino_PageView.dart';

class Animal_Main_PageView extends StatefulWidget {
  const Animal_Main_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _Animal_Main_PageView createState() => _Animal_Main_PageView();
}

//============================================================================//

class _Animal_Main_PageView extends State<Animal_Main_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Animais'), ),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Cards.click(text: "Animais", icon: Icons.list,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_Bovino_PageView(
                          usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Cadasto", icon: Icons.add,
                onPressed: cadastroAnimalAction,
              ),

              Cards.click(text: "Consulta", icon: Icons.search,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => ConsultaAnimal_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Descarte", icon: Icons.delete_forever_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_Descarte_Bovino_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Resumo", icon: Icons.account_balance_wallet_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Resumo_Animal_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              /*Cards.click(text: "Transferencia", icon: Icons.compare_arrows,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => TransferenciaAnimal_PageView(
                          usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),*/

            ],
          )
        ),
      )
    );
  }

//=========================================================================================//

  cadastroAnimalAction(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Cadastrar Animal'),
        actions: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                style: TextButton.styleFrom( primary: Palette.main ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewAnimal_Compra_PageView(usuario: widget.usuario, fazenda: widget.fazenda)),
                  );
                },
                child: const Text('    Compra    '),
              ),
              SizedBox(width: 10,),
              TextButton(
                style: TextButton.styleFrom( primary: Palette.main, ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewAnimal_Nascido_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
                child: const Text('  Nascimento  '),
              ),



          ],)

        ],
      ),
    );
  }

//=========================================================================================//

}