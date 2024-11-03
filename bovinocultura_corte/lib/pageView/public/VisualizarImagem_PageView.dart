
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';


class VisualizarImagem_PageView extends StatefulWidget {
  VisualizarImagem_PageView({Key? key, required this.fotoUsuario}) : super(key: key);

  final String fotoUsuario;

  @override
  _VisualizarImagem_PageView createState() => _VisualizarImagem_PageView();
}

//=========================================================================================//

class _VisualizarImagem_PageView extends State<VisualizarImagem_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Visualizando Imagem'),),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Center(
            child:

            widget.fotoUsuario.isEmpty?
              CircleAvatar(radius: 177,
                backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
              ) :
              ClipOval(child: Image.memory( base64Decode(widget.fotoUsuario), height: 350, width: 350,) ),


          )
        )
      )
    );
  }

}
