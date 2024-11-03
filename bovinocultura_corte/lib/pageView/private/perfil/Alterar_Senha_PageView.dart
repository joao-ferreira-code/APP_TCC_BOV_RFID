
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../clienteService/UsuarioService.dart';
import '../../../dataModel/Usuario.dart';
import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Inputs.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';

class Alterar_Senha_PageView extends StatefulWidget {
  const Alterar_Senha_PageView({Key? key, required this.usuario }) : super(key: key);

  final Usuario usuario;

  @override
  _Alterar_Senha_PageView createState() => _Alterar_Senha_PageView();
}

//=========================================================================================//

class _Alterar_Senha_PageView extends State<Alterar_Senha_PageView> {

  final _atualPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _newPassConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _senhaVisivel = false;
  bool _novaSenhaVisivel = false;
  bool _confSenhaVisivel = false;


//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: ('Alterar Senha'),),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child:

            Form( key: _formKey,
              child: Container(
                transformAlignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * .90,

                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Texto.titulo(context: context, title: "Nova Senha"),
                    SizedBox( height: 25, ),

                    InputTipo.createInputSenha(textoConteudo: "Senha Atual", variavelArmazenaDado: _atualPassController,
                      inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.key,
                      senhaVisivel: _senhaVisivel,
                      onPressed: (){
                        setState(() {
                          _senhaVisivel = !_senhaVisivel;
                        });
                      },
                    ),

                    InputTipo.createInputSenha(textoConteudo: "Nova Senha", variavelArmazenaDado: _newPassController,
                      inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.lock_outline,
                      senhaVisivel: _novaSenhaVisivel,
                      onPressed: (){
                        setState(() {
                          _novaSenhaVisivel = !_novaSenhaVisivel;
                        });
                      },
                    ),

                    InputTipo.createInputSenha(textoConteudo: "Confirmar Nova Senha", variavelArmazenaDado: _newPassConfirmController,
                      inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.lock,
                      senhaVisivel: _confSenhaVisivel,
                      onPressed: (){
                        setState(() {
                          _confSenhaVisivel = !_confSenhaVisivel;
                        });
                      },
                      onFieldSubmitted: (value) {
                        editarSenha();
                      }
                    ),

                    SizedBox( height: 15, ),

                    BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                        onPressed: editarSenha
                    ),

                    SizedBox( height: 20, ),

                  ],
                )
              )
            )
        )
      ),
    );
  }

//=========================================================================================//

  editarSenha() async {
    if (_formKey.currentState!.validate()) {
      if (_newPassController.text != _newPassConfirmController.text) {
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: "As Senhas não são Correspondentes!");
        _newPassController.clear();
        _newPassConfirmController.clear();

      }else{
        try {
          List<String> listDados = [widget.usuario.txLogin!,
                            _atualPassController.text, _newPassController.text];

          if (await UsuarioService.getInstance().editarSenha(listDados: listDados)) {
            Navigator.pop(context);
            Mensagens.rodape(context: context, msg: "Senha Alterada Com Sucessso!");
          }
        } catch (e) {
          Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
              content: e.toString());
        }
      }
    }
  }

//=========================================================================================//

}

