
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../clienteService/FotoUsuarioService.dart';
import '../../../dataModel/FotoUsuario.dart';
import '../../../dataModel/Usuario.dart';

import 'package:image/image.dart' as Images;

import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';

class Alterar_ImagemPerfil_PageView extends StatefulWidget {
  const Alterar_ImagemPerfil_PageView({Key? key, this.image, required this.usuario }) : super(key: key);

  final Usuario usuario;
  final File? image;

  @override
  _Alterar_ImagemPerfil_PageView createState() => _Alterar_ImagemPerfil_PageView();
}

//============================================================================//

class _Alterar_ImagemPerfil_PageView extends State<Alterar_ImagemPerfil_PageView> {

  String fotoUsuario = "";

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Perfil'), ),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child:
          fotoUsuario.isEmpty?
          Column(
            children: [
              Text("Escolha a Foto do Perfil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 15,),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    IconButton(onPressed: () async {
                      XFile? image = await ImagePicker().pickImage( source: ImageSource.camera,);

                      String base64Image = "";
                      if(image!=null){
                        var images = Images.decodeImage(await image.readAsBytes());
                        var thumbnail = Images.copyResize(images!, width: 400, height: 400);
                        List<int> imageBytes = Images.encodePng(thumbnail);
                        base64Image = base64Encode(imageBytes);
                      }
                      setState(() {
                        fotoUsuario = base64Image;
                      });
                    },
                        icon: Icon(Icons.camera_alt), tooltip: "Abrir Camera", color: Colors.brown),
                    Text("Camera", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                  ),

                  SizedBox(width: 50,),

                  Column(children: [
                    IconButton(onPressed:() async {
                      XFile? image = await ImagePicker().pickImage( source: ImageSource.gallery,);

                      String base64Image = "";
                      if(image != null){
                        var images = Images.decodeImage(await image.readAsBytes());
                        var thumbnail = Images.copyResize(images!, width: 400, height: 400);
                        List<int> imageBytes = Images.encodePng(thumbnail);
                        base64Image = base64Encode(imageBytes);
                      }
                      setState(() {
                        fotoUsuario = base64Image;
                      });
                    },
                      icon: Icon(Icons.photo), tooltip: "Abrir Galeria", color: Colors.brown,),
                    Text("Galeria", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                  ),

                ],
              )
            ],
          ):
          Column(children: [

            fotoUsuario.isEmpty?
            CircleAvatar(radius: 137,
              backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
            ) :
            ClipOval(child: Image.memory( base64Decode(fotoUsuario), height: 270, width: 270,) ),

            Texto.textoPadrao(title: "Pre-Visualização"),

            SizedBox(height: 15),

            BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
              onPressed: salvarAction
            ),

          ],
          )
        )
      )
    );
  }

//----------------------------------------------------------------------------//

  salvarAction() async {
    if(fotoUsuario.isNotEmpty){
      try{
        FotoUsuario fto = new FotoUsuario();
        fto.btFotoUsuario = fotoUsuario;
        fto.fkUsuario = widget.usuario.pkUsuario;
        fto.ativa = true;
        bool result = await FotoUsuarioService.getInstance().createFotoUsuario(fotoUsuario: fto);

        if(result){
          Mensagens.rodape(context: context, msg: "Imagem salva com sucesso!");
        }
      } catch (e) {
        Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
      }
    }
  }

}