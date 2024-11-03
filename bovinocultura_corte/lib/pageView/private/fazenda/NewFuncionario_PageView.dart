
import 'package:bovinocultura_corte/dataModel/fazenda/Fazenda.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../clienteService/UsuarioService.dart';
import '../../../clienteService/admSistema/NivelAcessoService.dart';
import '../../../clienteService/fazenda/ColaboradorFazendaService.dart';
import '../../../dataModel/Usuario.dart';
import '../../../dataModel/admSistema/NivelAcesso.dart';
import '../../../dataModel/fazenda/ColaboradorFazenda.dart';
import '../../../dataModel/fazenda/VWColaboradorFazenda.dart';
import '../../componentes/Botoes.dart';
import '../../componentes/Dimensinamento.dart';
import '../../componentes/DropDown.dart';
import '../../componentes/Inputs.dart';
import '../../componentes/Mensagens.dart';
import '../../componentes/Paineis.dart';
import '../../componentes/Textos.dart';

class NewFuncionario_PageView extends StatefulWidget {
  const NewFuncionario_PageView({Key? key, required this.usuario,
            required this.fazenda, this.colaboradorFazenda}) : super(key: key);

  final Usuario usuario;
  final Fazenda fazenda;
  final VWColaboradorFazenda? colaboradorFazenda;

  @override
  _NewFuncionario_PageView createState() => _NewFuncionario_PageView();
}

//=========================================================================================//

class _NewFuncionario_PageView extends State<NewFuncionario_PageView> {

  final _emailFuncionario = TextEditingController();

  late Usuario funcionario;

  final _formKey = GlobalKey<FormState>();

  List<NivelAcesso> listNivelAcesso = [];
  NivelAcesso? nivelAcessoSelecionado;

  bool carregou = false;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    loadNivelAcesso();
    if(widget.colaboradorFazenda != null) {
      _emailFuncionario.text = widget.colaboradorFazenda!.txLogin!;
      loadPessoa();
    }
  }

//----------------------------------------------------------------------------//

  loadNivelAcesso() async {
    try {
      var us = await NivelAcessoService.getInstance().getAllNivelAcesso();
      listNivelAcesso = us;

      if(widget.colaboradorFazenda != null){
        for(NivelAcesso ns in listNivelAcesso){
          if(ns.pkNivelAcesso == widget.colaboradorFazenda!.fkNivelAcesso!){
            nivelAcessoSelecionado = ns;
            break;
          }
        }
      }else {
        nivelAcessoSelecionado = listNivelAcesso[listNivelAcesso.length - 1];
      }
      setState(() {
        listNivelAcesso;
        nivelAcessoSelecionado;
      });
    } catch (e) {
      Mensagens.DialogoInformativo_OK(
          context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadPessoa() async {
    try{
      carregou = false;
      Usuario us = await UsuarioService.getInstance().buscarUsuario(email: _emailFuncionario.text);

      setState(() {
        funcionario = us;
        carregou = true;
      });

    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: Paineis.appBar(context: context, text: (widget.colaboradorFazenda == null? 'Novo Funcionario': "Editar Funcionario"), ),
        body: Paineis.Pagina_Statica(context: context,
          child: Container(
              width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),

              child: Column(
                children: [

                  SizedBox(height: 15),

                  widget.colaboradorFazenda == null?
                    Form( key: _formKey,
                      child: Row(children: [
                        SizedBox(width: 10,),
                        Expanded(child: InputTipo.createInputText(textoConteudo: "Email Funcionario", variavelArmazenaDado: _emailFuncionario,
                          inputType: TextInputType.text, validar: true, icon: Icons.text_fields,
                        )),
                        IconButton(icon: Icon(Icons.search),
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
                              loadPessoa();
                            }
                          },
                        )
                      ],),
                    ):SizedBox(height: 1,),

                  carregou?
                    funcionario.pkUsuario == null ?
                      Text("Usuario Não Encontrado!"):
                      Column(children: [
                        Texto.titulo(context: context,title: "Dados Usuario", fontSize: 16),
                        SizedBox( height: 10, ),

                        Card(child:
                          Padding(padding: EdgeInsets.all(10), child:
                            Column(children: [
                              Row(children: [
                                Expanded(child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Texto.titulo(context: context, title: "${funcionario.txNome}", fontSize: 14),
                                    Texto.textoPadrao( title: "${funcionario.txLogin}", fontSize: 14),
                                  ],)
                                )
                              ],),

                              widget.colaboradorFazenda != null?
                              Column(children: [
                                SizedBox(height: 8,),
                                Divider(height: 2, color: Colors.grey,),
                                SizedBox(height: 8,),

                                Texto.textoPadrao( title: "Cadastrado em: ${widget.colaboradorFazenda!.dtCadastro!}", fontSize: 12),
                                Texto.textoPadrao( title: "Nivel Aceso: ${widget.colaboradorFazenda!.nivAcessNome}", fontSize: 12)
                              ]):SizedBox(height: 1,),

                            ],)
                          )
                        ),

                        SizedBox( height: 10, ),

                        Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texto.titulo(context: context,title: "Permissão", fontSize: 14),
                              SizedBox(height: 5,),
                              DropDown.ByNivelAcesso(
                                items: listNivelAcesso,
                                value: nivelAcessoSelecionado,
                                onChanged: (value) {
                                  setState(() {
                                    nivelAcessoSelecionado = value!;
                                  });
                                },
                              ),
                            ],),
                        ),

                        BotaoTipo.padrao(text: "Salvar", size: MediaQuery.of(context).size.width * .675,
                            onPressed: widget.colaboradorFazenda != null ? editarAction : cadastrarAction
                        ),

                        widget.colaboradorFazenda != null ?
                          Column(children: [
                            SizedBox( height: 10, ),

                            BotaoTipo.desfocado(text: "Inativar", size: MediaQuery.of(context).size.width * .675,
                                onPressed: inativarAction
                            ),
                          ]):SizedBox( height: 1, ),

                      ],)
                    :Text("...")


                ],
              )
          ),

        )
    );
  }

//=========================================================================================//

  cadastrarAction() async {
    if (_formKey.currentState!.validate()) {
      try {
        ColaboradorFazenda colaboradorFazenda = new ColaboradorFazenda(
          fkFazenda: widget.fazenda.pkFazenda,
          fkUsuario: funcionario.pkUsuario,
          fkUsuarioCadastrou: widget.usuario.pkUsuario,
          ativa: true,
          fkNivelAcesso: nivelAcessoSelecionado!.pkNivelAcesso!,
        );

        await ColaboradorFazendaService.getInstance().createColaboradorFazenda(colaboradorFazenda: colaboradorFazenda);

        Mensagens.rodape(context: context, msg: "Funcionario Cadastrado com Sucesso");
        Navigator.pop(context);

      }catch(e){
        Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
            content: e.toString());
      }
    }
  }

//=========================================================================================//

  editarAction() async {
    try {
      ColaboradorFazenda colaboradorFazenda = new ColaboradorFazenda(
          pkColaboradorFazenda: widget.colaboradorFazenda!.pkColaboradorFazenda,
          fkUsuario: widget.colaboradorFazenda!.fkUsuario,
          fkFazenda: widget.colaboradorFazenda!.fkFazenda,
          dtCadastro: widget.colaboradorFazenda!.dtCadastro,
          fkUsuarioCadastrou: widget.colaboradorFazenda!.fkUsuarioCadastrou,
          ativa: widget.colaboradorFazenda!.ativa,
          dtRemocao: widget.colaboradorFazenda!.dtRemocao,
          fkNivelAcesso: nivelAcessoSelecionado!.pkNivelAcesso!,
          txMotivoSaida: widget.colaboradorFazenda!.txMotivoSaida
      );

      await ColaboradorFazendaService.getInstance().editColaboradorFazenda(colaboradorFazenda: colaboradorFazenda);

      Mensagens.rodape(context: context, msg: "Funcionario Editado com Sucesso");
      Navigator.pop(context);

    }catch(e){
      Mensagens.DialogoInformativo_OK(context: context, title: 'Ops...',
          content: e.toString());
    }
  }

//============================================================================//

  inativarAction(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ATENÇÃO'),
        content: const Text("Inativar do Funcionario?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              inativarFuncionario();
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

  inativarFuncionario() async{
    try{
      ColaboradorFazenda colaboradorFazenda = new ColaboradorFazenda(
          fkFazenda: widget.colaboradorFazenda!.fkFazenda!, fkUsuario: widget.colaboradorFazenda!.fkUsuario!);

      await ColaboradorFazendaService.getInstance().inativarColaboradorFazenda(colaboradorFazenda: colaboradorFazenda);
      Mensagens.rodape(context: context, msg: "Funcionario Inativado Com Sucesso!");
      Navigator.pop(context);
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//============================================================================//

}

