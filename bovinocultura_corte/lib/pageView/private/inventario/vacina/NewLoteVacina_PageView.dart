
import 'package:bovinocultura_corte/clienteService/Inventario/LoteVacinaService.dart';
import 'package:bovinocultura_corte/pageView/componentes/DateFormatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteVacina.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/InputFormatter.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';


class NewLoteVacina_PageView extends StatefulWidget {
  const NewLoteVacina_PageView({Key? key, required this.usuario, required this.fazenda, required this.isObrigatoria, this.loteVacina}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final bool isObrigatoria;
  final LoteVacina? loteVacina;

  @override
  _NewLoteVacina_PageView createState() => _NewLoteVacina_PageView();
}

//=========================================================================================//

class _NewLoteVacina_PageView extends State<NewLoteVacina_PageView> {

  final _nomeLote = TextEditingController();
  final _nomeVacina = TextEditingController();
  final _nrUnidades = TextEditingController();
  final _dataValidadeVacina = TextEditingController();
  final _valorPago = TextEditingController();
  final _dataCompra = TextEditingController();
  final _txObservacao = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool fixed = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    _dataCompra.text = DateFormatter.format(dateTime: DateTime.now());

    if(widget.loteVacina != null){
      _nomeLote.text = widget.loteVacina!.txNomeLoteVacina!;
      _nomeVacina.text = widget.loteVacina!.txNomeVacina!;
      _nrUnidades.text = "${widget.loteVacina!.nrUnidades}";
      _dataValidadeVacina.text = widget.loteVacina!.dtVencimento!;
      _valorPago.text = "${widget.loteVacina!.nrCusto}";
      _dataCompra.text = widget.loteVacina!.dtCadastro!;
      _txObservacao.text = widget.loteVacina!.txObservacao!;
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

                    Texto.subtitulo(context: context, title: "Lote Vacina", color: Colors.black),

                    SizedBox( height: 10.0, ),


                    InputTipo.createInputText(textoConteudo: "Nome Lote", variavelArmazenaDado: _nomeLote,
                      icon: Icons.text_fields, inputType: TextInputType.text, validar: true,
                    ),

                    InputTipo.createInputText(textoConteudo: "Nome Vacina", variavelArmazenaDado: _nomeVacina,
                      icon: Icons.vaccines, inputType: TextInputType.text, validar: true,
                    ),

                    InputTipo.createInputText(textoConteudo: "Numero de Unidades", variavelArmazenaDado: _nrUnidades,
                      inputType: TextInputType.number, validar: true, icon: Icons.numbers,
                    ),

                    InputTipo.createInputText(textoConteudo: "Data Validade", variavelArmazenaDado: _dataValidadeVacina,
                      icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                      inputFormatters: <TextInputFormatter>[ InputFormatter.data_MesAno ],
                    ),

                    InputTipo.createInputText(textoConteudo: "Valor Pago", variavelArmazenaDado: _valorPago,
                      inputType: TextInputType.number, validar: true, icon: Icons.monetization_on_outlined,
                    ),

                    InputTipo.createInputText(textoConteudo: "Data Compra", variavelArmazenaDado: _dataCompra,
                      icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                      inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                    ),

                    InputTipo.createInputAreaText(textoConteudo: "Observação", variavelArmazenaDado: _txObservacao,
                      icon: Icons.note_outlined, inputType: TextInputType.text, validar: false,
                    ),

                    SizedBox( height: 15, ),

                    BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                        onPressed: cadastrarAction
                    ),

                    SizedBox( height: 10, ),

                    widget.loteVacina != null?
                      BotaoTipo.desfocado(text: "Inativar", size: MediaQuery.of(context).size.width * .675,
                          onPressed: (){Mensagens.rodape(context: context, msg: "Funcionalidade Em Desenvolvimento!");}
                      ):SizedBox(height: 1,),

                    SizedBox( height: 10, ),

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
        LoteVacina loteVacina = new LoteVacina();
        if(widget.loteVacina != null) {
          loteVacina = widget.loteVacina!;
          loteVacina.txNomeVacina = _nomeVacina.text;
          loteVacina.txNomeLoteVacina = _nomeLote.text;
          loteVacina.nrCusto = int.parse(_valorPago.text);
          loteVacina.nrUnidades = int.parse(_nrUnidades.text);
          loteVacina.dtVencimento = _dataValidadeVacina.text;
          loteVacina.txObservacao = _txObservacao.text;

        }else{
          loteVacina = LoteVacina(fkFazenda: widget.fazenda.pkFazenda,
            fkUsuarioCadastrou: widget.usuario.pkUsuario, txNomeVacina: _nomeVacina.text,
            nrCusto: int.parse(_valorPago.text), nrUnidades: int.parse(_nrUnidades.text),
            dtVencimento: _dataValidadeVacina.text, txObservacao: _txObservacao.text,
            ativa: true, registradaIndagro: false, obrigatoria: widget.isObrigatoria,
            txNomeLoteVacina: _nomeLote.text
          );
        }


        LoteVacinaService.getInstance().createVacina(loteVacina: loteVacina);

        Mensagens.rodape(context: context, msg: "Lote ${widget.loteVacina != null ? "Editado":"Cadastro" } Com Sucesso!");
        Navigator.pop(context);
        if(widget.loteVacina != null ){
          Navigator.pop(context);
        }

      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }

    }
  }

//----------------------------------------------------------------------------//


}

