
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';

class PoliticaPrivacidade_PageView extends StatefulWidget {
  const PoliticaPrivacidade_PageView({Key? key}) : super(key: key);

  @override
  _PoliticaPrivacidade_PageView createState() =>  _PoliticaPrivacidade_PageView();
}

//============================================================================//

class _PoliticaPrivacidade_PageView extends State<PoliticaPrivacidade_PageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
          child: Container(
            width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
            child: Container(
              height: 150,
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Text("Escolha a Foto do Perfil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 20,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        IconButton(onPressed: (){
                          pickImage(ImageSource.camera,);
                          Navigator.pop(context);
                        },
                            icon: Icon(Icons.camera_alt), tooltip: "Abrir Camera", color: Colors.brown),
                        Text("Camera", style: TextStyle(fontWeight: FontWeight.bold)),
                      ]
                      ),

                      SizedBox(width: 50,),

                      Column(children: [
                        IconButton(onPressed:(){
                          pickImage(ImageSource.gallery,);
                          Navigator.pop(context);
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
          ),
        )
    );

  }

//=========================================================================================//

  Future pickImage(ImageSource source,) async {
    /*final image = await ImagePicker().pickImage( source: source,);

    if(image == null){ return; }

    this.image = File(image.path);
    setState(() {
      isCapturadaImagem = true;
    });*/

  }

//=========================================================================================//

}
