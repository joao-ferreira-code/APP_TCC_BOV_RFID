
import 'package:bovinocultura_corte/clienteService/bovino/DescarteBovinoService.dart';
import 'package:bovinocultura_corte/dataModel/animal/DescarteBovino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../clienteService/bovino/PesagemBovinoService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/PesagemBovino.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/DateFormatter.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/InputFormatter.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';

class NewDescarteBovino_PageView extends StatefulWidget {
  const NewDescarteBovino_PageView({Key? key, required this.usuario, required this.fazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _NewDescarteBovino_PageView createState() => _NewDescarteBovino_PageView();
}

//=========================================================================================//

class _NewDescarteBovino_PageView extends State<NewDescarteBovino_PageView> {

  final _codigoAnimal = TextEditingController();
  final _motivo = TextEditingController();
  final _dataPerca = TextEditingController();
  final _observacao = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  VWBovinoFazenda bovino = new VWBovinoFazenda();

  bool fixed = false;
  bool buscou = false;

  bool isConsultaRFID = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataPerca.text = DateFormatter.format(dateTime: DateTime.now());
  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{
      buscou = false;
      bovino = new VWBovinoFazenda();
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );

      if(list.length > 0) {
        bovino = list[0];
      }
      setState(() {
        buscou = true;
        bovino;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: 'Descartar Animal'),

      body: Paineis.Pagina(context: context,
        child:  Form( key: _formKey,
          child: Container(
              transformAlignment: Alignment.topCenter,
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox( height: 10.0, ),

                  Texto.subtitulo(context: context, title: "Registro do Acontecido.", color: Colors.black),

                  SizedBox( height: 10.0, ),


                  Form( key: _formKey2,
                    child: Row(children: [
                      Column(children: [
                        Text("Via RFID"),
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
                      Expanded(child: InputTipo.createInputText(textoConteudo: "Código ${isConsultaRFID ? "RFID":"Animal"}", variavelArmazenaDado: _codigoAnimal,
                        inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                          onFieldSubmitted: (value){
                            if (_formKey2.currentState!.validate()){
                              loadBovino();
                            }
                          }
                      )),
                      IconButton(icon: Icon(Icons.search),
                        onPressed: (){
                          if (_formKey2.currentState!.validate()){
                            loadBovino();
                          }
                        },
                      )
                    ],),
                  ),

                  buscou?
                  loadDadosAnimal():SizedBox(height: 1,),

                  InputTipo.createInputText(textoConteudo: "Motivo", variavelArmazenaDado: _motivo,
                    inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                  ),

                  Row(children: [
                    Expanded(child:
                      InputTipo.createInputText(textoConteudo: "Data Perca", variavelArmazenaDado: _dataPerca,
                        icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                      ),
                    ),
                    IconButton(
                      icon: Icon( fixed?Icons.grade:Icons.grade_outlined ),color: Palette.main.shade900,
                      tooltip: "Fixar",
                      onPressed: (){
                        setState(() {
                          fixed = !fixed;
                        });
                      },
                    )
                  ],),

                  InputTipo.createInputAreaText(textoConteudo: "Observação", variavelArmazenaDado: _observacao,
                    inputType: TextInputType.text, validar: true, icon: Icons.note_outlined,
                  ),

                  SizedBox( height: 15, ),

                  BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                      onPressed: cadastrarAction
                  ),

                  SizedBox( height: 20, ),

                ],
              )
          )
        )
      ),
    );
  }


//----------------------------------------------------------------------------//

  Widget loadDadosAnimal(){
    if(bovino.pkBovino != null && bovino.pkBovino! > 0 ){
      return Card(
        child: Padding(padding: EdgeInsets.all(5), child:
        Column(children: [
          Texto.referenciaConteudo(referencia: "Código Animal", conteudo: "${bovino.pkBovino}"),
          bovino.pkTagRfid != null ?
          Texto.referenciaConteudo(referencia: "Código Tag RFID", conteudo: "${bovino.txCodigoEpc}"):
          SizedBox(height: 1,),

          SizedBox(height: 5,),


          Row(children: [
            Expanded(child: Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${bovino.bovTxSexo == "M"?"Macho":"Femea"}") ),

            Expanded(child: Texto.referenciaConteudo(referencia: "Raça", conteudo: "${bovino.racTxNome}") )
          ]),
        ],)
        ),
      );
    }

    return Texto.textoPadrao(title: "Animal Não Encontrado!", fontSize: 14);

  }

//=========================================================================================//

  cadastrarAction() async {
    if (_formKey.currentState!.validate()) {
      try{

        DescarteBovino descarteBovino = new DescarteBovino(fkUsuarioCadastrou: widget.usuario.pkUsuario,
          fkAnimalFazenda: bovino.pkBovinoFazenda, dtPerca: _dataPerca.text, txMotivo: _motivo.text,
          txObservacao: _observacao.text, );

        await DescarteBovinoService.getInstance().createDescarteBovino(descarteBovino: descarteBovino);

        Mensagens.rodape(context: context, msg: "Animal Descartado com Sucesso!");
        limparCampos();

      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }

    }
  }

//=========================================================================================//

  limparCampos(){
    setState(() {
      _codigoAnimal.clear();
      _motivo.clear();
      _observacao.clear();
      bovino = new VWBovinoFazenda();
      if(!fixed) {
        _dataPerca.text = DateFormatter.format(dateTime: DateTime.now());
      }
      buscou = false;
    });
  }

}

