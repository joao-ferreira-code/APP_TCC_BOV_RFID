
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../clienteService/UsuarioService.dart';
import '../../dataModel/Usuario.dart';
import '../componentes/Botoes.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Inputs.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/Textos.dart';
import 'NewUser_Termos_Politica_PageView.dart';

class NewUser_DadosAcesso_PageView extends StatefulWidget {
  const NewUser_DadosAcesso_PageView({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  _NewUser_DadosAcesso_PageView createState() => _NewUser_DadosAcesso_PageView();
}

//=========================================================================================//

class _NewUser_DadosAcesso_PageView extends State<NewUser_DadosAcesso_PageView> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _senhaVisivel = false;
  bool _confSenhaVisivel = false;

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
        appBar: Paineis.appBar(context: context, text: 'Cadastar Conta'),

        body: Paineis.Pagina(context: context,
            child:

              Form( key: _formKey,
                child: Container(
                    transformAlignment: Alignment.topCenter,
                    width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox( height: 10.0, ),

                        Texto.subtitulo(context: context, title: "Dados De Acesso.", color: Colors.black),

                        SizedBox( height: 10.0, ),


                        InputTipo.createInputText(textoConteudo: "E-mail", variavelArmazenaDado: _emailController,
                          icon: Icons.email, inputType: TextInputType.emailAddress, validar: true,
                        ),

                        InputTipo.createInputSenha(textoConteudo: "Senha", variavelArmazenaDado: _passController,
                          inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.lock_outline,
                          senhaVisivel: _senhaVisivel,
                          onPressed: (){
                            setState(() {
                              _senhaVisivel = !_senhaVisivel;
                            });
                          },
                        ),

                        InputTipo.createInputSenha(textoConteudo: "Confirmar Senha", variavelArmazenaDado: _passConfirmController,
                          inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.lock,
                          senhaVisivel: _confSenhaVisivel,
                          onPressed: (){
                            setState(() {
                              _confSenhaVisivel = !_confSenhaVisivel;
                            });
                          },
                          onFieldSubmitted: (value) {
                            termosPolitica();
                          }
                        ),

                        SizedBox( height: 15, ),

                        BotaoTipo.padrao(text: "Proximo", size: MediaQuery.of(context).size.width * .675,
                            onPressed: termosPolitica
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

  Future<void> termosPolitica() async {
    if(_passController.text != _passConfirmController.text){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: "As Senhas não são Correspondentes!");
      _passConfirmController.clear();
    }else {

      try {
        if (await UsuarioService.getInstance().isEmailValido(
            email: _emailController.text)) {
          if (_formKey.currentState!.validate()) {
            widget.usuario.txLogin = _emailController.text;
            widget.usuario.txSenha = _passController.text;

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewUser_Termos_Politica_PageView(
                          usuario: widget.usuario)),
            );
          }
        } else {
          Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
              content: "Email Invalido!");
        }
      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }
    }
  }

//=========================================================================================//

}

