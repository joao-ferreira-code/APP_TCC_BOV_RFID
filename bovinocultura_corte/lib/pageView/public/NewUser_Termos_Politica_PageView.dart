
import 'package:bovinocultura_corte/pageView/public/PoliticaPrivacidade_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../clienteService/UsuarioService.dart';
import '../../dataModel/Usuario.dart';
import '../componentes/Botoes.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import '../componentes/Textos.dart';
import 'CadastroSolicitacaoRealizada_PageView.dart';
import 'TermosDeServico_PageView.dart';

class NewUser_Termos_Politica_PageView extends StatefulWidget {
  const NewUser_Termos_Politica_PageView({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  _NewUser_Termos_Politica_PageView createState() => _NewUser_Termos_Politica_PageView();
}

//=========================================================================================//

class _NewUser_Termos_Politica_PageView extends State<NewUser_Termos_Politica_PageView> {

  bool isCheckedTermo = false;
  bool isCheckedPolitica = false;

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: 'Cadastar Conta'),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(padding: EdgeInsets.only(top: 20, bottom:  10),
                child: Texto.subtitulo(context: context, title: "Termos e Politica.", color: Colors.black)
              ),

              Divider(),


              Row(
                children: [
                  checkedPolitica(),
                  Expanded(
                      child: Texto.textoButton( title: 'Li e Concordo Com a: Politica de Privacidade', context: context,
                        onPressed: visualizarPolitica,)
                  ),
                  IconButton(onPressed: visualizarPolitica, icon: Icon(Icons.arrow_forward_ios, color: Palette.main,))
                ],
              ),


              Divider(),

              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  checkedTermo(),
                  Expanded(
                    child: Texto.textoButton( title: 'Li e Concordo Com os: Termos de Serviço', context: context,
                      onPressed: visualizarTermo,)
                  ),
                  IconButton(onPressed: visualizarTermo, icon: Icon(Icons.arrow_forward_ios, color: Palette.main,)),
                ],
              ),

              Divider(),

              Padding(padding: EdgeInsets.only(top: 20, bottom:  10),
                child: isCheckedTermo && isCheckedPolitica ?
                  BotaoTipo.padrao(text: "Finalizar", size: MediaQuery.of(context).size.width * .675,
                      onPressed: cadastrarUsuario
                  ):BotaoTipo.desfocado(text: "Finalizar", size: MediaQuery.of(context).size.width * .675,
                      onPressed: (){}
                  ),
              ),


            ],
          )
        )

      ),
    );
  }

  Widget checkedTermo() {
    return Checkbox(
      checkColor: Colors.white,
      //fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isCheckedTermo,
      onChanged: (bool? value) {
        setState(() {
          isCheckedTermo = value!;
        });
      },
    );
  }

  Widget checkedPolitica() {
    return Checkbox(
      checkColor: Colors.white,
      //fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isCheckedPolitica,
      onChanged: (bool? value) {
        setState(() {
          isCheckedPolitica = value!;
        });
      },
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.black;
  }

//----------------------------------------------------------------------------//

  void cadastrarUsuario() {
    if( !isCheckedTermo || !isCheckedPolitica ){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: "So é permitido o cadastro para os usuarios que concordem "
              "com os *Termos de Serviço* e a *Politica de Privacidade*");
    }else {
      confirmacaoCadastral();
    }
  }

//=========================================================================================//

  visualizarTermo(){
    Navigator.push( context,
      MaterialPageRoute(builder: (context) => TermosDeServico_PageView()),
    );
  }

//----------------------------------------------------------------------------//

  visualizarPolitica(){
    Navigator.push( context,
      MaterialPageRoute(builder: (context) => PoliticaPrivacidade_PageView()),
    );
  }

//----------------------------------------------------------------------------//

  confirmacaoCadastral() async {

    try{
      if(await UsuarioService.getInstance().createUsuario( usuario: widget.usuario)){
        Navigator.push( context,
          MaterialPageRoute(builder: (context) => CadastroSolicitacaoRealizada_PageView(
            isRecuperarSenha: false, email: widget.usuario.txLogin!, )),
        );
      }
    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }
  }

//=========================================================================================//


}

