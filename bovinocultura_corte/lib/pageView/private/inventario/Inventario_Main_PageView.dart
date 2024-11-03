
import 'package:bovinocultura_corte/pageView/private/inventario/tags/List_LoteTags_PageView.dart';
import 'package:bovinocultura_corte/pageView/private/inventario/vacina/LoteVacina_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dataModel/Usuario.dart';
import '../../../dataModel/fazenda/Fazenda.dart';
import '../../componentes/Card.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Paineis.dart';

class Inventario_Main_PageView extends StatefulWidget {
  const Inventario_Main_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _Inventario_Main_PageView createState() => _Inventario_Main_PageView();
}

//============================================================================//

class _Inventario_Main_PageView extends State<Inventario_Main_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Inventário'), ),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Cards.click(text: "Vacinas", icon: Icons.medication_sharp,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => LoteVacina_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),

              Cards.click(text: "Tags RFID", icon: Icons.tag,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_LoteTags_PageView( usuario: widget.usuario, fazenda: widget.fazenda,)),
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