
import 'package:bovinocultura_corte/clienteService/bovino/VacinacaoBovinoService.dart';
import 'package:bovinocultura_corte/dataModel/animal/VacinacaoBovino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../clienteService/Inventario/LoteVacinaService.dart';
import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteVacina.dart';
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


class NewVacinacao_PageView extends StatefulWidget {
  const NewVacinacao_PageView({Key? key, required this.usuario, required this.fazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _NewVacinacao_PageView createState() => _NewVacinacao_PageView();
}

//=========================================================================================//

class _NewVacinacao_PageView extends State<NewVacinacao_PageView> {

  final _codeAnimal = TextEditingController();
  final _motivo = TextEditingController();
  final _dataVacincao = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<LoteVacina> listLote = [];
  LoteVacina loteSelecionado = new LoteVacina();

  bool fixedData = false;
  bool fixedMotivo = false;
  bool fixedTipoVacincao = false;

  bool isConsultaRFID = false;

  bool buscou = false;

  VWBovinoFazenda vwBovinoFazenda = new VWBovinoFazenda();

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataVacincao.text = DateFormatter.format(dateTime: DateTime.now());
    loadLoteVacina();
  }

//----------------------------------------------------------------------------//

  loadLoteVacina() async {
    try{
      listLote = [];
      List<LoteVacina> list = await LoteVacinaService.getInstance().
          getAllLoteAtivoByFazenda(fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        listLote = list;
        loteSelecionado=listLote[0];
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }

  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{
      buscou = false;
      vwBovinoFazenda = VWBovinoFazenda();
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codeAnimal.text),
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
      appBar: Paineis.appBar(context: context, text: 'Cadastar Vacinação'),

      body: Paineis.Pagina(context: context,
        child: Form( key: _formKey,
          child: Container(
              transformAlignment: Alignment.topCenter,
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox( height: 10.0, ),

                  Texto.subtitulo(context: context, title: "Dados da Vacinação.", color: Colors.black),

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
                      Expanded(child:  InputTipo.createInputText(textoConteudo: "Código ${isConsultaRFID ? "RFID do ":""}Animal", variavelArmazenaDado: _codeAnimal,
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

                  Row(children: [
                    Expanded(child:
                      InputTipo.createInputText(textoConteudo: "Data Vacinção", variavelArmazenaDado: _dataVacincao,
                        icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                      ),
                    ),
                    IconButton(
                      icon: Icon( fixedData?Icons.grade:Icons.grade_outlined ),color: Palette.main.shade900,
                      tooltip: "Fixar",
                      onPressed: (){
                        setState(() {
                          fixedData = !fixedData;
                        });
                      },
                    )
                  ],),


                  Row(children: [
                    Expanded(child:
                      InputTipo.createInputAreaText(textoConteudo: "Motivo", variavelArmazenaDado: _motivo,
                        icon: Icons.note_outlined, inputType: TextInputType.text, validar: true,
                      ),
                    ),
                    IconButton(
                      icon: Icon( fixedMotivo?Icons.grade:Icons.grade_outlined ),color: Palette.main.shade900,
                      tooltip: "Fixar",
                      onPressed: (){
                        setState(() {
                          fixedMotivo = !fixedMotivo;
                        });
                      },
                    )
                  ],),

                  SizedBox(height: 7,),

                  Row(children: [
                    Expanded(child:
                      DropDown.ByVacina( items: listLote, value: loteSelecionado,
                        onChanged: (value) {
                          setState(() {
                            loteSelecionado = value!;
                          });
                        },
                      ),
                    ),

                    IconButton(
                      icon: Icon( fixedTipoVacincao?Icons.grade:Icons.grade_outlined ),color: Palette.main.shade900,
                      tooltip: "Fixar",
                      onPressed: (){
                        setState(() {
                          fixedTipoVacincao = !fixedTipoVacincao;
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
    if (_formKey.currentState!.validate()) {
      try{
        VacinacaoBovino vacinacaoBovino = new VacinacaoBovino(
            dtVacinacao: _dataVacincao.text, fkAnimalFazenda: vwBovinoFazenda.pkBovinoFazenda,
            fkVacina: loteSelecionado.pkVacina, txMotivo: _motivo.text,
            fkUsuarioCadastrou: widget.usuario.pkUsuario
        );

        await VacinacaoBovinoService.getInstance().createVacinacaoBovino(vacinacaoBovino: vacinacaoBovino);
        Mensagens.rodape(context: context, msg: "Vacinação Cadastrada Com Sucesso!");
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
      _codeAnimal.clear();
      vwBovinoFazenda = new VWBovinoFazenda();
      if(!fixedMotivo) {
        _motivo.clear();
      }
      if(!fixedData){
        _dataVacincao.text = DateFormatter.format(dateTime: DateTime.now());
      }
      buscou = false;
    });
  }

}

