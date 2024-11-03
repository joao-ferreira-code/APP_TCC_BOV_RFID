
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../clienteService/bovino/BovinoFazendaService.dart';
import '../../../dataModel/animal/VWBovinoFazenda.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/PaletaCores.dart';
import '../../componentes/Textos.dart';
import 'ConsultaAnimal_PageView.dart';
import 'cadastro/NewAnimal_Compra_PageView.dart';
import 'cadastro/NewAnimal_Nascido_PageView.dart';

class List_Bovino_PageView extends StatefulWidget {
  const List_Bovino_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_Bovino_PageView createState() => _List_Bovino_PageView();
}

//============================================================================//

class _List_Bovino_PageView extends State<List_Bovino_PageView> {

  bool buscou = false;

  List<VWBovinoFazenda> listBovino = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadListAnimal();
  }

//----------------------------------------------------------------------------//

  loadListAnimal() async {
    try{
      buscou = false;
      listBovino = [];
      List<VWBovinoFazenda> list = await BovinoFazendaService.getInstance().
          getAllBovinoByFazenda(fkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        buscou = true;
        listBovino = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Animais Registrados'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            children: [

              SizedBox(height: 10),

              Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                IconButton(icon: Icon(Icons.add),
                    onPressed: cadastroAnimalAction
                ),

                SizedBox(width: 15,),

                IconButton(icon: Icon(Icons.search),
                  onPressed: (){
                    Navigator.push( context,
                      MaterialPageRoute(
                          builder: (context) => ConsultaAnimal_PageView(
                            usuario: widget.usuario, fazenda: widget.fazenda,)),
                    );
                  },
                ),

              ],),


              SizedBox(height: 10),

              buscou?
                listBovino.isEmpty?
                  Column(children: [
                    SizedBox(height: 40,),
                    Texto.textoPadrao(title: "Animais Não Encontrados!", fontSize: 16),
                    IconButton(onPressed: loadListAnimal, tooltip: "Atualizar.",
                        icon: Icon(Icons.refresh, color: Palette.colorBeckground)),
                  ],):
                  Expanded(child: listPesagens() )
                :Texto.textoPadrao(title: "...")

            ],
          )
        ),

      )
    );
  }

//----------------------------------------------------------------------------//

  Widget listPesagens() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listBovino.length,
      itemBuilder: (context, index) {

        return Card(color: listBovino[index].pkDescarteBovino != null ? Colors.grey.shade200:Colors.white,
            child:
          InkWell(
              onTap: (){
                detalheAction(listBovino[index]);
              },
            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7), child:
              Row(children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Texto.referenciaConteudo(referencia: "Código Animal", conteudo: "${listBovino[index].pkBovino}"),
                    listBovino[index].txCodigoEpc != null ?
                    Texto.referenciaConteudo(referencia: "Código. RFID", conteudo: "${listBovino[index].txCodigoEpc}"):SizedBox(height: 1,),

                    SizedBox(height: 3,),

                    Texto.referenciaConteudo(referencia: "Sexo", conteudo: "${listBovino[index].bovTxSexo == "M" ? "Macho" : "Femea" }"),
                    Texto.referenciaConteudo(referencia: "Raça", conteudo: "${listBovino[index].racTxNome}"),

                    listBovino[index].pkDescarteBovino != null ?
                    Column(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 3,),

                          Texto.referenciaConteudo(referencia: "Status", conteudo: "Descartado"),

                      ],):SizedBox(height: 1,),

                ],),
                Expanded(child: Text("")),
                Icon(Icons.arrow_right_sharp)

              ],)
            )
          )
        );

      }
    );
  }

//=========================================================================================//

  cadastroAnimalAction(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Cadastrar Animal'),
        actions: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                style: TextButton.styleFrom( primary: Palette.main ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewAnimal_Compra_PageView(usuario: widget.usuario, fazenda: widget.fazenda)),
                  ).then((value) => loadListAnimal());
                },
                child: const Text('    Compra    '),
              ),
              SizedBox(width: 10,),
              TextButton(
                style: TextButton.styleFrom( primary: Palette.main, ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewAnimal_Nascido_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  ).then((value) => loadListAnimal());
                },
                child: const Text('  Nascimento  '),
              ),



            ],)

        ],
      ),
    );
  }

//=========================================================================================//

  void detalheAction(VWBovinoFazenda bovino) {
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => ConsultaAnimal_PageView(
            usuario: widget.usuario, fazenda: widget.fazenda, codAnimal: bovino.pkBovino,)),
    );
  }


}