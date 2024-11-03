
import 'package:bovinocultura_corte/clienteService/admSistema/CidadeService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../clienteService/admSistema/EstadoService.dart';
import '../../dataModel/Usuario.dart';
import '../../dataModel/admSistema/Cidade.dart';
import '../../dataModel/admSistema/Estado.dart';
import '../componentes/Botoes.dart';
import '../componentes/DateFormatter.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/DropDown.dart';
import '../componentes/InputFormatter.dart';
import '../componentes/Inputs.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import '../componentes/SelecaoCapturaImagem.dart';
import '../componentes/Textos.dart';
import 'NewUser_DadosAcesso_PageView.dart';

import 'dart:convert';

import 'VisualizarImagem_PageView.dart';


class NewUser_DadosUsuario_PageView extends StatefulWidget {
  const NewUser_DadosUsuario_PageView({Key? key}) : super(key: key);

  @override
  _NewUser_DadosUsuario_PageView createState() => _NewUser_DadosUsuario_PageView();
}

//=========================================================================================//

class _NewUser_DadosUsuario_PageView extends State<NewUser_DadosUsuario_PageView> {

  final _userName = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _nrTelefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String result = "";

  List<Estado> listEstado = [];
  Estado estado = new Estado(txNome: "Selecione...");

  List<Cidade> listCidade = [];
  Cidade cidade = new Cidade(txNome: "Selecione...");

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadEstados();
  }

//----------------------------------------------------------------------------//

  loadEstados() async {
    try {
      var list = await EstadoService.getInstance().getAllEstado();
      setState(() {
        estado = list[0];
        listEstado = list;
      });
      loadCidades();
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

  loadCidades() async {
    try {
      listCidade = [];
      var list = await CidadeService.getInstance().getAllCidadeByEstadoId(estado.pkEstado!);
      setState(() {
        cidade = list[0];
        listCidade = list;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: _scaffoldKey,
      appBar: Paineis.appBar(context: context, text: "Cadastar Conta"),

      body: Paineis.Pagina( context: context, isPlanoFundo_01: false,
        child: Form( key: _formKey,
          child: Container(
              transformAlignment: Alignment.topCenter,
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child:
                    Texto.titulo(context: context, title: "Dados Pessoais.", color: Colors.black),
                  ),


                  InkWell(
                    onTap: visualizarImagem ,
                    child: Stack(
                      children: [

                        result.isEmpty?
                          CircleAvatar(radius: 67,
                            backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                          ) :
                          ClipOval(child: Image.memory( base64Decode(result), height: 134, width: 134,) ),


                        Padding(padding: EdgeInsets.only(top: 90, left: 95),
                          child: IconButton( onPressed: () async {
                              result = await showModalBottomSheet( context: context,
                                builder: (BuildContext bc) {
                                  return Container( height: 150,
                                      child: SelecaoCapturaImagem());
                                }
                              );
                              setState(() {
                                result;
                              });
                            },
                            icon: Icon(Icons.add_photo_alternate_rounded, color: Palette.colorBeckground.shade900, size: 40,)),
                        ),

                        result.isNotEmpty ?
                          IconButton( onPressed: (){
                            setState(() {
                              result = "";
                            });
                          }, icon: Icon(Icons.delete_forever, color: Colors.red.shade600, size: 40,)
                          )
                          :SizedBox(height: 1),

                      ],
                    )
                  ),

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

                  BotaoTipo.padrao(text: "Proximo", size: MediaQuery.of(context).size.width * .675,
                      onPressed: cadastrarDadosDeAcesso
                  ),

                  SizedBox( height: 25, ),

                ],
              )

          )
        )
      ),
    );
  }

//=========================================================================================//

  Future<void> cadastrarDadosDeAcesso() async {
    if (_formKey.currentState!.validate()){

      Usuario usuario  = new Usuario(txNome: _userName.text, dtNascimento: _dataNascimento.text,
          txTelefone: _nrTelefone.text,fkCidade: cidade.pkCidade,
          dtCadastro: "${DateFormatter.formatTime( dateTime: DateTime.now() )}",
          btFotoUsuario: result
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewUser_DadosAcesso_PageView( usuario: usuario) ),
      );
    }
  }

//----------------------------------------------------------------------------//

  visualizarImagem(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: result,)),
    );
  }

//=========================================================================================//

}

