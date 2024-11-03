
import 'package:bovinocultura_corte/dataModel/Usuario.dart';
import 'package:bovinocultura_corte/pageView/private/MyHome_PageView.dart';
import 'package:bovinocultura_corte/pageView/public/NewUser_DadosUsuario_PageView.dart';
import 'package:bovinocultura_corte/pageView/public/Sobre_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_sessaoDeDados/DadosAcesso.dart';
import '../clienteService/UsuarioService.dart';
import 'componentes/Botoes.dart';
import 'componentes/Dimensinamento.dart';
import 'componentes/Inputs.dart';
import 'componentes/Mensagens.dart';
import 'componentes/Paineis.dart';
import 'componentes/PaletaCores.dart';
import 'componentes/Textos.dart';
import 'public/ForgotPassword_PageView.dart';

class Login_PageView extends StatefulWidget {
  const Login_PageView({Key? key}) : super(key: key);

  @override
  _Login_PageView createState() => _Login_PageView();
}

//=========================================================================================//

class _Login_PageView extends State<Login_PageView> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _senhaVisivel = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadDadosAcesso();
  }

//----------------------------------------------------------------------------//

  loadDadosAcesso() async {
    _emailController.text = await DadosAcesso.getLogin();

    Usuario usu = await DadosAcesso.getUsuario();
    if(usu != null){
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(usuario: usu,)),
      );
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Form( key: _formKey,

          child: Container(
            width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

            child: Column( children: <Widget>[

                SizedBox(height: 20,),

                Texto.titulo(context: context, title: "LOGIN", fontSize: 40),

                SizedBox( height: 25.0, ),

                InputTipo.createInputText(textoConteudo: "E-mail", variavelArmazenaDado: _emailController,
                  icon: Icons.email, inputType: TextInputType.text, validar: true,
                ),

                InputTipo.createInputSenha(textoConteudo: "Senha", variavelArmazenaDado: _passController,
                  inputType: TextInputType.visiblePassword, validar: true,  icon: Icons.lock,
                  senhaVisivel: _senhaVisivel,
                  onPressed: (){
                    setState(() {
                      _senhaVisivel = !_senhaVisivel;
                    });
                  },
                  onFieldSubmitted: (value){
                    if (_formKey.currentState!.validate()){
                      authenticarUsuario(_emailController.text, _passController.text);
                    }
                  }
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BotaoTipo.createButton(text: 'Esqueci minha senha!',
                      backColor: Color(0x3fdfdfd),
                      shadowColor: Color(0xdfdfdfd),
                      padding: 10, altura: 35, fontSize: 16,
                      onPressed: esqueciMinhaSenha,
                    ),
                  ]
                ),

                SizedBox( height: 5.0, ),

                BotaoTipo.padrao(text: "Entrar", size: MediaQuery.of(context).size.width * .675,
                  onPressed: (){
                      if (_formKey.currentState!.validate()){
                        authenticarUsuario(_emailController.text, _passController.text);
                      }
                  }
                ),

                SizedBox( height: 7.0, ),

                Row( mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BotaoTipo.createButton(text: 'Cadastre-se!',
                      backColor: Color(0x3fdfdfd),
                      shadowColor: Color(0xdfdfdfd),
                      padding: 10, altura: 35, fontSize: 16,
                      onPressed: cadastreSe,
                    ),
                  ]
                ),

                SizedBox(height: 20,),

              ],
            )

          )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.colorBeckground,
        onPressed: sobre_Info,
        tooltip: 'Sobre',
        child: Icon(Icons.info_outline_rounded),
      ),

    );
  }

//=========================================================================================//

  void esqueciMinhaSenha(){
    _passController.clear();
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          ForgotPassword_PageView(emailController: _emailController.text,)),
    );
  }

//----------------------------------------------------------------------------//

  void authenticarUsuario(String email, String senha) async {
    _passController.clear();
    try {
      Usuario result = await UsuarioService.getInstance().autenticar( login: email, senha: senha);

      if(result != null) {
        DadosAcesso.salvarLogin(email);
        DadosAcesso.salvarUsuario(result);
        Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(usuario: result,)),
        );
      }
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  void cadastreSe(){
    _passController.clear();
    Navigator.push(context,
      MaterialPageRoute( builder: (context) => NewUser_DadosUsuario_PageView()),
    );
  }

//----------------------------------------------------------------------------//

  void sobre_Info(){
    _passController.clear();
    Navigator.push(context,
      MaterialPageRoute( builder: (context) => Sobre_PageView()),
    );
  }

//=========================================================================================//

}
