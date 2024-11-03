
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../dataModel/Usuario.dart';
import '../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../dataModel/fazenda/Fazenda.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Inputs.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';

class ConsultaAnimal_PageView extends StatefulWidget {
  const ConsultaAnimal_PageView({Key? key, required this.usuario, required this.fazenda, this.codAnimal }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final int? codAnimal;

  @override
  _ConsultaAnimal_PageView createState() => _ConsultaAnimal_PageView();
}

//============================================================================//

class _ConsultaAnimal_PageView extends State<ConsultaAnimal_PageView> {

  final _codigoAnimal = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<VWBovinoFazenda> listBovino = [];

  bool buscou = false;

  bool isConsultaRFID = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    if(widget.codAnimal != null && widget.codAnimal! > 0){
      _codigoAnimal.text = "${widget.codAnimal!}";
      isConsultaRFID = false;
      loadBovino();
    }
  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{
      buscou = false;
      listBovino = [];
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );
      setState(() {
        buscou = true;
        listBovino = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Consultar Animal'), ),
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
                  Expanded(child: InputTipo.createInputText(textoConteudo: "Código ${isConsultaRFID ? "RFID":"Animal"}", variavelArmazenaDado: _codigoAnimal,
                    inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                      onFieldSubmitted: (value){
                        if (_formKey.currentState!.validate()){
                          loadBovino();
                        }
                      }
                  )),
                  IconButton(icon: Icon(Icons.search),
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        loadBovino();
                      }
                    },
                  )
                ],),
              ),

              SizedBox(height: 10,),

              buscou ?
                _codigoAnimal.text.isNotEmpty && listBovino.isEmpty?
                    Column(children: [
                      SizedBox(height: 40,),
                      Texto.textoPadrao(title: "Animal Não Encontrado!", fontSize: 16),
                    ],):
                    Column(children: [
                      SizedBox(height: 10,),
                      Texto.titulo(context: context, title: "Dados Animal", fontSize: 24),
                      SizedBox(height: 10,),

                      listBovino.length==1?
                      informacao(listBovino[0]):
                      Expanded(child: listFuncionariosRegistrados() )

                    ],)
                : Text("...")


            ],
          )
        ),

      )
    );
  }


  Widget listFuncionariosRegistrados() {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: listBovino.length,
        itemBuilder: (context, index) {

          return Card(color: Colors.grey.shade100,
              child:informacao(listBovino[index])
          );

        }
    );
  }


  Widget informacao(VWBovinoFazenda dadoBovino){
    return InkWell(
      onTap: (){
        //detalheAction(dadoBovino);
      },
      child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

            Texto.referenciaConteudo(referencia: "Código Animal", conteudo: "${dadoBovino.pkBovino}"),
            dadoBovino.pkTagRfid != null ?
              Texto.referenciaConteudo(referencia: "Código Tag RFID", conteudo: "${dadoBovino.txCodigoEpc}"):
              SizedBox(height: 1,),

            SizedBox(height: 9,),

            Row(children: [
              Expanded(child: Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${dadoBovino.bovTxSexo == "M"?"Macho":"Femea"}") ),
              Expanded(child:Texto.referenciaConteudo(referencia: "Nascido em", conteudo: "${dadoBovino.bovDtNascimento}") ),
            ],),

            SizedBox(height: 10,),

            Row(children: [
              Expanded(child: Texto.referenciaConteudo(referencia: "Raça", conteudo: "${dadoBovino.racTxNome}") ),
              Expanded(child: Texto.referenciaConteudo(referencia: "Grau Sanguineo", conteudo: "${dadoBovino.bovTxGrauSangue}%") ),
            ],),

            Texto.referenciaConteudo(referencia: "Fecundação", conteudo: "${dadoBovino.bovIsInseminacao == "1"?"Inseminação":"Monta"}"),

            SizedBox(height: 10,),

            Texto.referenciaConteudo(referencia: "Usuario Cadastrou", conteudo: "${dadoBovino.colabCadBovinoNome}"),
            Texto.referenciaConteudo(referencia: "Avaliação Animal", conteudo: "${dadoBovino.bovTxAvaliacao}"),

            Divider(height: 25,
              color: Colors.grey,
              thickness: 2,
            ),


            dadoBovino.bofTxObtencao == "COM"?
              Column(children: [
                Texto.titulo(context: context, title: "Dados Compra", fontSize: 16),

                SizedBox(height: 10,),
                Row(children: [
                  Expanded(child:Texto.referenciaConteudo(referencia: "Peso em @", conteudo: "${double.parse(dadoBovino.cmpNrPesagem!) / 15}") ),
                  Expanded(child:Texto.referenciaConteudo(referencia: "Peso em KG", conteudo: "${dadoBovino.cmpNrPesagem}") ),
                ],),

                Row(children: [
                  Expanded(child: Texto.referenciaConteudo(referencia: "Valor @", conteudo: "${dadoBovino.cmpNrValor}") ),
                  Expanded(child: Texto.referenciaConteudo(referencia: "Valor Pago", conteudo: "${dadoBovino.cmpNrValorArroba}") ),
                ],),

                Row(children: [
                  Expanded(child: Texto.referenciaConteudo(referencia: "Data Compra", conteudo: "${dadoBovino.cmpDtCompra}") ),
                  Expanded(child: Texto.referenciaConteudo(referencia: "Informações", conteudo: "${dadoBovino.cmpIsPesagemEstimada == "1"? "Estimada":"Real"}") ),
                ],),

                SizedBox(height: 10,),

                Texto.referenciaConteudo(referencia: "Usuario Cadastrou", conteudo: "${dadoBovino.colabCadComNome}"),

              ],):SizedBox(height: 1,),

            dadoBovino.venDtVenda != null?
              Column(children: [
                SizedBox(height: 10,),

                Texto.titulo(context: context, title: "Dados Venda", fontSize: 16),

                SizedBox(height: 5,),
                Row(children: [
                  Expanded(child:Texto.referenciaConteudo(referencia: "Peso em @", conteudo: "${double.parse(dadoBovino.venNrPesagem!) / 15}") ),
                  Expanded(child:Texto.referenciaConteudo(referencia: "Peso em KG", conteudo: "${dadoBovino.venNrPesagem}") ),
                ],),

                Row(children: [
                  Expanded(child: Texto.referenciaConteudo(referencia: "Valor @", conteudo: "${dadoBovino.venNrValorArroba}") ),
                  Expanded(child: Texto.referenciaConteudo(referencia: "Valor Pago", conteudo: "${dadoBovino.venNrValor}") ),
                ],),

                Row(children: [
                  Expanded(child: Texto.referenciaConteudo(referencia: "Data Venda", conteudo: "${dadoBovino.venDtVenda}") ),
                ],),

                SizedBox(height: 10,),

                Texto.referenciaConteudo(referencia: "Usuario Cadastrou", conteudo: "${dadoBovino.colabCadVendNome}"),
              ],):SizedBox(height: 1,),

            dadoBovino.dsbDtCadastro != null?
              Column(children: [
                SizedBox(height: 10,),

                Texto.titulo(context: context, title: "Dados Descarte", fontSize: 16),

                SizedBox(height: 5,),

                Texto.referenciaConteudo(referencia: "Motivo", conteudo: "${dadoBovino.dsbTxMotivo}"),
                Texto.referenciaConteudo(referencia: "Observação", conteudo: "${dadoBovino.dsbTxObservacao}"),
                Texto.referenciaConteudo(referencia: "Data Descarte", conteudo: "${dadoBovino.dsbDtPerca}"),

                SizedBox(height: 10,),

                Texto.referenciaConteudo(referencia: "Usuario Cadastrou", conteudo: "${dadoBovino.colabCadDesNome}"),
              ],):SizedBox(height: 1,),

            SizedBox(height: 5,),

            //dadoBovino.bofIsAtiva! == "0" ? SizedBox(height: 1,):
            //Texto.referenciaConteudo(referencia: "Inativado em", conteudo: "${dadoBovino.bofDtBaixa}"),

          ]),


          /*dadoBovino.bofIsAtiva! == "0" ?
          IconButton(icon: Icon(Icons.remove_circle_outline),
            tooltip: "Inativar Bovino!",
            onPressed: (){
              inativarAction(dadoBovino);
            },
          ):SizedBox(height: 1,),*/


      )
    );
  }

//============================================================================//

  inativarAction(VWBovinoFazenda colaboradorFazenda){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text("Inativar o Bovino?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context,"Sim");
            },
            child: const Text('Sim'),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context,"Não");
            },
            child: const Text('Não'),
          ),

        ],
      ),
    );
  }

//============================================================================//

}