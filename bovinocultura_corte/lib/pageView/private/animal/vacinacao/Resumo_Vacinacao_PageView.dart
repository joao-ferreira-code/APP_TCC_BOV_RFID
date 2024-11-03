
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../clienteService/bovino/VacinacaoBovinoService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/DropDown.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';

class Resumo_Vacinacao_PageView extends StatefulWidget {
  const Resumo_Vacinacao_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _Resumo_Vacinacao_PageView createState() => _Resumo_Vacinacao_PageView();
}

//============================================================================//

class _Resumo_Vacinacao_PageView extends State<Resumo_Vacinacao_PageView> {

  List<int> listIntervalos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int intervaloSelecionado = 1;

  List<dynamic> resumo = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadResumo();
  }

//----------------------------------------------------------------------------//

  loadResumo() async {
    try{

      List<dynamic> rs = await VacinacaoBovinoService.getInstance()
          .resunoBY(fkFazenda: widget.fazenda.pkFazenda!, intervalo: intervaloSelecionado);

      setState(() {
        resumo = rs;
      });

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Resumo Vacinação'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            children: [

              Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Texto.titulo(context: context,title: intervaloSelecionado == 1?"No Ultimo":"Nos Ultimos", fontSize: 14),
                    SizedBox(height: 5,),
                    Container(width: 100, child:
                      DropDown.ByInt(
                        items: listIntervalos,
                        value: intervaloSelecionado,
                        onChanged: (value) {
                          setState(() {
                            intervaloSelecionado = value!;
                            loadResumo();
                          });
                        },
                      )
                    ),
                    SizedBox(height: 5,),
                    Texto.titulo(context: context,title: intervaloSelecionado == 1?"Mes":"Meses", fontSize: 14),

                  ],),
              ),

              SizedBox(height: 25,),

              resumo.isNotEmpty && "${resumo[0]}" != "0" ?
              Card(child:
                Padding(padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                  child:
                  Column(children: [

                    Texto.titulo(context: context,title: "Numero Animais!", fontSize: 16),
                    SizedBox(height: 3,),
                    Texto.titulo(context: context,title: "${resumo[0]}", fontSize: 14),

                    Divider(color: Colors.black45, thickness: 2, height: 25),

                    Row(children: [

                      Expanded(child:
                        Column(children: [
                          Texto.titulo(context: context,title: "Femeas!", fontSize: 16),
                          SizedBox(height: 3,),
                          Texto.titulo(context: context,title: "${resumo[0] - resumo[1]}", fontSize: 14),
                        ],)
                      ),

                      Container(width: 2, height: 35, color: Colors.black45,),

                      Expanded(child:
                        Column(children: [
                          Texto.titulo(context: context,title: "Machos!", fontSize: 16),
                          SizedBox(height: 3,),
                          Texto.titulo(context: context,title: "${resumo[1]}", fontSize: 14),
                        ],)
                      )

                    ],),

                    Divider(color: Colors.black45, thickness: 2, height: 25),

                    Row(children: [

                      Expanded(child:
                        Column(children: [
                          Texto.titulo(context: context,title: "Compra!", fontSize: 16),
                          SizedBox(height: 3,),
                          Texto.titulo(context: context,title: "${resumo[2]}", fontSize: 14),
                        ],)
                      ),

                      Container(width: 2, height: 35, color: Colors.black45),

                      Expanded(child:
                        Column(children: [
                          Texto.titulo(context: context,title: "Nascidos!", fontSize: 16),
                          SizedBox(height: 3,),
                          Texto.titulo(context: context,title: "${resumo[3]}", fontSize: 14),
                        ],)
                      )

                    ],)


                  ],)
                )
              )
                  :
              Column(children: [
                SizedBox(height: 20,),
                Texto.titulo(context: context,title: "Nenhum Registro Encontrado!", fontSize: 14),
              ],)

            ],
          )
        ),

      )
    );
  }

}