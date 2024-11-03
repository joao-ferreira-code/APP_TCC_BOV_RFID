
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../clienteService/admSistema/RacaService.dart';
import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../clienteService/bovino/BovinoService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/admSistema/Raca.dart';
import '../../../../dataModel/animal/Bovino.dart';
import '../../../../dataModel/animal/BovinoFazenda.dart';
import '../../../../dataModel/animal/CompraBovino.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/DateFormatter.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/DropDown.dart';
import '../../../componentes/InputFormatter.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';


class NewAnimal_Compra_PageView extends StatefulWidget {
  const NewAnimal_Compra_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _NewAnimal_Compra_PageView createState() => _NewAnimal_Compra_PageView();
}

//=========================================================================================//

class _NewAnimal_Compra_PageView extends State<NewAnimal_Compra_PageView> {

  final _codeRFID_Animal = TextEditingController();
  final _codeRFID_MatizFemea = TextEditingController();
  final _codeRFID_MatizMacho = TextEditingController();
  final _avaliacaoAnimal = TextEditingController();
  final _observacaoCompra = TextEditingController();
  final _grauSangue = TextEditingController();
  final _dataNascimento = TextEditingController();

  final _peso = TextEditingController();
  final _valorPago = TextEditingController();
  final _valorAroba = TextEditingController();
  final _dataCompra = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Raca> listRaca = [];
  Raca racaSelecionada = new Raca(txNome: "Selecione...");

  final List<String> listSexo = ["Macho", "Femea"];
  String sexoSelecionado = "Macho";

  List<String> listInseminacao = ["Monta", "Inseminação"];
  String inseminacao = "Monta";

  VWBovinoFazenda bovinoPai = new VWBovinoFazenda();
  VWBovinoFazenda bovinoMae = new VWBovinoFazenda();

  bool fixedRaca = false;
  bool fixedNascimento = false;
  bool isEstimado = false;

  bool isConsultaRFID_MF = false;
  bool isConsultaRFID_MP = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataCompra.text = DateFormatter.format(dateTime: DateTime.now());
    loadRacas();
  }

//----------------------------------------------------------------------------//

  loadRacas() async {
    try {
      var list = await RacaService.getInstance().getAllRaca();
      setState(() {
        listRaca = list;
        racaSelecionada = listRaca[0];
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadMatriz(bool isFemea) async {
    try{
      if(isFemea){
        setState(() {
          bovinoMae = new VWBovinoFazenda();
        });
        List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
            fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codeRFID_MatizFemea.text),
            isViaRFID: isConsultaRFID_MF ? 1 : 0 );

        if(list.length > 0) {
          setState(() {
            bovinoMae = list[0];
          });
        }
      }else {
        setState(() {
          bovinoPai = new VWBovinoFazenda();
        });
        List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
            fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codeRFID_MatizMacho.text),
            isViaRFID: isConsultaRFID_MP ? 1 : 0 );
        if(list.length > 0 ) {
          setState(() {
            bovinoPai = list[0];
          });
        }
      }

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: 'Cadastrar Animal'),

      body: Paineis.Pagina(context: context,
      child:

        Form( key: _formKey,
          child: Container(
              transformAlignment: Alignment.topCenter,
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox( height: 10.0, ),


                  Card(color: Palette.main.shade100,
                    child: Padding( padding: EdgeInsets.only(left: 10, right: 10), child:
                      Column(children: [
                        SizedBox( height: 10.0, ),
                        Texto.subtitulo(context: context, title: "Dados Do Animal.", color: Colors.black),

                        SizedBox( height: 10.0, ),

                        InputTipo.createInputText(textoConteudo: "Codigo RFID", variavelArmazenaDado: _codeRFID_Animal,
                          icon: Icons.key, inputType: TextInputType.text, validar: false,
                        ),

                        Column(children: [
                          Row(children: [
                            Column(children: [
                              Text("Via RFID"),
                              Switch(
                                value: isConsultaRFID_MF,
                                activeColor: Palette.primary.shade400,
                                onChanged: (bool value) {
                                  setState(() {
                                    isConsultaRFID_MF = value;
                                  });
                                },
                              ),
                            ],),
                            Expanded(child: InputTipo.createInputText(textoConteudo: "Codigo ${isConsultaRFID_MF ? "RFID":""} Matriz Femea", variavelArmazenaDado: _codeRFID_MatizFemea,
                              icon: Icons.key, inputType: TextInputType.text, validar: false,
                            ),),
                            IconButton(icon: Icon(Icons.search),
                              onPressed: (){
                                loadMatriz(true);
                              },
                            )
                          ]),

                          loadDadosMatriz(bovinoMae),
                        ]),

                        Column(children: [
                          Row(children: [
                            Column(children: [
                              Text("Via RFID"),
                              Switch(
                                value: isConsultaRFID_MP,
                                activeColor: Palette.primary.shade400,
                                onChanged: (bool value) {
                                  setState(() {
                                    isConsultaRFID_MP = value;
                                  });
                                },
                              ),
                            ],),
                            Expanded(child: InputTipo.createInputText(textoConteudo: "Codigo ${isConsultaRFID_MP ? "RFID":""} Matriz Macho", variavelArmazenaDado: _codeRFID_MatizMacho,
                              icon: Icons.key, inputType: TextInputType.text, validar: false,
                            )),
                            IconButton(icon: Icon(Icons.search),
                              onPressed: (){
                                loadMatriz(false);
                              },
                            )
                          ]),
                          loadDadosMatriz(bovinoPai),
                        ]),

                        Row(children: [
                          Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isEstimado,
                            onChanged: (bool? value) {
                              setState(() {
                                isEstimado = value!;
                              });
                            },
                          ),
                          TextButton(
                            onPressed: (){setState(() {
                              isEstimado = !isEstimado;
                            });},
                            child: Texto.subtitulo(context: context, title: 'Dados Estimados', fontSize: 14),
                          ),
                        ],),

                        Row(children: [
                          Expanded(child:
                          DropDown.ByRaca(
                            items: listRaca,
                            value: racaSelecionada,
                            onChanged: (value) {
                              setState(() {
                                racaSelecionada = value!;
                              });
                            },
                          ),
                          ),
                          IconButton(
                            icon: Icon( fixedRaca?Icons.grade:Icons.grade_outlined ),color: Palette.main.shade900,
                            tooltip: "Fixar",
                            onPressed: (){
                              setState(() {
                                fixedRaca = !fixedRaca;
                              });
                            },
                          )
                        ],),


                        InputTipo.createInputText(textoConteudo: "Grau de Sangue", variavelArmazenaDado: _grauSangue,
                          icon: Icons.numbers, inputType: TextInputType.number, validar: false,
                        ),

                        Row(children: [
                          Expanded(child:
                          DropDown.ByText(
                            items: listSexo,
                            value: sexoSelecionado,
                            onChanged: (value) {
                              setState(() {
                                sexoSelecionado = value!;
                              });
                            },
                          ),
                          ),

                          SizedBox(width: 10,),

                          Expanded(child:
                          DropDown.ByText(
                            items: listInseminacao,
                            value: inseminacao,
                            onChanged: (value) {
                              setState(() {
                                inseminacao = value!;
                              });
                            },
                          ),
                          ),
                        ],),


                        InputTipo.createInputText(textoConteudo: "Data Nascimento", variavelArmazenaDado: _dataNascimento,
                          icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                          inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                        ),

                        InputTipo.createInputAreaText(textoConteudo: "Avaliação", variavelArmazenaDado: _avaliacaoAnimal,
                          icon: Icons.text_fields, inputType: TextInputType.text, validar: false,
                        ),

                        SizedBox( height: 10.0, ),
                      ]),
                    )
                  ),

                  SizedBox( height: 10.0, ),


                  Card(color: Palette.main.shade100,
                    child: Padding( padding: EdgeInsets.only(left: 10, right: 10), child:
                      Column(children: [
                        SizedBox( height: 10.0, ),
                        Texto.subtitulo(context: context, title: "Dados Da Compra.", color: Colors.black),

                        SizedBox( height: 10.0, ),

                        InputTipo.createInputText(textoConteudo: "Data Compra", variavelArmazenaDado: _dataCompra,
                          icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                          inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                        ),

                        InputTipo.createInputText(textoConteudo: "Peso", variavelArmazenaDado: _peso,
                          inputType: TextInputType.number, validar: true, icon: Icons.numbers,
                        ),

                        InputTipo.createInputText(textoConteudo: "Valor Pago", variavelArmazenaDado: _valorPago,
                          inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                        ),

                        InputTipo.createInputText(textoConteudo: "Valor @", variavelArmazenaDado: _valorAroba,
                          inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                        ),

                        /*InputTipo.createInputText_Padding(text: "Observacao", variavelArmazenaDado: _observacaoCompra,
                          icon: Icons.text_fields, inputType: TextInputType.text, validar: true,
                        ),*/
                        SizedBox( height: 10.0, ),

                      ]),
                    )
                  ),

                  SizedBox( height: 10.0, ),


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

  Widget loadDadosMatriz(VWBovinoFazenda vwBovinoFazenda){
    if(vwBovinoFazenda.pkBovino != null && vwBovinoFazenda.pkBovino! > 0 ){
      return Card(
        child: Padding(padding: EdgeInsets.all(5), child:
        Column(children: [
          Texto.referenciaConteudo(referencia: "Codigo Animal", conteudo: "${vwBovinoFazenda.pkBovino}"),
          vwBovinoFazenda.pkTagRfid != null ?
          Texto.referenciaConteudo(referencia: "Codigo Tag RFID", conteudo: "${vwBovinoFazenda.txCodigoEpc}"):
          SizedBox(height: 1,),

          SizedBox(height: 5,),


          Row(children: [
            Expanded(child: Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${vwBovinoFazenda.bovTxSexo == "M"?"Macho":"Femea"}") ),

            Expanded(child: Texto.referenciaConteudo(referencia: "Raca", conteudo: "${vwBovinoFazenda.racTxNome}") )
          ]),
        ],)
        ),
      );
    }

    return SizedBox(height: 1,);

  }

//----------------------------------------------------------------------------//

  cadastrarAction() async {
    if (_formKey.currentState!.validate()){
      try{
        Bovino bovino = new Bovino(fkRaca: racaSelecionada.pkRaca,
          fkUsuarioCadastrou: widget.usuario.pkUsuario, txSexo: sexoSelecionado == "Macho"?"M":"F",
          dtNascimento: _dataNascimento.text, txGrauSangue:_grauSangue.text,
          txAvaliacao: _avaliacaoAnimal.text, inseminacao: inseminacao == "Monta" ? false : true,
          fkBovinoMatrizFemea: _codeRFID_MatizFemea.text.isEmpty ? 0 : int.parse(_codeRFID_MatizFemea.text),
          fkBovinoMatrizMacho: _codeRFID_MatizMacho.text.isEmpty ? 0 : int.parse(_codeRFID_MatizMacho.text),
        );

        CompraBovino compra = new CompraBovino(fkUsuarioCadastrou: widget.usuario.pkUsuario,
          dtCompra: _dataCompra.text, nrPesagem: int.parse(_peso.text), nrValor: int.parse(_valorPago.text),
          nrValorArroba: int.parse(_valorAroba.text), pesagemEstimada: isEstimado,
        );

        BovinoFazenda_Cad bovFaz = new BovinoFazenda_Cad(fkFazenda: widget.fazenda.pkFazenda, bovino: bovino, compraBovino: compra );

        if(isConsultaRFID_MF){
          bovFaz.txCodigoEpc = _codeRFID_MatizFemea.text;
          if(bovinoMae != null){
            bovFaz.pkBovinoFazendaMatrizFemea = bovinoMae.pkBovinoFazenda;
            bovFaz.pkBovinoMatrizFemea = bovinoMae.pkBovino;
          }
        }

        if(isConsultaRFID_MP){
          bovFaz.txCodigoEpc = _codeRFID_MatizMacho.text;
          if(bovinoPai != null){
            bovFaz.pkBovinoFazendaMatrizMacho = bovinoPai.pkBovinoFazenda;
            bovFaz.pkBovinoMatrizMacho = bovinoPai.pkBovino;
          }
        }

        await BovinoFazendaService.getInstance().createByCompraCadAnimal(bovino: bovFaz);

        Mensagens.rodape(context: context, msg: "Animal Cadastro com Sucesso!");
        Navigator.pop(context);

      } catch (e) {
        Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

}

