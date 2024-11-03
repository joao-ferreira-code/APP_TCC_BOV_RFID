
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

class NewPesagem_PageView extends StatefulWidget {
  const NewPesagem_PageView({Key? key, required this.usuario, required this.fazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _NewPesagem_PageView createState() => _NewPesagem_PageView();
}

//=========================================================================================//

class _NewPesagem_PageView extends State<NewPesagem_PageView> {

  final _codigoAnimal = TextEditingController();
  final _peso = TextEditingController();
  final _dataPesagem = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool fixed = false;
  bool isConsultaRFID = false;
  bool buscou = false;

  VWBovinoFazenda vwBovinoFazenda = new VWBovinoFazenda();


//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataPesagem.text = DateFormatter.format(dateTime: DateTime.now());
  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{
      buscou = false;
      vwBovinoFazenda = VWBovinoFazenda();
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );

      if(list.length>0) {
        vwBovinoFazenda = list[0];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
        appBar: Paineis.appBar(context: context, text: 'Cadastar Pesagem'),

        body: Paineis.Pagina(context: context,
            child:

              Form( key: _formKey,
                child: Container(
                    transformAlignment: Alignment.topCenter,
                    width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox( height: 10.0, ),

                        Texto.subtitulo(context: context, title: "Dados da Pesagem.", color: Colors.black),

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
                            Expanded(child:  InputTipo.createInputText(textoConteudo: "Código ${isConsultaRFID ? "RFID do ":""}Animal", variavelArmazenaDado: _codigoAnimal,
                              inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                                onFieldSubmitted: (value){
                                  if (_formKey2.currentState!.validate()){
                                    vwBovinoFazenda = new VWBovinoFazenda();
                                    loadBovino();
                                  }
                                }
                            ),),
                            IconButton(icon: Icon(Icons.search),
                              tooltip: "Buscar Animal",
                              onPressed: (){
                                if (_formKey2.currentState!.validate()){
                                  vwBovinoFazenda = new VWBovinoFazenda();
                                  loadBovino();
                                }
                              },
                            )
                          ],),
                        ),

                        buscou ?
                          vwBovinoFazenda.pkBovino != null && vwBovinoFazenda.pkBovino! > 0 ?
                            Card(
                              child: Padding(padding: EdgeInsets.all(5), child:
                              Column(children: [
                                Texto.referenciaConteudo(referencia: "Código Animal", conteudo: "${vwBovinoFazenda.pkBovino}"),
                                vwBovinoFazenda.pkTagRfid != null ?
                                Texto.referenciaConteudo(referencia: "Código Tag RFID", conteudo: "${vwBovinoFazenda.txCodigoEpc}"):
                                SizedBox(height: 1,),

                                SizedBox(height: 5,),


                                Row(children: [
                                  Expanded(child: Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${vwBovinoFazenda.bovTxSexo == "M"?"Macho":"Femea"}") ),

                                  Expanded(child: Texto.referenciaConteudo(referencia: "Raca", conteudo: "${vwBovinoFazenda.racTxNome}") )
                                ]),
                              ],)
                              ),
                            ):Texto.textoPadrao(title: "Animal Não Encontrado!", fontSize: 14)
                          :SizedBox(height: 1,),

                        InputTipo.createInputText(textoConteudo: "Peso (KG)", variavelArmazenaDado: _peso,
                          inputType: TextInputType.text, validar: true, icon: Icons.balance,
                        ),

                        Row(children: [
                          Expanded(child:
                            InputTipo.createInputText(textoConteudo: "Data Pesagem", variavelArmazenaDado: _dataPesagem,
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

//=========================================================================================//

  cadastrarAction() async {
    if (_formKey.currentState!.validate() && _formKey2.currentState!.validate()) {
      try{
        if(vwBovinoFazenda.pkBovinoFazenda == null){
          Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
              content: "Pesquise o Animal!");
        }else {
          PesagemBovino pesagemBovino = new PesagemBovino(
              dtPesagem: _dataPesagem.text,
              nrPeso: double.parse(_peso.text),
              fkAnimalFazenda: vwBovinoFazenda.pkBovinoFazenda,
              fkUsuarioCadastrou: widget.usuario.pkUsuario
          );

          await PesagemBovinoService.getInstance().createPesagemBovino(
              pesagemBovino: pesagemBovino);
          Mensagens.rodape(context: context, msg: "Lote Cadastro Com Sucesso!");
          limparCampos();
        }


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
      _peso.clear();
      vwBovinoFazenda = new VWBovinoFazenda();
      if(!fixed) {
        _dataPesagem.text = DateFormatter.format(dateTime: DateTime.now());
      }
      buscou = false;
    });
  }

}

