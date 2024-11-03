
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../clienteService/UsuarioService.dart';
import '../componentes/Botoes.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/Textos.dart';

class CadastroSolicitacaoRealizada_PageView extends StatefulWidget {
  const CadastroSolicitacaoRealizada_PageView({Key? key, required this.email, required this.isRecuperarSenha}) : super(key: key);

  final bool isRecuperarSenha;
  final String email;

  @override
  _CadastroUsuarioRealizado_PageView createState() => _CadastroUsuarioRealizado_PageView();
}

//=========================================================================================//

class _CadastroUsuarioRealizado_PageView extends State<CadastroSolicitacaoRealizada_PageView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(
            children: [

            Texto.titulo(context: context,
                title: widget.isRecuperarSenha?
                  "Solicitar Nova Senha!":"Validar Conta", fontSize: 40),

            SizedBox(height: 25,),

            Row(children: [
              Expanded(child:
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  child: Padding(padding: EdgeInsets.all(10), child:
                    Texto.textoPadrao(//context: context,
                      title: widget.isRecuperarSenha?
                        "E-mail de recuperação enviado com sucesso!":
                        "E-mail de validacao enviado com sucesso!",)
                  )
                )
              ),
            ],),

            SizedBox(height: 10,),

            BotaoTipo.padrao(text: "    Voltar para o Login    ", //size: MediaQuery.of(context).size.width *.65,
                onPressed: (){
                  if(widget.isRecuperarSenha){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                }
            ),

            SizedBox(height: 25,),

            Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texto.textoPadrao(//context: context,
                  title: "Caso não tenha encontrado o e-mail na caixa de entrada"
                      " verifique na caixa de Spam/Lixo eletrônico.",),

                SizedBox(height: 10,),

                Texto.textoPadrao(//context: context,
                  title: "Ao realizar as referidas verificações e não tenha "
                      "encontrado o e-mail, aguarde uns minutos e realize as "
                      "verificações novamente.",),

                SizedBox(height: 10,),

                Texto.textoPadrao(//context: context,
                  title: "Ao persistir a referida situação, solicite um novo "
                      "e-mail ou entre em contato com a nossa equipe de suporte.",),

            ]),

            SizedBox(height: 15,),
            BotaoTipo.padrao(text: "   Solicitar Novamente   ",
                onPressed: widget.isRecuperarSenha? reiviarEmailRecuperacaoSenha:reiviarEmailValidacao
            ),

          ],)
        )
      ),
    );
  }

//----------------------------------------------------------------------------//

  reiviarEmailValidacao() async {
    try{
      await UsuarioService.getInstance().reiviarEmailValidacao( email: widget.email,);
    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }
  }

  reiviarEmailRecuperacaoSenha() async {
    try{
      await UsuarioService.getInstance().esqueciMinhaSenha( email: widget.email,);
    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

}
