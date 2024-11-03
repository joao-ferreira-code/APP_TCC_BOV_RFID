
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';
import 'List_LoteVacinaObrigatoria_PageView.dart';
import 'List_LoteVacinaRotineira_PageView.dart';


class LoteVacina_PageView extends StatefulWidget {
  const LoteVacina_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _LoteVacina_PageView createState() => _LoteVacina_PageView();
}

//============================================================================//

class _LoteVacina_PageView extends State<LoteVacina_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Inventário Vacina'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
            child: loadTab()
        ),

      )
    );
  }

  Widget loadTab(){
    List<Tab> listTabTitle = [];
    List<Widget> listTabWidgets = [];

    listTabTitle.add( Tab(child: Texto.textoPadrao(title: "Obrigatória", fontSize: 14 ), ) );
    listTabWidgets.add( List_LoteVacinaObrigatoria_PageView(usuario: widget.usuario, fazenda: widget.fazenda,) );

    listTabTitle.add( Tab(child: Texto.textoPadrao( title: "Rotineira", fontSize: 14 ), ) );
    listTabWidgets.add( List_LoteVacinaRotineira_PageView(usuario: widget.usuario, fazenda: widget.fazenda,) );


    return DefaultTabController(
          length: listTabTitle.length,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  backgroundColor: Palette.primary.shade100,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    tabs: listTabTitle,
                  ),
                ),
              ),
              body: TabBarView(
                children: listTabWidgets,
              )),

    );
  }

//=========================================================================================//

}