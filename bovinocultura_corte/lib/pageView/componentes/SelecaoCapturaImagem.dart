
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Dimensinamento.dart';
import 'Paineis.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Images;

import 'dart:convert';

class SelecaoCapturaImagem extends StatefulWidget {
  const SelecaoCapturaImagem({Key? key}) : super(key: key);

  @override
  _SobreAPP_PageView createState() => _SobreAPP_PageView();
}

//============================================================================//

class _SobreAPP_PageView extends State<SelecaoCapturaImagem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(
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
                      Navigator.pop(context, base64Image);
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
                      if(image!=null){
                        var images = Images.decodeImage(await image.readAsBytes());
                        var thumbnail = Images.copyResize(images!, width: 400, height: 400);
                        List<int> imageBytes = Images.encodePng(thumbnail);
                        base64Image = base64Encode(imageBytes);
                      }
                      Navigator.pop(context, base64Image);
                    },
                      icon: Icon(Icons.photo), tooltip: "Abrir Galeria", color: Colors.brown,),
                    Text("Galeria", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                  ),

                ],
              )
            ],
          ),
        )

      )
    );
  }

//============================================================================//

}