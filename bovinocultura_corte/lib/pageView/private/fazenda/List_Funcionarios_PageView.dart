
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../clienteService/fazenda/ColaboradorFazendaService.dart';
import '../../../dataModel/fazenda/ColaboradorFazenda.dart';
import '../../../dataModel/fazenda/VWColaboradorFazenda.dart';
import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';
import 'NewFuncionario_PageView.dart';

class List_Funcionarios_PageView extends StatefulWidget {
  const List_Funcionarios_PageView({Key? key, required this.usuario, required this.fazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;

  @override
  _List_Funcionarios_PageView createState() => _List_Funcionarios_PageView();
}

//============================================================================//

class _List_Funcionarios_PageView extends State<List_Funcionarios_PageView> {

  List<VWColaboradorFazenda> listFuncionario = [];

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadFuncionarios();
  }

//----------------------------------------------------------------------------//

  loadFuncionarios() async {
    try{
      listFuncionario = [];

      List<VWColaboradorFazenda> list = await ColaboradorFazendaService.getInstance().
        getAllByFazenda(pkFazenda: widget.fazenda.pkFazenda!);

      setState(() {
        listFuncionario = list;
      });

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Paineis.appBar(context: context, text: ('Funcionarios'), ),
      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 20),

              BotaoTipo.padrao(text: "   Adicionar Funcionario   ",
                onPressed: (){
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => NewFuncionario_PageView(usuario: widget.usuario, fazenda: widget.fazenda,)),
                  ).then((value) => loadFuncionarios());
                }
              ),

              SizedBox(height: 10),

              Expanded(child: listFuncionariosRegistrados() )

            ],
          )
        ),

      )
    );
  }


  Widget listFuncionariosRegistrados() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listFuncionario.length,
      itemBuilder: (context, index) {

        return Card(color: listFuncionario[index].ativa! ? Colors.white:Colors.grey.shade200,
            child:
          InkWell(
            onTap: (){
              detalheAction(listFuncionario[index]);
            },
            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

              Row(children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Texto.referenciaConteudo(referencia: "Nome", conteudo: "${listFuncionario[index].txNome}"),
                  Texto.referenciaConteudo(referencia: "Email", conteudo: "${listFuncionario[index].txLogin}"),
                  Texto.referenciaConteudo(referencia: "Data Nascimento", conteudo: "${listFuncionario[index].dtNascimento}"),
                  Texto.referenciaConteudo(referencia: "Nivel Acesso", conteudo: "${listFuncionario[index].nivAcessNome}"),
                  listFuncionario[index].ativa! ? SizedBox(height: 1,):
                    Texto.referenciaConteudo(referencia: "Inativado em", conteudo: "${listFuncionario[index].dtRemocao}"),
                ]),

                Expanded(child: Text("")),

                Icon(Icons.arrow_right_sharp),

            ],),

            )
          )
        );

      }
    );
  }


//============================================================================//

  detalheAction(VWColaboradorFazenda vwColaborador){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewFuncionario_PageView(usuario: widget.usuario,
              fazenda: widget.fazenda, colaboradorFazenda: vwColaborador,)),
    ).then((value) => loadFuncionarios());
  }

}