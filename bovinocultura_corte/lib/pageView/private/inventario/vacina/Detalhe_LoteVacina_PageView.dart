
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../dataModel/Usuario.dart';
import '../../../../dataModel/fazenda/Fazenda.dart';
import '../../../../dataModel/inventario/LoteVacina.dart';
import '../../../componentes/Dimensinamento.dart';
import '../../../componentes/Paineis.dart';
import '../../../componentes/Textos.dart';
import 'NewLoteVacina_PageView.dart';

class Detalhe_LoteVacina_PageView extends StatefulWidget {
  const Detalhe_LoteVacina_PageView({Key? key, required this.usuario, required this.fazenda, required this.loteVacina }) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final LoteVacina loteVacina;

  @override
  _Detalhe_LoteVacina_PageView createState() => _Detalhe_LoteVacina_PageView();
}

//============================================================================//

class _Detalhe_LoteVacina_PageView extends State<Detalhe_LoteVacina_PageView> {



//----------------------------------------------------------------------------//

  @override
  void initState() {

  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Paineis.appBar(context: context, text: ('Lote Vacina'),),
        body: Paineis.Pagina_Statica(context: context,
          child: Container(
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context) .size .width),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 15),

                  Row(children: [
                    Expanded(child: SizedBox(height: 1,)),
                    IconButton(onPressed: editAction, icon: Icon(Icons.edit_outlined),tooltip: "Editar Dados!", color: Palette.primary.shade500),
                  ],),

                  Texto.subtitulo(context: context, title: "Informações do Produto", fontSize: 20),
                  SizedBox(height: 15),
                  Texto.referenciaConteudo(referencia: "Lote", conteudo: "${widget.loteVacina.txNomeLoteVacina!}."),
                  Texto.referenciaConteudo(referencia: "Vacina", conteudo: "${widget.loteVacina.txNomeVacina!}."),
                  Texto.referenciaConteudo(referencia: "Vencimento", conteudo: "${widget.loteVacina.dtVencimento}."),
                  Texto.referenciaConteudo(referencia: "Obrigatória", conteudo: "${widget.loteVacina.obrigatoria! ? "Sim":"Não"}."),
                  SizedBox(height: 10),

                  Divider(),

                  SizedBox(height: 15),
                  Texto.subtitulo(context: context, title: "Nota Fiscal", fontSize: 20),
                  SizedBox(height: 15),

                  Texto.referenciaConteudo(referencia: "Unidades", conteudo: "${widget.loteVacina.nrUnidades}."),
                  Texto.referenciaConteudo(referencia: "Valor Unidade", conteudo: "R\$ ${ (widget.loteVacina.nrCusto! / widget.loteVacina.nrUnidades!).toStringAsFixed(2)}."),
                  Texto.referenciaConteudo(referencia: "Valor Total", conteudo: "R\$ ${widget.loteVacina.nrCusto!.toStringAsFixed(2)}."),

                  SizedBox(height: 10),

                  Divider(),

                  Texto.referenciaConteudo(referencia: "Observação", conteudo: "${widget.loteVacina.txObservacao}."),

                  Divider(),

                  Texto.textoPadrao(title: "Cadastrado em: ${widget.loteVacina.dtCadastro}",fontSize: 10),

                  Divider(),



                ],
              )
          ),

        )
    );
  }

//----------------------------------------------------------------------------//

  editAction(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => NewLoteVacina_PageView(usuario: widget.usuario,
            fazenda: widget.fazenda, loteVacina: widget.loteVacina, isObrigatoria: false,)),
    );
  }
//----------------------------------------------------------------------------//

}