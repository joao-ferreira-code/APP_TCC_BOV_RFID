
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Botoes.dart';
import '../componentes/Card.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import '../componentes/Textos.dart';


class SupportTecnico_PageView extends StatefulWidget {
  const SupportTecnico_PageView({Key? key}) : super(key: key);

  @override
  _SupportTecnico_PageView createState() => _SupportTecnico_PageView();
}

//============================================================================//

class _SupportTecnico_PageView extends State<SupportTecnico_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Contate-Nos')),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child: Column(
              children: [

                SizedBox(height: 20,),

                Texto.titulo( context: context, title: "Contato"),

                SizedBox( height: 5.0,),

                BotaoTipo.fullLinha(text: "emailteste@hotmail.com", icon: Icons.email_outlined,
                  iconColor: Palette.primary.shade500,fontSize: 18,
                  onPressed: () { },
                ),

                SizedBox( height: 5.0,),

                BotaoTipo.fullLinha(text: "(79) 9 9999-9999", icon: Icons.phone,
                  iconColor: Palette.primary.shade500, fontSize: 18,
                  onPressed: () { },
                ),

                SizedBox( height: 20.0,),

                Text("Redes Sociais",
                  style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),),

                BotaoTipo.fullLinha(text: "(79) 9 9999-9999", icon: Icons.call,
                  iconColor: Palette.primary.shade500, fontSize: 18,
                  onPressed: () { },
                ),

                SizedBox( height: 5,),

                BotaoTipo.fullLinha(text: "@cathitoprogrammer", icon: Icons.facebook,
                  iconColor: Palette.primary.shade500, fontSize: 18,
                  onPressed: () { },
                ),

                SizedBox( height: 20.0,),

              ]
          )
        ),
      )
    );
  }

}