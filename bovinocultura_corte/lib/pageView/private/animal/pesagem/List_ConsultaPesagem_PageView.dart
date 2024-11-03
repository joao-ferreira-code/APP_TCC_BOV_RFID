
import 'package:bovinocultura_corte/dataModel/animal/PesagemBovino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../clienteService/bovino/PesagemBovinoService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';

class List_ConsultaPesagem_PageView extends StatefulWidget {
  const List_ConsultaPesagem_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_ConsultaPesagem_PageView createState() => _List_ConsultaPesagem_PageView();
}

//============================================================================//

class _List_ConsultaPesagem_PageView extends State<List_ConsultaPesagem_PageView> {

  final _codigoAnimal = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<PesagemBovino> listPesagem = [];

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
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );

      if(list.isNotEmpty) {
        vwBovinoFazenda = list[0];
        loadListPesagem();
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

  loadListPesagem() async {
    try{
      listPesagem = [];
      List<PesagemBovino> list = await PesagemBovinoService.getInstance().
        getAllByPkBovinoAndPkFazenda(pkBovino: vwBovinoFazenda!.pkBovino!,
                                       pkFazenda: widget.fazenda.pkFazenda!);
      setState(() {
        listPesagem = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Consultar Pesagem'), ),
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

              buscou ?
                vwBovinoFazenda?.pkBovino != null?
                  loadDadosMatriz():
                  Column(children: [
                    SizedBox(height: 40,),
                    Texto.textoPadrao(title: "Animal Não Encontrado!", fontSize: 16),
                  ],)
                :Text(""),

              buscou && _codigoAnimal.text.isNotEmpty && listPesagem.isEmpty?
                  Texto.textoPadrao(title: "Pessagem Não Encontrada!",  fontSize: 16):
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
      itemCount: listPesagem.length,
      itemBuilder: (context, index) {

        return Card(child:
          Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

            Row( children: [
              Icon(Icons.balance, color: Palette.main.shade300,),
              SizedBox(width: 5,),
              Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${listPesagem.length - index}º Pesagem.", style:  TextStyle(color: Palette.primary.shade500, fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 3,),
                  Texto.referenciaConteudo(referencia: "Data", conteudo:  "${listPesagem[index].dtPesagem}."),
                  Texto.referenciaConteudo(referencia: "Peso", conteudo:  "${listPesagem[index].nrPeso} KG."),
              ],),

              Expanded(child: Text("")),

              listPesagem.length - index > 1 ?
                listPesagem[index].nrPeso! > listPesagem[index + 1].nrPeso! ?
                  Icon(Icons.arrow_drop_up, color: Colors.green):
                    listPesagem[index].nrPeso! < listPesagem[index + 1].nrPeso! ?
                      Icon(Icons.arrow_drop_down_sharp, color: Colors.red):
                      Text("=  ",  style: TextStyle(color: Palette.primary),)
                  :Text("--  "),

            ],),

          )
        );

      }
    );
  }


  consultarAction(){
    if(!buscou){
      Mensagens.rodape(context: context, msg: "Em Desenvolvimento");
    }
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
                  //Navigator.push( context,
                    //MaterialPageRoute(
                        //builder: (context) => NewAnimal_Compra_PageView(usuario: widget.usuario, fazenda: widget.fazenda)),
                  //);;
                },
                child: const Text('    Compra    '),
              ),
              SizedBox(width: 10,),
              TextButton(
                style: TextButton.styleFrom( primary: Palette.main, ),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.push( context,
                    //MaterialPageRoute(
                        //builder: (context) => NewAnimal_Nascido_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  //);
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