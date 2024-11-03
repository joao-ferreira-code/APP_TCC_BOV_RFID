
import 'package:bovinocultura_corte/clienteService/Inventario/TagRFID_Service.dart';
import 'package:bovinocultura_corte/pageView/private/inventario/tags/NewLoteTagRFID_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteTagRFID.dart';
import '../../../../dataModel/inventario/TagRFID.dart';
import '../../../componentes/Card.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';
import 'NewTagRFID_PageView.dart';

class Detalhe_LoteTagRFID_PageView extends StatefulWidget {
  const Detalhe_LoteTagRFID_PageView({Key? key, required this.usuario, required this.fazenda, required this.loteTag }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final LoteTagRFID loteTag;

  @override
  _Detalhe_LoteTagRFID_PageView createState() => _Detalhe_LoteTagRFID_PageView();
}

//============================================================================//

class _Detalhe_LoteTagRFID_PageView extends State<Detalhe_LoteTagRFID_PageView> {

  List<TagRFID> listTagsRFID = [];


//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadTagsByLote();
  }

//----------------------------------------------------------------------------//

  loadTagsByLote() async {
    try {
      listTagsRFID = [];

      List<TagRFID> list = await TagRFID_Service
          .getInstance().getAllByFazendaAndLote(fkLote: widget.loteTag.pkLoteTag!,
          fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        listTagsRFID = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK(
          context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Lote Tag RFID'),),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context) .size .width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 15),

              Row(children: [
                Expanded(child: SizedBox(height: 1,)),
                IconButton(onPressed: editActionLote, icon: Icon(Icons.edit_outlined),tooltip: "Editar Dados!", color: Palette.primary.shade500),
              ],),

              Texto.subtitulo(context: context, title: "Informações do Produto", fontSize: 20),
              SizedBox(height: 15),
              Texto.referenciaConteudo(referencia: "Adesivação", conteudo: "${widget.loteTag.metalica! ? "":"Não "}Metalica."),
              Texto.referenciaConteudo(referencia: "Frequencia", conteudo: "${widget.loteTag.txFrequenciaOperacao}."),
              Texto.referenciaConteudo(referencia: "Funcionamento", conteudo: "${widget.loteTag.txModeloLeitura}"),
              Texto.referenciaConteudo(referencia: "Tamper", conteudo: "${widget.loteTag.tampProof! ? "Proof":"Evidence"}."),
              SizedBox(height: 10),

              Divider(),

              SizedBox(height: 15),
              Texto.subtitulo(context: context, title: "Nota Fiscal", fontSize: 20),
              SizedBox(height: 15),

              Texto.referenciaConteudo(referencia: "Unidades", conteudo: "${widget.loteTag.nrUnidades}."),
              Texto.referenciaConteudo(referencia: "Valor Unidade", conteudo: "R\$ ${ (widget.loteTag.nrValorPago! / widget.loteTag.nrUnidades!).toStringAsFixed(2) }."),
              Texto.referenciaConteudo(referencia: "Valor Total", conteudo: "R\$ ${widget.loteTag.nrValorPago!.toStringAsFixed(2)}."),
              SizedBox(height: 10),

              Divider(),

              Texto.referenciaConteudo(referencia: "Observação", conteudo: "${widget.loteTag.txObservacaoResumo}."),

              Divider(),

              Texto.textoPadrao(title: "Cadastrado em: ${widget.loteTag.dtCadastro}",fontSize: 10),

              Divider( color: Colors.black),

              Texto.subtitulo(context: context, title: "Tags Cadastradas", fontSize: 20),
              SizedBox(height: 5),

              Cards.click(text: "Associar Tags", icon: Icons.sim_card_outlined,
                  onPressed: associarTagAction
              ),


              SizedBox(height: 10),

              Expanded(child: listTags() ),
              
              Container(height: 25, child: Texto.titulo(title: "TAGs associadas: ${listTagsRFID.length}.", fontSize: 14, context: context,),)


            ],
          )
        ),

      )
    );
  }

  Widget listTags() {

    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listTagsRFID.length,
      itemBuilder: (context, index) {

        return Card(child:
          InkWell(
            onTap: () => editActionTAG(listTagsRFID[index]),
            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Texto.referenciaConteudo(referencia: "Cod. EPC", conteudo: "${listTagsRFID[index].txCodigoEpc}"),
                Texto.referenciaConteudo(referencia: "Data Cadastro", conteudo: "${listTagsRFID[index].dtCadastro}"),
                SizedBox(height: 3,),
                Row(children: [
                  Texto.referenciaConteudo(referencia: "Status", conteudo: "${listTagsRFID[index].ativa! ? "Ativa":"Inativada"}"),
                  Expanded(child: Text("")),
                  listTagsRFID[index].dtRemocao != null ?
                    Texto.referenciaConteudo(referencia: "Data Remoção", conteudo: "${listTagsRFID[index].dtRemocao}") :
                    SizedBox(height: 1,),
                ],)

              ]),

            )
          )
        );

      }
    );
  }

//----------------------------------------------------------------------------//

  associarTagAction(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewTagRFID_PageView(usuario: widget.usuario, loteTagRFID: widget.loteTag,)),
    );
  }

//----------------------------------------------------------------------------//

  editActionTAG(TagRFID tagRFID){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewTagRFID_PageView(usuario: widget.usuario,
            loteTagRFID: widget.loteTag, tagRFID: tagRFID,)),
    );
  }

//----------------------------------------------------------------------------//

  editActionLote(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewLoteTagRFID_PageView(usuario: widget.usuario,
          fazenda: widget.fazenda, loteTagRFID: widget.loteTag,)),
    );
  }

//----------------------------------------------------------------------------//

}