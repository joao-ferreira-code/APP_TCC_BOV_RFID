
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../clienteService/Inventario/TagRFID_Service.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/inventario/LoteTagRFID.dart';
import '../../../../dataModel/inventario/TagRFID.dart';
import '../../../componentes/Botoes.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/DropDown.dart';
import '../../../componentes/Inputs.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';

class NewTagRFID_PageView extends StatefulWidget {
  const NewTagRFID_PageView({Key? key, required this.usuario, required this.loteTagRFID, this.tagRFID}) : super(key: key);

  final Usuario usuario;
  final LoteTagRFID loteTagRFID;
  final TagRFID? tagRFID;

  @override
  _NewTagRFID_PageView createState() => _NewTagRFID_PageView();
}

//=========================================================================================//

class _NewTagRFID_PageView extends State<NewTagRFID_PageView> {

  final _codEPC = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

//----------------------------------------------------------------------------//

  @override
  void initState() {
    if( widget.tagRFID != null) {
      _codEPC.text = widget.tagRFID!.txCodigoEpc!;
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: 'Cadastar TAG'),

      body: Paineis.Pagina(context: context,
        child: Form( key: _formKey,
            child: Container(
                transformAlignment: Alignment.topCenter,
                width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox( height: 10.0, ),

                    Texto.subtitulo(context: context, title: "TAG RFID", color: Colors.black),

                    SizedBox( height: 10.0, ),


                    InputTipo.createInputText(textoConteudo: "Codigo EPC", variavelArmazenaDado: _codEPC,
                      inputType: TextInputType.number, validar: true, icon: Icons.numbers,
                    ),


                    SizedBox( height: 15, ),

                    BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                        onPressed: cadastrarAction
                    ),

                    SizedBox( height: 10, ),

                    widget.tagRFID != null?
                      BotaoTipo.desfocado(text: "Inativar", size: MediaQuery.of(context).size.width * .675,
                          onPressed: cofirmarInativacao
                      ): SizedBox( height: 10, ),

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
        TagRFID tagRFID = new TagRFID(fkUsuarioCadastrou: widget.usuario.pkUsuario,
          fkLoteTag: widget.loteTagRFID.pkLoteTag, txCodigoEpc: _codEPC.text, ativa: true
        );

        await TagRFID_Service.getInstance().createTagRFID(tagRFID: tagRFID);

        Mensagens.rodape(context: context, msg: "Tag ${widget.tagRFID != null ? "Editado":"Cadastro" } Com Sucesso!");
        Navigator.pop(context);
      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }

    }
  }

//---------------------------------------------------------------------------------------//


  cofirmarInativacao() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text("Deseja Inativar a TAG?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              inativarAction();
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

  inativarAction() async {
    try{

      await TagRFID_Service.getInstance().inativarFazenda(pkTAG: widget.tagRFID!.pkTagRfid!);

      Mensagens.rodape(context: context, msg: "Tag Inativada Com Sucesso!");
      Navigator.pop(context);
    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }

  }


}

