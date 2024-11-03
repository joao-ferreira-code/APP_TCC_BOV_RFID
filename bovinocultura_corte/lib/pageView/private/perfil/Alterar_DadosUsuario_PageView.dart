
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../clienteService/UsuarioService.dart';
import '../../../clienteService/admSistema/CidadeService.dart';
import '../../../clienteService/admSistema/EstadoService.dart';
import '../../../dataModel/Usuario.dart';

import '../../../dataModel/admSistema/Cidade.dart';
import '../../../dataModel/admSistema/Estado.dart';
import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/DropDown.dart';
import '../../componentes/InputFormatter.dart';
import '../../componentes/Inputs.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../public/VisualizarImagem_PageView.dart';

class Alterar_DadosUsuario_PageView extends StatefulWidget {
  const Alterar_DadosUsuario_PageView({Key? key, required this.usuario }) : super(key: key);

  final Usuario usuario;

  @override
  _Alterar_DadosUsuario_PageView createState() => _Alterar_DadosUsuario_PageView();
}

//=========================================================================================//

class _Alterar_DadosUsuario_PageView extends State<Alterar_DadosUsuario_PageView> {

  final _userName = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _nrTelefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? image;
  bool isCapturadaImagem = false;

  List<Estado> listEstado = [];
  Estado estado = new Estado(txNome: "Selecione...");

  List<Cidade> listCidade = [];
  Cidade cidade = new Cidade(txNome: "Selecione...");

//----------------------------------------------------------------------------//
  @override
  void initState() {
    loadEstados();
    setState(() {
      _userName.text = widget.usuario.txNome!;
      _dataNascimento.text = widget.usuario.dtNascimento!;
      _nrTelefone.text = widget.usuario.txTelefone!;
    });
  }

//----------------------------------------------------------------------------//

  loadEstados() async {
    try {
      var list = await EstadoService.getInstance().getAllEstado();
      setState(() {
        listEstado = list;
        estado = listEstado[0];
      });
      loadCidadeById();
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

  loadCidades() async {
    try {
      listCidade = [];
      var list = await CidadeService.getInstance().getAllCidadeByEstadoId(estado.pkEstado!);
      setState(() {
        listCidade = list;
      });

      for(int i = 0; i<listCidade.length; i++){
        if(listCidade[i].pkCidade == widget.usuario.fkCidade!){
          setState(() {
            cidade =  listCidade[i];
          });
          break;
        }
      }

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadCidadeById() async {
    try {
      Cidade cid = await CidadeService.getInstance().getCidadeById(widget.usuario.fkCidade!);
      loadEnderecosCadastrados(cid.pkCidade!,cid.fkEstado!);
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

  loadEnderecosCadastrados(int cidNrId, int estNrId){
    for(int i = 0; i<listEstado.length; i++){
      if(listEstado[i].pkEstado == estNrId){
        setState(() {
          estado = listEstado[i];
        });
        break;
      }
    }
    loadCidades();
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: ('Alterar Dados Pessoais'),),

      body: Paineis.Pagina(context: context, isPlanoFundo_01: false,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child:

            Form( key: _formKey,
              child: Container(
                  transformAlignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width * .90,

                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /*SizedBox( height: 10.0, ),


                      InkWell(
                        onTap: visualizarImagem ,
                        child: Stack(
                          children: [

                            !isCapturadaImagem?
                              CircleAvatar(radius: 67,
                                backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                              ) :
                              ClipOval(child: Image.file(image!, width: 134, height: 134,), ),

                            Padding(padding: EdgeInsets.only(top: 82, left: 87),
                              child:
                                IconButton( onPressed: (){
                                    Navigator.push( context,
                                      MaterialPageRoute(
                                          builder: (context) => Alterar_ImagemPerfil_PageView( usuario: widget.usuario ) ),
                                    );
                                  },
                                    icon: Icon(Icons.edit, color: Colors.cyan, size: 40,)),
                            ),

                          ],
                        )
                      ),*/

                      SizedBox( height: 10.0, ),


                      InputTipo.createInputText(textoConteudo: "Nome Completo", variavelArmazenaDado: _userName,
                        icon: Icons.person, inputType: TextInputType.text, validar: true,
                      ),

                      InputTipo.createInputText(textoConteudo: "Data Nascimento", variavelArmazenaDado: _dataNascimento,
                        icon: Icons.calendar_today_rounded, inputType: TextInputType.number, validar: true,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.data, ],
                      ),

                      InputTipo.createInputText(textoConteudo: "Telefone", variavelArmazenaDado: _nrTelefone,
                        icon: Icons.phone, inputType: TextInputType.number, validar: true,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.numeroCelular, ],
                      ),

                      SizedBox( height: 5.0, ),

                      Row( children: [
                        Expanded(child:
                        DropDown.ByEstado(
                          items: listEstado,
                          value: estado,
                          onChanged: (value) {
                            setState(() {
                              estado = value!;
                              loadCidades();
                            });
                          },
                        ),
                        ),

                        SizedBox( width: 12),

                        Expanded(child:
                        DropDown.ByCidade(
                          items: listCidade,
                          value: cidade,
                          onChanged: (value) {
                            setState(() {
                              cidade = value!;
                            });
                          },
                        ),
                        ),
                      ],
                      ),

                      SizedBox( height: 15, ),

                      BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                          onPressed: alterarDadosDoUsuario
                      ),

                      SizedBox( height: 25, ),


                    ],
                  )
              )
            )

        )
      ),
    );
  }


//=========================================================================================//

  alterarDadosDoUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        List<String> listDados = ["${widget.usuario.pkUsuario}", "${widget.usuario.txLogin}",
                _userName.text, _dataNascimento.text, _nrTelefone.text, "${cidade.pkCidade}"];

        if (await UsuarioService.getInstance().editarDadosUsuario( listDados: listDados )) {
          Navigator.pop(context);
          Mensagens.rodape(
              context: context, msg: "Edição Realizada Com Sucessso!");
        }
      } catch (e) {
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

  visualizarImagem(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: "") ),
    );
  }

//=========================================================================================//

}

