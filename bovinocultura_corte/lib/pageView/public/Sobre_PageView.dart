
import 'package:bovinocultura_corte/pageView/public/PoliticaPrivacidade_PageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componentes/Botoes.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Paineis.dart';
import 'Creditos_PageView.dart';
import 'SobreAPP_PageView.dart';
import 'SupportTecnico_PageView.dart';
import 'TermosDeServico_PageView.dart';


class Sobre_PageView extends StatefulWidget {
  const Sobre_PageView({Key? key}) : super(key: key);

  @override
  _Sobre_PageView createState() => _Sobre_PageView();
}

//============================================================================//

class _Sobre_PageView extends State<Sobre_PageView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: "Sobre"),
      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Divider(),

              BotaoTipo.fullLinha( text: "Sobre o App", icon: Icons.details_rounded,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => SobreAPP_PageView()),
                  );
                }
              ),

              Divider(),

              BotaoTipo.fullLinha( text: "Creditos", icon: Icons.email_outlined,
                  onPressed: () {
                    Navigator.push( context,
                      MaterialPageRoute(
                          builder: (context) => Creditos_PageView()),
                    );
                  }
              ),

              Divider(),

              BotaoTipo.fullLinha( text: "Suporte", icon: Icons.support_agent_rounded,
                  onPressed: () {
                    Navigator.push( context,
                      MaterialPageRoute(
                          builder: (context) => SupportTecnico_PageView()),
                    );
                  }
              ),

              Divider(),

              BotaoTipo.fullLinha( text: "Política de Privacidade", icon: Icons.policy_outlined,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => PoliticaPrivacidade_PageView()),
                  );
                }
              ),

              Divider(),

              BotaoTipo.fullLinha( text: "Termo de Uso", icon: Icons.privacy_tip_outlined,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => TermosDeServico_PageView()),
                  );
                }
              ),

              Divider(),


            ],
          )
        ),

      )
    );
  }

//=========================================================================================//

  emDesenvolvimento() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Em Desenvolvimeno!'),
            content: const Text(
                'Funcionalidade em desenvolvimento, solicitamos que aguarde atualizações!'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary: Colors.teal,),
                onPressed: () {
                  Navigator.pop(context, "Ok");
                },
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }

//=========================================================================================//

}