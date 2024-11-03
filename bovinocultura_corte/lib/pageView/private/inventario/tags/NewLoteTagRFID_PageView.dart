
import 'package:bovinocultura_corte/clienteService/Inventario/LoteTagRFID_Service.dart';
import 'package:bovinocultura_corte/dataModel/inventario/LoteTagRFID.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/DateFormatter.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/DropDown.dart';
import '../../../componentes/InputFormatter.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';

class NewLoteTagRFID_PageView extends StatefulWidget {
  const NewLoteTagRFID_PageView({Key? key, required this.usuario, required this.fazenda, this.loteTagRFID}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final LoteTagRFID? loteTagRFID;

  @override
  _NewLoteTagRFID_PageView createState() => _NewLoteTagRFID_PageView();
}

//=========================================================================================//

class _NewLoteTagRFID_PageView extends State<NewLoteTagRFID_PageView> {

  List<String> listFrequenciaLeitura = ["LF","HF", "UF"];
  String frequencia = "UF";

  List<String> listModelo = ["ATIVA", "PASSIVA", "SEMI ATIVA",];
  String modelo = "ATIVA";

  List<String> listMetalica = ["Metalica","Não Metalica",];
  String metalica = "Não Metalica";

  List<String> listProof = ["Proof","Evidence",];
  String proof = "Proof";

  final _nrUnidades = TextEditingController();
  final _valorPago = TextEditingController();
  final _dataCompra = TextEditingController();
  final _senhaLote = TextEditingController();
  final _observacao = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool fixed = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataCompra.text = DateFormatter.format(dateTime: DateTime.now());

    if( widget.loteTagRFID != null) {
      _nrUnidades.text = "${widget.loteTagRFID!.nrUnidades!}";
      _valorPago.text = "${widget.loteTagRFID!.nrUnidades!}";
      frequencia = "${widget.loteTagRFID!.txFrequenciaOperacao!}";
      modelo = "${widget.loteTagRFID!.txModeloLeitura!.toUpperCase()}";
      _senhaLote.text = "${widget.loteTagRFID!.txSenhaLote!}";
      _observacao.text = "${widget.loteTagRFID!.txObservacaoResumo!}";
      proof = "${widget.loteTagRFID!.tampProof! ? "Proof" : "Evidence"}";
      metalica = "${widget.loteTagRFID!.metalica! ? "Metalica" : "Não Metalica"}";
      _dataCompra.text = widget.loteTagRFID!.dtCadastro!;
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: 'Cadastar Lote'),

      body: Paineis.Pagina(context: context,
        child: Form( key: _formKey,
            child: Container(
                transformAlignment: Alignment.topCenter,
                width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox( height: 10.0, ),

                    Texto.subtitulo(context: context, title: "Lote TAGS RFID", color: Colors.black),

                    SizedBox( height: 10.0, ),

                    Row(children: [
                      Expanded(child:
                        DropDown.ByText( items: listModelo, value: modelo,
                          onChanged: (value) {
                            setState(() {
                              modelo = value!;
                            });
                          },
                        ),
                      ),

                      SizedBox(width: 10,),

                      Expanded(child:
                        DropDown.ByText( items: listMetalica, value: metalica,
                          onChanged: (value) {
                            setState(() {
                              metalica = value!;
                            });
                          },
                        ),
                      )
                    ],),

                    SizedBox( height: 10.0, ),

                    Row(children: [
                      Expanded(child:
                        DropDown.ByText( items: listFrequenciaLeitura, value: frequencia,
                          onChanged: (value) {
                            setState(() {
                              frequencia = value!;
                            });
                          },
                        ),
                      )
                    ],),

                    SizedBox( height: 10.0, ),

                    Row(children: [
                      Expanded(child:
                        DropDown.ByText( items: listProof, value: proof,
                          onChanged: (value) {
                            setState(() {
                              proof = value!;
                            });
                          },
                        ),
                      )
                    ],),

                    InputTipo.createInputText(textoConteudo: "Numero de Unidades", variavelArmazenaDado: _nrUnidades,
                      inputType: TextInputType.number, validar: true, icon: Icons.numbers,
                    ),

                    InputTipo.createInputText(textoConteudo: "Valor Pago", variavelArmazenaDado: _valorPago,
                      inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                    ),

                    InputTipo.createInputText(textoConteudo: "Data Compra", variavelArmazenaDado: _dataCompra,
                      icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                      inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                    ),

                    InputTipo.createInputText(textoConteudo: "Senha Lote", variavelArmazenaDado: _senhaLote,
                      inputType: TextInputType.text, validar: true, icon: Icons.lock_outline,
                    ),

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

//=========================================================================================//

  cadastrarAction() async {
    if (_formKey.currentState!.validate()){
      try{
        LoteTagRFID loteTagRFID;
        if(widget.loteTagRFID == null) {
          loteTagRFID = new LoteTagRFID(fkFazenda: widget.fazenda.pkFazenda,
              fkUsuarioCadastrou: widget.usuario.pkUsuario,
              nrUnidades: int.parse(_nrUnidades.text,),
              nrValorPago: double.parse(_valorPago.text),
              txFrequenciaOperacao: frequencia,
              txModeloLeitura: modelo,
              txSenhaLote: _senhaLote.text,
              txObservacaoResumo: _observacao.text,
              ativa: true,
              tampProof: proof == "Proof" ? true : false,
              metalica: metalica == "Metalica" ? true : false,
              dtCadastro: _dataCompra.text
          );
        }else{
          loteTagRFID = widget.loteTagRFID!;

          loteTagRFID.nrUnidades = int.parse(_nrUnidades.text,);
          loteTagRFID.nrValorPago = double.parse(_valorPago.text);
          loteTagRFID.txFrequenciaOperacao = frequencia;
          loteTagRFID.txModeloLeitura = modelo;
          loteTagRFID.txSenhaLote = _senhaLote.text;
          loteTagRFID.txObservacaoResumo = _observacao.text;
          loteTagRFID.ativa = true;
          loteTagRFID.tampProof = proof == "Proof" ? true : false;
          loteTagRFID.metalica = metalica == "Metalica" ? true : false;
          loteTagRFID.dtCadastro = _dataCompra.text;
        }

        await LoteTagRFID_Service.getInstance().createLoteTagRFID(loteVacina: loteTagRFID);

        Mensagens.rodape(context: context, msg: "Lote ${widget.loteTagRFID != null ? "Editado":"Cadastro" } Com Sucesso!");

        Navigator.pop(context);

      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//


}

