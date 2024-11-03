
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dataModel/Usuario.dart';
import '../../../dataModel/fazenda/Fazenda.dart';
import '../../componentes/Card.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';
import '../../public/VisualizarImagem_PageView.dart';
import 'List_Funcionarios_PageView.dart';
import 'NewFazenda_PageView.dart';

class Fazenda_Main_PageView extends StatefulWidget {
  const Fazenda_Main_PageView({Key? key, required this.usuario, required this.fazenda, required this.fotoFazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final String fotoFazenda;
  @override
  _Fazenda_Main_PageView createState() => _Fazenda_Main_PageView();
}

//============================================================================//

class _Fazenda_Main_PageView extends State<Fazenda_Main_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Fazenda'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Row( children: [
                InkWell(
                  onTap: visualizarImagemFazenda,
                  child: widget.fotoFazenda.isEmpty ?
                  CircleAvatar(radius: 45,
                    backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                  ) :
                  ClipOval(child: Image.memory( base64Decode(widget.fotoFazenda), height: 90, width: 90,) ),
                ),

                SizedBox(width: 8,),

                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Texto.referenciaConteudo(referencia: "Nome", conteudo: widget.fazenda.txNome!, fontSize: 16.0),
                        Texto.referenciaConteudo(referencia: "Cod.", conteudo: widget.fazenda.txCodigoPublico!, fontSize: 16.0),
                        SizedBox(height: 5,),
                        Texto.referenciaConteudo(referencia: "Telefone", conteudo: "${widget.fazenda.txTelefone == null ? "Não Informado!" : widget.fazenda.txTelefone!}"),
                        Texto.referenciaConteudo(referencia: "Area", conteudo: "${widget.fazenda.nrTotalHectares} Hectares"),

                        SizedBox(height: 5,),

                        Text( '- Cadastrado em ${widget.fazenda.dtCadastro} -',
                          style: TextStyle( color: Colors.black54, fontSize: 12.0 ),
                        ),


                      ],)
                ),

              ]
              ),

              Divider(),
              SizedBox(height: 5),

              /*Cards.click(text: "Atualizar Foto", icon: Icons.image,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => ConsultaAnimal_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),*/

              Cards.click(text: "Editar Dados", icon: Icons.edit_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewFazenda_PageView(usuario: widget.usuario,
                          fazenda: widget.fazenda,fotoFazenda: widget.fotoFazenda,)),
                  );
                },
              ),

              Cards.click(text: "Funcionarios", icon: Icons.person_pin_outlined,
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => List_Funcionarios_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                  );
                },
              ),


            ],
          )
        ),
      )
    );
  }

//=========================================================================================//

  visualizarImagemFazenda(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: widget.fotoFazenda,)),
    );
  }


}