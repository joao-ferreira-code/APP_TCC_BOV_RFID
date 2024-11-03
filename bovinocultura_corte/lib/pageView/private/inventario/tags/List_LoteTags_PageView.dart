
import 'package:bovinocultura_corte/clienteService/Inventario/LoteTagRFID_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteTagRFID.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';
import 'Detalhe_LoteTagRFID_PageView.dart';
import 'NewLoteTagRFID_PageView.dart';
import 'NewTagRFID_PageView.dart';

class List_LoteTags_PageView extends StatefulWidget {
  const List_LoteTags_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_LoteTags_PageView createState() => _List_LoteTags_PageView();
}

//============================================================================//

class _List_LoteTags_PageView extends State<List_LoteTags_PageView> {

  List<LoteTagRFID> listLote = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadLotesTags();
  }

//----------------------------------------------------------------------------//

  loadLotesTags() async {
    try{
      listLote = [];
      List<LoteTagRFID> list = await LoteTagRFID_Service.getInstance().
        getAllLoteTagRFIDByFazenda(fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        listLote = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }

  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Inventário RFID'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 20),

              Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: IconButton(onPressed: novoLoteAction, tooltip: "Adicionar Lote.",
                      icon: Icon(Icons.add))
              ),

              SizedBox(height: 10),

            listLote.isEmpty?
              Column(children: [
                SizedBox(height: 40,),
                Texto.textoPadrao(title: "Nenhum Registro Encontrado!", fontSize: 16),
                IconButton(onPressed: loadLotesTags, tooltip: "Atualizar.",
                    icon: Icon(Icons.refresh, color: Palette.colorBeckground)),
              ],):
              Expanded(child: listLotes() )


            ],
          )
        ),

      )
    );
  }


  Widget listLotes() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listLote.length,
      itemBuilder: (context, index) {

        return Card(child:
          InkWell(
          onTap: () => detalhesAction(listLote[index]),
            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

            Row(children: [

              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text( "${listLote[index].txModeloLeitura} - ${listLote[index].txFrequenciaOperacao} - "
                    "${listLote[index].metalica!?"":"Nao"} Metalica - Tamper ${listLote[index].tampProof!?"Proof":"Evidence"}.",
                    style: TextStyle(fontWeight: FontWeight.bold,)),
                Texto.referenciaConteudo(referencia: "Unidades", conteudo: "${listLote[index].nrUnidades}"),
              ]),

              Expanded(child: Text("")),

              Icon(Icons.arrow_right_sharp),

            ],),

            )
          )
        );

      }
    );
  }

//=========================================================================================//

  novoLoteAction(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewLoteTagRFID_PageView(usuario: widget.usuario,fazenda: widget.fazenda,)),
    );
  }

//-----------------------------------------------------------------------------------//

  associarTagAction(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewTagRFID_PageView(usuario: widget.usuario, loteTagRFID: listLote[0],)),
    );
  }

//-----------------------------------------------------------------------------------//

  detalhesAction(LoteTagRFID loteTagRFID) {
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => Detalhe_LoteTagRFID_PageView(usuario: widget.usuario,
            fazenda: widget.fazenda, loteTag: loteTagRFID,)),
    );
  }

//=========================================================================================//

}