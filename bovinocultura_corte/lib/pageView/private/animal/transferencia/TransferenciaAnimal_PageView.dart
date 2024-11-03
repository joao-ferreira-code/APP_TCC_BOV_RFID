
import 'package:bovinocultura_corte/clienteService/fazenda/FazendaService.dart';
import 'package:bovinocultura_corte/dataModel/animal/Bovino.dart';
import 'package:bovinocultura_corte/pageView/componentes/Botoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/animal/BovinoFazenda.dart';
import '../../../../dataModel/animal/BovinoFazenda_Transferencia.dart';
import '../../../../dataModel/animal/CompraBovino.dart';
import '../../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/fazenda/VWDadosFazenda.dart';
import '../../../componentes/DateFormatter.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/InputFormatter.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/PaletaCores.dart';
import '../../../componentes/Textos.dart';

class TransferenciaAnimal_PageView extends StatefulWidget {
  const TransferenciaAnimal_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _TransferenciaAnimal_PageView createState() => _TransferenciaAnimal_PageView();
}

//============================================================================//

class _TransferenciaAnimal_PageView extends State<TransferenciaAnimal_PageView> {

  final _codigoAnimal = TextEditingController();
  final _codigoFazenda = TextEditingController();

  final _formKeyMaster = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final _peso = TextEditingController();
  final _valorPago = TextEditingController();
  final _valorAroba = TextEditingController();
  final _dataCompra = TextEditingController();

  bool buscou = false;

  bool isEstimado = false;

  bool isConsultaRFID = false;

  VWBovinoFazenda vwBovinoFazenda = new VWBovinoFazenda();

  VWDadosFazenda vwDadosFazenda = new VWDadosFazenda();

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataCompra.text = DateFormatter.format(dateTime: DateTime.now());
  }

//----------------------------------------------------------------------------//

  loadBovino() async {
    try{

      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().buscarBovinoFullDados(
          fkFazenda: widget.fazenda.pkFazenda!, pkBovino: int.parse(_codigoAnimal.text),
          isViaRFID: isConsultaRFID ? 1 : 0 );

      if(list.length>0) {
        setState(() {
          vwBovinoFazenda = list[0];
        });
      }
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadFazenda() async {
    try{

      var list = await FazendaService.getInstance().buscarFazendaByCodigoPublico(
        codigoPublico: _codigoFazenda.text
      );
      if(list != null) {
        setState(() {
          vwDadosFazenda = list;
        });
      }

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Transferencia Animal'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            children: [

              SizedBox(height: 10),

              Form( key: _formKey,
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
                  Expanded(child:  InputTipo.createInputText(textoConteudo: "Codigo ${isConsultaRFID ? "RFID do ":""}Animal", variavelArmazenaDado: _codigoAnimal,
                    inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                  ),),
                  IconButton(icon: Icon(Icons.search),
                    tooltip: "Buscar Animal",
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        vwBovinoFazenda = new VWBovinoFazenda();
                        loadBovino();
                      }
                    },
                  )
                ],),
              ),

              vwBovinoFazenda.pkBovino != null && vwBovinoFazenda.pkBovino! > 0 ?
              Card(
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
              ):SizedBox(height: 1,),

              Form( key: _formKey2,
                child: Row(children: [
                  SizedBox(width: 10,),
                  Expanded(child:  InputTipo.createInputText(textoConteudo: "Codigo Fazenda Comprador", variavelArmazenaDado: _codigoFazenda,
                    inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                  ),),
                  IconButton(icon: Icon(Icons.search),
                    tooltip: "Buscar Fazenda",
                    onPressed: (){
                      if (_formKey2.currentState!.validate()){
                        loadFazenda();
                      }
                    },
                  )
                ],),
              ),

              vwDadosFazenda.txCodigoPublico != null && vwDadosFazenda.fkCidade! > 0 ?
              Card(
                child: Padding(padding: EdgeInsets.all(5), child:
                Column(children: [
                  Texto.referenciaConteudo(referencia: "Nome", conteudo: "${vwDadosFazenda.txNome}"),

                  SizedBox(height: 3,),

                  Texto.referenciaConteudo(referencia: "Endereço", conteudo: "${vwDadosFazenda.cidTxNome}-${vwDadosFazenda.txSigla}")
                ],)
                ),
              ):SizedBox(height: 1,),

              Form( key: _formKeyMaster, child:
                Card(color: Palette.main.shade100,
                  child: Padding( padding: EdgeInsets.only(left: 10, right: 10), child:
                    Column(children: [
                      SizedBox( height: 10.0, ),
                      Texto.subtitulo(context: context, title: "Dados Da Venda.", color: Colors.black),

                      SizedBox( height: 10.0, ),

                      InputTipo.createInputText(textoConteudo: "Data Venda", variavelArmazenaDado: _dataCompra,
                        icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                      ),

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

                      InputTipo.createInputText(textoConteudo: "Peso", variavelArmazenaDado: _peso,
                        inputType: TextInputType.number, validar: true, icon: Icons.numbers,
                      ),

                      InputTipo.createInputText(textoConteudo: "Valor Pago", variavelArmazenaDado: _valorPago,
                        inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                      ),

                      InputTipo.createInputText(textoConteudo: "Valor @", variavelArmazenaDado: _valorAroba,
                        inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                      ),

                      SizedBox( height: 10.0, ),

                    ]),
                  )
                )
              ),


              vwBovinoFazenda.pkBovino != null ?
                BotaoTipo.padrao(text: "Realizar Transferencia",
                  onPressed: (){
                    confirmarAction();
                  },
                ):
                BotaoTipo.desfocado(text: "Realizar Transferencia",
                  onPressed: (){

                  },
                ),

            ],
          )
        ),

      )
    );
  }

//----------------------------------------------------------------------------//

  confirmarAction(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text("Confirmar Transferencia?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context,"Sim");
              cadastrarAction();
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

  cadastrarAction() async {
    if ( _formKey.currentState!.validate() && _formKey2.currentState!.validate() &&
        _formKeyMaster.currentState!.validate()){
      try{

        CompraBovino compra = new CompraBovino(fkUsuarioCadastrou: widget.usuario.pkUsuario,
          dtCompra: _dataCompra.text, nrPesagem: int.parse(_peso.text), nrValor: int.parse(_valorPago.text),
          nrValorArroba: int.parse(_valorAroba.text), pesagemEstimada: isEstimado,
        );

        BovinoFazenda_Transferencia bovinoFazenda_Transferencia = new BovinoFazenda_Transferencia(
            fkFazenda: vwBovinoFazenda.fkFazenda, pkBovinoFazendaRegistro: vwBovinoFazenda.pkBovinoFazenda,
            compraBovino: compra,
        );

        await BovinoFazendaService.getInstance().createByCompraByTransferencia(bovino: bovinoFazenda_Transferencia);

        Mensagens.rodape(context: context, msg: "Animal Cadastro com Sucesso!");
        Navigator.pop(context);

      } catch (e) {
        Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

}