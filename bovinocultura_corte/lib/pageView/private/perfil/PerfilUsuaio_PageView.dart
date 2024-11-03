
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../clienteService/FotoUsuarioService.dart';
import '../../../dataModel/FotoUsuario.dart';
import '../../../dataModel/Usuario.dart';
import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/PaletaCores.dart';
import '../../public/VisualizarImagem_PageView.dart';
import 'Alterar_DadosUsuario_PageView.dart';
import 'Alterar_ImagemPerfil_PageView.dart';
import 'Alterar_Senha_PageView.dart';

class PerfilUsuaio_PageView extends StatefulWidget {
  const PerfilUsuaio_PageView({Key? key, required this.usuario, required this.fotoUsuarioParametro }) : super(key: key);

  final Usuario usuario;
  final String fotoUsuarioParametro;

  @override
  _PerfilUsuaio_PageView createState() => _PerfilUsuaio_PageView();
}

//============================================================================//

class _PerfilUsuaio_PageView extends State<PerfilUsuaio_PageView> {

  String fotoUsuario = "";

  @override
  void initState() {
    fotoUsuario = widget.fotoUsuarioParametro;
  }

//----------------------------------------------------------------------------//

  loadFotoUsuario() async {
    try{
      FotoUsuario fto = await FotoUsuarioService.getInstance().fotoAtivaByUsuario(fkUsuario: widget.usuario.pkUsuario!);
      setState(() {
        fotoUsuario = fto.btFotoUsuario!;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Perfil'), ),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
        width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(
            children: [

              SizedBox( height: 15.0, ),
              Align(
                alignment: Alignment.center,
                child:InkWell(
                  onTap: visualizarImagem ,
                  child:
                    fotoUsuario.isEmpty ?
                      CircleAvatar(radius: 52,
                        backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                      ) :
                      ClipOval(child: Image.memory( base64Decode(fotoUsuario), height: 100, width: 100,) ),
                  )
              ),

              SizedBox( height: 7.0, ),

              Align( alignment: Alignment.bottomCenter ,
                child: Text( "${widget.usuario.txNome}",
                  style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),

              Align( alignment: Alignment.bottomCenter,
                child: Text( "${widget.usuario.txLogin}",
                  style: TextStyle( color: Colors.black, fontSize: 16.0, ),
                ),
              ),

              SizedBox( height: 10.0, ),

              Align( alignment: Alignment.bottomCenter,
                child: Text( '- Cadastrado em ${widget.usuario.dtCadastro} -',
                  style: TextStyle( color: Colors.black54, fontSize: 12.0 ),
                ),
              ),

              SizedBox( height: 5.0, ),
              Divider(color: Palette.main,),

              SizedBox( height: 15.0, ),

              BotaoTipo.fullLinha(text: "Alterar Dados Pessoais", icon: Icons.edit, iconColor: Colors.orange.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Alterar_DadosUsuario_PageView( usuario: widget.usuario )),
                  );
                },
              ),

              SizedBox( height: 5.0, ),

              BotaoTipo.fullLinha(text: "Alterar Foto de Perfil", icon: Icons.add_photo_alternate, iconColor: Colors.orange.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Alterar_ImagemPerfil_PageView( usuario: widget.usuario ) ),
                  ).then((value) => loadFotoUsuario());
                },
              ),

              SizedBox( height: 5.0, ),

              BotaoTipo.fullLinha(text: "Alterar Senha", icon: Icons.password, iconColor: Colors.orange.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Alterar_Senha_PageView( usuario: widget.usuario ) ),
                  );
                },
              ),


              SizedBox( height: 25.0, ),

            ],
          )
        )
      )
    );
  }

//----------------------------------------------------------------------------//

  visualizarImagem(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: fotoUsuario,)),
    );
  }

//----------------------------------------------------------------------------//

}