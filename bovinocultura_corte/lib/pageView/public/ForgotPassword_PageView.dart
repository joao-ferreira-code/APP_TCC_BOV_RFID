
import 'package:flutter/material.dart';

import '../../clienteService/UsuarioService.dart';
import '../componentes/Botoes.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Inputs.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/Textos.dart';
import 'CadastroSolicitacaoRealizada_PageView.dart';

class ForgotPassword_PageView extends StatefulWidget {
  const ForgotPassword_PageView({Key? key, required this.emailController}) : super(key: key);
  final String emailController;

  @override
  _ForgotPassword_PageView createState() => _ForgotPassword_PageView();
}

//=========================================================================================//

class _ForgotPassword_PageView extends State<ForgotPassword_PageView> {

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

//----------------------------------------------------------------------------//

  @override
  void initState() {
    super.initState();
    setState(() {
      _emailController.text = widget.emailController;
    });
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
        appBar: Paineis.appBar(context: context, text: 'Esqueci Minha Senha'),

        body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
            child:
                Form( key: _formKey,
                  child: Container(
                      width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                      child: Column(
                        children: <Widget>[

                          Texto.subtitulo(context: context, title: "Recuperar Senha!", color: Colors.black),

                          SizedBox( height: 25.0, ),

                          InputTipo.createInputText(textoConteudo: "E-mail", variavelArmazenaDado: _emailController,
                            icon: Icons.person, inputType: TextInputType.emailAddress, validar: true,
                          ),

                          SizedBox( height: 15.0, ),

                          BotaoTipo.padrao(text: "Solicitar Codigo", size: MediaQuery.of(context).size.width * .675,
                              onPressed: (){
                                if (_formKey.currentState!.validate()){
                                  solicitarNovaSenha(_emailController.text);
                                }
                              }
                          ),


                        ],

                      )
                  )
              )
        )
    );
  }


//=========================================================================================//

  void solicitarNovaSenha(String email) async{
    try {
      bool result = await UsuarioService.getInstance().esqueciMinhaSenha( email: email);
      if(result) {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              CadastroSolicitacaoRealizada_PageView(
                isRecuperarSenha: true, email: _emailController.text,)),
        );
      }
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//=========================================================================================//

}
