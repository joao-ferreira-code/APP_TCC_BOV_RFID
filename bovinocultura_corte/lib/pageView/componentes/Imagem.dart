
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagem {

//----------------------------------------------------------------------------//

  static tipoCapturaImagem( BuildContext context ){
    return Container(
      height: 150,
      child: Column(
        children: [
          SizedBox(height: 15,),
          Text("Escolha a Foto do Perfil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20,),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                IconButton(onPressed: () async {
                    final image = await ImagePicker().pickImage( source: ImageSource.camera,);

                    if(image == null){ return; }

                    File(image.path);
                },
                    icon: Icon(Icons.camera_alt), tooltip: "Abrir Camera", color: Colors.brown),
                Text("Camera", style: TextStyle(fontWeight: FontWeight.bold)),
              ]
              ),

              SizedBox(width: 50,),

              Column(children: [
                IconButton(onPressed:() async {
                  final image = await ImagePicker().pickImage( source: ImageSource.gallery,);

                  if(image == null){ return; }

                  File(image.path);
                },
                  icon: Icon(Icons.photo), tooltip: "Abrir Galeria", color: Colors.brown,),
                Text("Galeria", style: TextStyle(fontWeight: FontWeight.bold)),
              ]
              ),

            ],
          )
        ],
      ),
    );
  }

//----------------------------------------------------------------------------//

}
