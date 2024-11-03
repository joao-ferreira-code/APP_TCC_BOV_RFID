
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../clienteService/bovino/VacinacaoBovinoService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/animal/VacinacaoBovino.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';

class List_ConsultaVacinacao_PageView extends StatefulWidget {
  const List_ConsultaVacinacao_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_ConsultaVacinacao_PageView createState() => _List_ConsultaVacinacao_PageView();
}

//============================================================================//

class _List_ConsultaVacinacao_PageView extends State<List_ConsultaVacinacao_PageView> {

  final _codigoAnimal = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<VacinacaoBovino> listVacinacao = [];

  bool buscou = false;

  bool isConsultaRFID = false;

  VWBovinoFazenda? vwBovinoFazenda;

//----------------------------------------------------------------------------//

  @override
  void initState() {
  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{
      buscou = false;
      vwBovinoFazenda = VWBovinoFazenda();
      listVacinacao = [];
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );

      if(list.isNotEmpty) {
        vwBovinoFazenda = list[0];
        loadListVacinacao();
      }
      setState(() {
        buscou = true;
        vwBovinoFazenda;
      });

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadListVacinacao() async {
    try{
      listVacinacao = [];
      List<VacinacaoBovino> list = await VacinacaoBovinoService.getInstance().
        getAllByPkBovinoAndPkFazenda(pkBovino: vwBovinoFazenda!.pkBovino!,
                                      pkFazenda: widget.fazenda.pkFazenda!);
      setState(() {
        listVacinacao = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Consultar Vacinação'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            children: [

              SizedBox(height: 10),

              Row(children: [
                Text("Buscar Via RFID"),
                Switch(
                  value: isConsultaRFID,
                  activeColor: Palette.primary.shade400,
                  onChanged: (bool value) {
                    setState(() {
                      isConsultaRFID = value;
                    });
                  },
                ),
              ],),

              Form( key: _formKey,
                child: Row(children: [
                  SizedBox(width: 10,),
                  Expanded(child:
                    InputTipo.createInputText(textoConteudo: "Código ${isConsultaRFID ? "RFID":"Animal"}", variavelArmazenaDado: _codigoAnimal,
                      inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                        onFieldSubmitted: (value){
                          if (_formKey.currentState!.validate()){
                            loadBovino();
                          }
                        }
                    )
                  ),
                  IconButton(icon: Icon(Icons.search),
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        loadBovino();
                      }
                    },
                  )
                ],),
              ),

              buscou ?
                vwBovinoFazenda?.pkBovino != null?
                  loadDadosMatriz():
                  Column(children: [
                    SizedBox(height: 40,),
                    Texto.textoPadrao(title: "Animal Não Encontrado!", fontSize: 16),
                  ],)
                :Text(""),

              buscou && _codigoAnimal.text.isNotEmpty && listVacinacao.isEmpty?
                  Texto.textoPadrao(title: "Vacinação Não Encontrada!",  fontSize: 16):
                  Expanded(child: listPesagens() )



            ],
          )
        ),

      )
    );
  }


  Widget loadDadosMatriz(){
    if(vwBovinoFazenda!.pkBovino != null && vwBovinoFazenda!.pkBovino! > 0 ){
      return Card(
        child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:
          Column(children: [
            Texto.referenciaConteudo(referencia: "Código Animal", conteudo: "${vwBovinoFazenda!.pkBovino}"),
            vwBovinoFazenda!.pkTagRfid != null ?
            Texto.referenciaConteudo(referencia: "Código Tag RFID", conteudo: "${vwBovinoFazenda!.txCodigoEpc}"):
            SizedBox(height: 1,),

            SizedBox(height: 4,),

            Row(children: [
              Expanded(child: Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${vwBovinoFazenda!.bovTxSexo == "M"?"Macho":"Femea"}") ),

              Expanded(child: Texto.referenciaConteudo(referencia: "Raca", conteudo: "${vwBovinoFazenda!.racTxNome}") )
            ]),

            SizedBox(height: 3,),

            Texto.referenciaConteudo(referencia: "Nascido em", conteudo: "${vwBovinoFazenda!.bovDtNascimento}"),
          ],)
        ),
      );
    }

    return SizedBox(height: 1,);

  }

  Widget listPesagens() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      itemCount: listVacinacao.length,
      itemBuilder: (context, index) {

        return Card(child:
          Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

            Row(children: [
              Icon(Icons.vaccines, color: Palette.main.shade300,),
              SizedBox(width: 5,),
              Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${listVacinacao.length - index}º Vacina.", style:  TextStyle(color: Palette.primary.shade500, fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 3,),
                  Texto.referenciaConteudo(referencia: "Data", conteudo:  "${listVacinacao[index].dtVacinacao}."),
                  Texto.referenciaConteudo(referencia: "Motivo", conteudo:  "${listVacinacao[index].txMotivo}."),
              ],),

            ],)

          )
        );

      }
    );
  }


//=========================================================================================//


}