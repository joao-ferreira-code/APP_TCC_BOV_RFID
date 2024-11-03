
import 'package:bovinocultura_corte/clienteService/admSistema/CidadeService.dart';
import 'package:bovinocultura_corte/clienteService/fazenda/FotoFazendaService.dart';
import 'package:bovinocultura_corte/dataModel/fazenda/Fazenda.dart';
import 'package:bovinocultura_corte/dataModel/fazenda/FotoFazenda.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../clienteService/admSistema/EstadoService.dart';
import '../../../clienteService/fazenda/FazendaService.dart';
import '../../../dataModel/Usuario.dart';
import '../../../dataModel/admSistema/Cidade.dart';
import '../../../dataModel/admSistema/Estado.dart';

import 'dart:convert';

import '../../componentes/Botoes.dart';
import '../../componentes/DateFormatter.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/DropDown.dart';
import '../../componentes/InputFormatter.dart';
import '../../componentes/Inputs.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/PaletaCores.dart';
import '../../componentes/SelecaoCapturaImagem.dart';
import '../../componentes/Textos.dart';
import '../../public/VisualizarImagem_PageView.dart';


class NewFazenda_PageView extends StatefulWidget {
  const NewFazenda_PageView({Key? key, required this.usuario, this.fazenda, this.fotoFazenda }) : super(key: key);

  final Usuario usuario;
  final Fazenda? fazenda;
  final String? fotoFazenda;

  @override
  _NewFazenda_PageView createState() => _NewFazenda_PageView();
}

//=========================================================================================//

class _NewFazenda_PageView extends State<NewFazenda_PageView> {

  final _nomeFazenda = TextEditingController();
  final _nrHectares = TextEditingController();
  final _nrTelefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String result = "";
  String result2 = "";

  List<Estado> listEstado = [];
  Estado estadoSelecionado = new Estado(txNome: "Selecione...", txSigla: " ");

  List<Cidade> listCidade = [];
  Cidade cidadeSelecionada = new Cidade(txNome: "Selecione...");

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadEstados();

    if(widget.fazenda != null) {
      _nomeFazenda.text = widget.fazenda!.txNome!;
      _nrHectares.text = "${widget.fazenda!.nrTotalHectares!}";
      if(widget.fazenda!.txTelefone != null) {
        _nrTelefone.text = widget.fazenda!.txTelefone!;
      }
      result = widget.fotoFazenda!;
    }
  }

//----------------------------------------------------------------------------//

  loadEstados() async {
    try {
      var list = await EstadoService.getInstance().getAllEstado();
      setState(() {
        estadoSelecionado = list[0];
        listEstado = list;
      });

      if(widget.fazenda == null) {
        loadCidades();
      }else{
        loadCidadeById();
      }

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

  loadCidades() async {
    try {
      listCidade = [];
      var list = await CidadeService.getInstance().getAllCidadeByEstadoId(estadoSelecionado.pkEstado!);
      setState(() {
        cidadeSelecionada = list[0];
        listCidade = list;
      });
      if(widget.fazenda != null) {
        for(int i = 0; i<listCidade.length; i++){
          if(listCidade[i].pkCidade == widget.fazenda?.fkCidade!){
            setState(() {
              cidadeSelecionada =  listCidade[i];
            });
            break;
          }
        }
      }
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadCidadeById() async {
    try {
      Cidade cid = await CidadeService.getInstance().getCidadeById(widget.fazenda!.fkCidade!);
      loadEnderecosCadastrados(cid.pkCidade!,cid.fkEstado!);
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

  loadEnderecosCadastrados(int cidNrId, int estNrId){
    for(int i = 0; i<listEstado.length; i++){
      if(listEstado[i].pkEstado == estNrId){
        setState(() {
          estadoSelecionado =  listEstado[i];
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
        appBar: Paineis.appBar(context: context, text: "Cadastar Fazenda"),

        body: Paineis.Pagina( context: context, isPlanoFundo_01: false,
          child:

            Form( key: _formKey,
              child: Container(
                  transformAlignment: Alignment.topCenter,
                  width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox( height: 10.0, ),

                      Texto.subtitulo(context: context, title: "Dados Da Fazenda.", color: Colors.black),

                      SizedBox( height: 10.0, ),


                      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        InkWell(
                          onTap: (){visualizarImagem(result);} ,
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

                                  if(widget.fazenda != null){
                                    editarFotoFazendaAction();
                                  }
                                },
                                    icon: Icon(Icons.add_photo_alternate_rounded, color: Palette.colorBeckground.shade900, size: 40,)),
                              ),

                              result.isNotEmpty?
                                widget.fazenda==null?
                                  IconButton( onPressed: (){
                                    setState(() {
                                      result = "";
                                    });
                                  },
                                    icon: Icon(Icons.delete_forever, color: Colors.red.shade600, size: 40,)
                                  ):SizedBox(height: 1)
                                :SizedBox(height: 1),

                            ],
                          )
                        ),

                      ],),

                      SizedBox( height: 10.0, ),


                      InputTipo.createInputText(textoConteudo: "Nome da Fazenda", variavelArmazenaDado: _nomeFazenda,
                          icon: Icons.account_balance, inputType: TextInputType.text, validar: true,
                      ),

                      InputTipo.createInputText(textoConteudo: "Nº Hectares", variavelArmazenaDado: _nrHectares,
                        icon: Icons.open_in_full, inputType: TextInputType.number, validar: true,
                      ),

                      InputTipo.createInputText(textoConteudo: "Telefone", variavelArmazenaDado: _nrTelefone,
                        icon: Icons.phone, inputType: TextInputType.number, validar: false,
                        inputFormatters: <TextInputFormatter>[ InputFormatter.numeroCelular, ],
                      ),

                      SizedBox( height: 5.0, ),

                      Row( children: [
                          Expanded(child:
                            DropDown.ByEstado(
                              items: listEstado,
                              value: estadoSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  estadoSelecionado = value!;
                                  loadCidades();
                                });
                              },
                            ),
                          ),

                          SizedBox( width: 12),

                          Expanded(child:
                            DropDown.ByCidade(
                              items: listCidade,
                              value: cidadeSelecionada,
                              onChanged: (value) {
                                setState(() {
                                  cidadeSelecionada = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox( height: 15, ),

                      BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                          onPressed: cadastrarFazenda
                      ),


                      widget.fazenda!=null?
                        Column(children: [
                          SizedBox( height: 10, ),

                          BotaoTipo.desfocado(text: "Inativar", size: MediaQuery.of(context).size.width * .675,
                              onPressed: cofirmarInativacao
                          ),
                        ]):SizedBox( height: 1, ),

                      SizedBox( height: 25, ),


                    ],
                  )
              )
            )
        ),
    );
  }

//=========================================================================================//

  Future<void> cadastrarFazenda() async {
    if (_formKey.currentState!.validate()){
      try{

        if(widget.fazenda != null){
          Fazenda fazenda = widget.fazenda!;
          fazenda.txNome = _nomeFazenda.text;
          fazenda.nrTotalHectares = double.parse(_nrHectares.text);
          fazenda.fkCidade = cidadeSelecionada.pkCidade;
          fazenda.fkUsuarioCadastrou = widget.usuario.pkUsuario!;
          fazenda.txTelefone = _nrTelefone.text;
          await FazendaService.getInstance().editFazenda(fazenda: fazenda);

        }else{
          Fazenda fazenda = new Fazenda(
            fkUsuarioCadastrou: widget.usuario.pkUsuario, txNome: _nomeFazenda.text,
            nrTotalHectares: double.parse(_nrHectares.text), fkCidade: cidadeSelecionada.pkCidade,
            txTelefone: _nrTelefone.text, ativa: true, dtCadastro: "${DateFormatter.formatTime( dateTime: DateTime.now() )}",
            btFotoFazenda: result
          );
          await FazendaService.getInstance().createFazenda(fazenda: fazenda);
        }

        Mensagens.DialogoInformativo_OK(context: context, title: 'Cadastro Concluido',
            content: "Fazenda ${widget.fazenda != null ? "Editada":"Cadastrada"} Com Sucesso!");
      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

  Future<void> editarFotoFazendaAction() async {
    try{
      FotoFazenda fto = new FotoFazenda(fkFazenda: widget.fazenda?.pkFazenda,
        btFotoFazenda: result, fkUsuarioCadastrou: widget.usuario.pkUsuario!);

      await FotoFazendaService.getInstance().createFotoFazenda(fotoFazenda: fto);

      Mensagens.DialogoInformativo_OK(context: context, title: 'Cadastro Concluido',
          content: "Foto da Fazenda Foi Alterada Com Sucesso!");
    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  cofirmarInativacao() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text("Deseja Inativar a Fazenda?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              inativarFazenda();
              Navigator.pop(context,"Sim");
            },
            child: const Text('Sim'),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context,"Não");
            },
            child: const Text('Não'),
          ),

        ],
      ),
    );
  }

//----------------------------------------------------------------------------//

  inativarFazenda() async {
    try{
      await FazendaService.getInstance().inativarFazenda(pkFazenda: widget.fazenda!.pkFazenda!,
      fkUsuario: widget.usuario.pkUsuario!);

      Mensagens.rodape(context: context, msg: "Fazenda Inativada com Sucesso!");
      Navigator.pop(context);

    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }

  }

//----------------------------------------------------------------------------//

  visualizarImagem(String img){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: img) ),
    );
  }

//=========================================================================================//

}

