
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';

import '../../../../clienteService/Inventario/LoteVacinaService.dart';
import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteVacina.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Mensagens.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';
import 'Detalhe_LoteVacina_PageView.dart';
import 'NewLoteVacina_PageView.dart';


class List_LoteVacinaRotineira_PageView extends StatefulWidget {
  const List_LoteVacinaRotineira_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_LoteVacinaRotineira_PageView createState() => _List_LoteVacinaRotineira_PageView();
}

//============================================================================//

class _List_LoteVacinaRotineira_PageView extends State<List_LoteVacinaRotineira_PageView> {

  List<LoteVacina> listLote = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadLoteVacina();
  }

//----------------------------------------------------------------------------//

  loadLoteVacina() async {
    try{
      listLote = [];
      List<LoteVacina> list = await LoteVacinaService.getInstance().
            getAllLoteRotineiraByFazenda(fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        listLote = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }

  }

//----------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Paineis.Pagina_Statica(context: context,
        child: Column(children: [

            Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                child: IconButton(onPressed: cadastroAction, tooltip: "Adicionar Lote.",
                    icon: Icon(Icons.add))
            ),

            listLote.isEmpty?
              Column(children: [
                SizedBox(height: 40,),
                Texto.textoPadrao(title: "Nenhum Registro Encontrado!", fontSize: 16),
                IconButton(onPressed: loadLoteVacina, tooltip: "Atualizar.",
                    icon: Icon(Icons.refresh, color: Palette.colorBeckground)),
              ],):
              Expanded(child: listLotes(),)

          ],
        )
      ),
    );
  }

  Widget listLotes() {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: listLote.length,
        itemBuilder: (context, index) {

          return Card(child:
            InkWell(
              onTap: () => detalhesAction(listLote[index]),
              child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

              Row(children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  Texto.referenciaConteudo(referencia: "Lote", conteudo: "${listLote[index].txNomeLoteVacina}"),
                  Texto.referenciaConteudo(referencia: "Vacina", conteudo: "${listLote[index].txNomeVacina}"),
                  SizedBox(height: 3,),
                  Texto.referenciaConteudo(referencia: "Unidades", conteudo: "${listLote[index].nrUnidades}"),
                  Texto.referenciaConteudo(referencia: "Vencimento", conteudo: "${listLote[index].dtVencimento}"),
                ]),

                Expanded(child: Text("")),
                IconButton(
                    onPressed: (){ },
                    icon: Icon(Icons.arrow_right_sharp)),

              ],),

              )
            )
          );

        }
    );
  }

//=========================================================================================//

  cadastroAction(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewLoteVacina_PageView(usuario: widget.usuario,
            fazenda: widget.fazenda, isObrigatoria: false,)),
    ).then((value) => loadLoteVacina());
  }

//-----------------------------------------------------------------------------------//

  detalhesAction(LoteVacina listLote) {
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => Detalhe_LoteVacina_PageView(usuario: widget.usuario,
            fazenda: widget.fazenda, loteVacina: listLote,)),
    ).then((value) => loadLoteVacina());
  }

//=========================================================================================//

}