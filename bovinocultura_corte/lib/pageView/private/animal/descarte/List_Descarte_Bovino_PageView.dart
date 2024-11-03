
import 'package:bovinocultura_corte/clienteService/bovino/DescarteBovinoService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/VWDadosDescarte.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';
import 'NewDescarteBovino_PageView.dart';

class List_Descarte_Bovino_PageView extends StatefulWidget {
  const List_Descarte_Bovino_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_Descarte_Bovino_PageView createState() => _List_Descarte_Bovino_PageView();
}

//============================================================================//

class _List_Descarte_Bovino_PageView extends State<List_Descarte_Bovino_PageView> {

  bool buscou = false;

  List<VWDadosDescarte> listDescarteBovino = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadBovinosDescartados();
  }

//----------------------------------------------------------------------------//

  loadBovinosDescartados() async {
    try{
      buscou = false;
      listDescarteBovino = [];
      List<VWDadosDescarte> list = await DescarteBovinoService.getInstance().
        getAllByPkFazenda(fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        buscou = true;
        listDescarteBovino = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Consulta Descartes'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            children: [

              SizedBox(height: 10),

              IconButton(icon: Icon(Icons.add),
                tooltip: "Adicionar Descarte.",
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewDescarteBovino_PageView(
                          usuario: widget.usuario, fazenda: widget.fazenda,)),
                  ).then((value) => loadBovinosDescartados());
                },
              ),

              SizedBox(height: 10),

              buscou ?
                listDescarteBovino.isEmpty?
                  Column(children: [
                    SizedBox(height: 40,),
                    Texto.textoPadrao(title: "Nenhum Registro Encontrado!", fontSize: 16),
                    IconButton(onPressed: loadBovinosDescartados, tooltip: "Atualizar.",
                        icon: Icon(Icons.refresh, color: Palette.colorBeckground)),
                  ],):
                  Expanded(child: listBovinos() )
                : Text("...")


            ],
          )
        ),

      )
    );
  }

//----------------------------------------------------------------------------//

  Widget listBovinos() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listDescarteBovino.length,
      itemBuilder: (context, index) {

        return Card(child:
          Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7), child:

            Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${listDescarteBovino[index].txSexo == "M" ? "Macho" : "Femea" }"),
                Texto.referenciaConteudo(referencia: "Raça", conteudo: "${listDescarteBovino[index].txNome}"),
                SizedBox(height: 5,),
                Texto.referenciaConteudo(referencia: "Motivo", conteudo: "${listDescarteBovino[index].txMotivo}"),
                Texto.referenciaConteudo(referencia: "Data", conteudo: "${listDescarteBovino[index].dtPerca}"),
                Texto.referenciaConteudo(referencia: "Observação", conteudo: "${listDescarteBovino[index].txObservacao}"),
            ],),

          )
        );

      }
    );
  }

//=========================================================================================//


}