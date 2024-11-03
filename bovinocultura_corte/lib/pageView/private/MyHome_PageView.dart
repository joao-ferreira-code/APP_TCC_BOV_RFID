
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/Usuario.dart';
import 'package:bovinocultura_corte/pageView/private/perfil/PerfilUsuaio_PageView.dart';
import 'package:flutter/material.dart';

import '../../_sessaoDeDados/DadosAcesso.dart';
import '../../clienteService/FotoUsuarioService.dart';
import '../../clienteService/fazenda/FazendaService.dart';
import '../../clienteService/fazenda/FotoFazendaService.dart';
import '../../dataModel/fazenda/Fazenda.dart';
import '../../dataModel/fazenda/FotoFazenda.dart';
import '../componentes/Botoes.dart';
import '../componentes/Card.dart';
import '../componentes/Dimensinamento.dart';
import '../componentes/Mensagens.dart';
import '../componentes/Paineis.dart';
import '../componentes/PaletaCores.dart';
import '../componentes/Textos.dart';
import '../public/Sobre_PageView.dart';
import '../public/SupportTecnico_PageView.dart';
import '../public/VisualizarImagem_PageView.dart';
import 'animal/Animal_Main_PageView.dart';
import 'animal/pesagem/Pesagem_Main_PageView.dart';
import 'animal/vacinacao/Vacinacao_Main_PageView.dart';
import 'config/Configuracao_Main_PageView.dart';
import 'fazenda/Fazenda_Main_PageView.dart';
import 'fazenda/NewFazenda_PageView.dart';
import 'inventario/Inventario_Main_PageView.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.usuario }) : super(key: key);

  final Usuario usuario;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//============================================================================//

class _MyHomePageState extends State<MyHomePage> {

  bool excessao = false;
  bool isCardExtendido = false;

  List<Fazenda> listFazenda = [];
  Fazenda fazendaSelecionada = new Fazenda();
  String fotoFazenda = "";

  String fotoUsuario = "";

//----------------------------------------------------------------------------//

  @override
  void initState() {
    super.initState();
    loadFazenda();
    loadFotoUsuario();
  }

//----------------------------------------------------------------------------//

  loadFazenda() async {
    try{
      listFazenda = [];
      List<Fazenda> list = await FazendaService.getInstance().
          getAllFazendasAtivaByColaborador(usuNrId: widget.usuario.pkUsuario!,) as List<Fazenda>;

      setState(() {
        listFazenda = list;
        if(listFazenda.isNotEmpty){
          fazendaSelecionada = listFazenda[0];
        }
      });
      loadFotoFazenda();
    } catch (e) {
      Mensagens.DialogoInformativo_OK( context: context, title: "Ops!", content: e.toString());
    }
  }

//----------------------------------------------------------------------------//

  loadFotoFazenda() async {
    try{
      FotoFazenda fto = await FotoFazendaService.getInstance().fotoAtivaByFazenda(pkFotoFazenda: fazendaSelecionada.pkFazenda!);
      setState(() {
        fotoFazenda = fto.btFotoFazenda!;
      });
    } catch (e) {
      if(e != null) {
        setState(() {
          fotoFazenda = "";
        });
      }else {
        Mensagens.DialogoInformativo_OK(
            context: context, title: "Ops!", content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

  loadFotoUsuario() async {
    try{
      var fto = await FotoUsuarioService.getInstance().fotoAtivaByUsuario(fkUsuario: widget.usuario.pkUsuario!);
      if(fto != null) {
        setState(() {
          fotoUsuario = fto.btFotoUsuario!;
        });
      }
    } catch (e) {
      if(e != null){
        setState(() {
          fotoUsuario = "";
        });
      }else {
        Mensagens.DialogoInformativo_OK(
            context: context, title: "Ops!", content: e.toString());
      }
    }
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( foregroundColor: Palette.main.shade300, backgroundColor: Palette.main.shade200,
        actions: [
          Stack(children: [
              IconButton(onPressed: (){Mensagens.rodape(context: context, msg: "Em Desenvolvimento");}, icon: Icon(Icons.notifications, size: 32,)),
              Padding(padding: EdgeInsets.only(top: 12, left: 25),
                child: CircleAvatar(backgroundColor: Colors.red,
                    radius: 8,
                    child: Text("+99", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white) ),
                )
              ),
            ],
          ),
        SizedBox(width: 10,)

        ],
      ),

      body: Paineis.Pagina_Statica(context: context,
        child: Container(
          width: Dimensionamento.tamanhoComponentes(MediaQuery.of(context).size.width),
          child:

            listFazenda.isEmpty?
              contaInicial() : minhasFazendas(),

        )
      ),

      floatingActionButton: FloatingActionButton(backgroundColor: Palette.primary.shade300,
        onPressed: (){
          Mensagens.rodape(context: context, msg: "Em Desenvolvimento");
        },
        tooltip: 'Ajuda',
        child: const Icon(Icons.functions, color: Palette.primary),
      ),

//==========================================================================================//

        drawer: Drawer(backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Palette.main.shade200,
                ),
                /*decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("imagens/lateralPeq2.png"),
                    fit: BoxFit.cover,
                  ),),*/
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center + Alignment(0, -1.1),
                      child: InkWell(
                        onTap: visualizarImagemUser ,
                        child: fotoUsuario.isEmpty ?
                          CircleAvatar(radius: 52,
                            backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                          ) :
                          ClipOval(child: Image.memory( base64Decode(fotoUsuario), height: 100, width: 100,) ),
                      )
                    ),
                    Align(
                      alignment: Alignment.bottomCenter + Alignment(0, -.35),
                      child: Text( "${widget.usuario.txNome}", textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text( "${widget.usuario.txLogin}",
                        style: TextStyle(
                          color: Palette.main, fontSize: 16.0,
                        ),
                      ),
                    ),

                    SizedBox( height: 25,),
                  ],
                ),
              ),

              BotaoTipo.fullLinha(text: "Inicio", icon: Icons.home, iconColor: Palette.main.shade900,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              BotaoTipo.fullLinha(text: "Perfil", icon: Icons.account_circle, iconColor: Palette.main.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => PerfilUsuaio_PageView(usuario: widget.usuario, fotoUsuarioParametro: fotoUsuario,)),
                  ).then((value) => loadFotoUsuario());
                },
              ),

              BotaoTipo.fullLinha(text: "Configurações", icon: Icons.settings, iconColor: Palette.main.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Configuracao_Main_PageView(usuario: widget.usuario,)),
                  );
                },
              ),

              BotaoTipo.fullLinha(text: "Sobre", icon: Icons.info_outline_rounded, iconColor: Palette.main.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Sobre_PageView()),
                  );
                },
              ),

              BotaoTipo.fullLinha(text: "Suporte", icon: Icons.support_agent, iconColor: Palette.main.shade900,
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => SupportTecnico_PageView()),
                  );
                },
              ),

              BotaoTipo.fullLinha(text: "Sair", icon: Icons.exit_to_app, iconColor: Palette.main.shade900,
                onPressed: () {
                  sairDoApp();
                },
              ),

            ],
          ),
        )
    );
  }

//=======================================================================================================//

  Widget contaInicial(){
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25,),

          Texto.titulo(context: context, title: "Seja bem vindo(a)!",color: Palette.primary.shade400),

          SizedBox(height: 25,),


          Icon(Icons.account_balance_rounded, color: Palette.primary.shade300, size: 75),
          IconButton(icon: Icon(Icons.add_circle_outline, color: Palette.primary.shade500,), iconSize: 45,
              onPressed: (){
                Navigator.push( context,
                  MaterialPageRoute(
                      builder: (context) => NewFazenda_PageView(usuario: widget.usuario,)),
                ).then((value) => loadFazenda());
              },
              tooltip: "Adicionar Fazenda",
            ),


        ]
    );
  }

  Widget minhasFazendas(){
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5,),

        Card( color: Palette.main.shade100,
          child: Padding(padding: EdgeInsets.all(8), child:

            Row( children: [
                InkWell(
                  onTap: visualizarImagemFazenda,
                  child: fotoFazenda.isEmpty ?
                  CircleAvatar(radius: 37,
                    backgroundImage:  AssetImage("imagens/undraw_Taken_re_yn20_6.png"),
                  ) :
                  ClipOval(child: Image.memory( base64Decode(fotoFazenda), height: 70, width: 70,) ),
                ),

                SizedBox(width: 8,),

                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Texto.referenciaConteudo(referencia: "Nome", conteudo: fazendaSelecionada.txNome!),
                        Texto.referenciaConteudo(referencia: "Cod.", conteudo: fazendaSelecionada.txCodigoPublico!),
                        SizedBox(height: 5,),
                        Texto.referenciaConteudo(referencia: "Telefone", conteudo: "${fazendaSelecionada.txTelefone == null ? "Não Informado!" : fazendaSelecionada.txTelefone!}"),

                      ],)
                ),

                IconButton(iconSize: 25,
                  onPressed: (){
                    if(isCardExtendido) {
                      if(fazendaSelecionada.ativa! ) {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => Fazenda_Main_PageView(
                              usuario: widget.usuario, fazenda: fazendaSelecionada, fotoFazenda: fotoFazenda,)),
                        ).then((value) => loadFazenda());
                      }
                    }
                    setState(() {
                      isCardExtendido = !isCardExtendido;
                    });
                  },
                  icon: Icon(!isCardExtendido?Icons.keyboard_arrow_down_sharp:Icons.arrow_right, color: Palette.main,)),

              ]
            ),
          ),
        ),

        isCardExtendido?
          Expanded(child:
            Padding(padding: EdgeInsets.only(bottom: 25),child:
            Card(color: Colors.grey.shade100,
              child: Column(
                children: [
                  IconButton(icon: Icon(Icons.add, color: Palette.colorBeckground,),
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => NewFazenda_PageView(usuario: widget.usuario,)),
                      ).then((value) => loadFazenda());
                      setState(() {
                        isCardExtendido = !isCardExtendido;
                      });
                    },
                  ),
                  Expanded(child: listFazendas()),

                  IconButton(
                      onPressed: (){
                        setState(() {
                          isCardExtendido = !isCardExtendido;
                        });
                      },
                      icon: Icon(Icons.arrow_drop_up)
                  ),

                ],
              )
            ))
          )
            :
          Expanded(child:
            fazendaSelecionada.ativa! ?
              Column(
                children: [
                  SizedBox(height: 10,),

                  Cards.click(text: "Fazenda", icon: Icons.account_balance,
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => Fazenda_Main_PageView(usuario: widget.usuario,
                              fazenda: fazendaSelecionada, fotoFazenda: fotoFazenda,)),
                      ).then((value) => loadFazenda);
                    },
                  ),

                  Cards.click(text: "Animal", icon: Icons.pets,
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => Animal_Main_PageView(usuario: widget.usuario, fazenda: fazendaSelecionada)),
                      );
                    },
                  ),

                  Cards.click(text: "Pesagem", icon: Icons.balance,
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => Pesagem_Main_PageView(usuario: widget.usuario, fazenda: fazendaSelecionada,)),
                      );
                    },
                  ),

                  Cards.click(text: "Vacinação", icon: Icons.medication_sharp,
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => Vacinacao_Main_PageView(usuario: widget.usuario, fazenda: fazendaSelecionada,)),
                      );
                    },
                  ),

                  Cards.click(text: "Inventário", icon: Icons.inventory,
                    onPressed: (){
                      Navigator.push( context,
                        MaterialPageRoute(
                            builder: (context) => Inventario_Main_PageView(usuario: widget.usuario,fazenda: fazendaSelecionada,)),
                      );
                    },
                  ),

                ],
              )
            :
              Text("Fazenda Inativada."),
          )

      ]
    );
  }

//=======================================================================================================//

  Widget listFazendas() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listFazenda.length,
      itemBuilder: (context, index) {

        return Card(color: listFazenda[index].ativa! ? Colors.white:Colors.grey.shade200,
            child:
          InkWell(
            //onTap: () => removerAlunoTurmaAction(user),
            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5), child:

              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Texto.referenciaConteudo(referencia: "Nome", conteudo: listFazenda[index].txNome!),
                  Texto.referenciaConteudo(referencia: "Cod.", conteudo: listFazenda[index].txCodigoPublico!),
                  SizedBox(height: 3,),

                  Texto.referenciaConteudo(referencia: "Telefone", conteudo: "${listFazenda[index].txTelefone == null ? "Não Informado!" : listFazenda[index].txTelefone!}"),
                ]),

                Expanded(child: Text("")),

                listFazenda[index].ativa! ?
                  SizedBox(height: 1,):
                  IconButton(tooltip: "Inativada!",
                      onPressed: (){},
                      icon: Icon(Icons.archive_outlined, color: Colors.brown,)),

                IconButton(
                    onPressed: (){
                      setState(() {
                        fazendaSelecionada = listFazenda[index];
                        loadFotoFazenda();
                        setState(() {
                          isCardExtendido = !isCardExtendido;
                        });
                      });
                    },
                    icon: Icon(fazendaSelecionada == listFazenda[index]?  Icons.grade_rounded:Icons.grade_outlined)),

              ],),

            )
          )
        );

      }
    );
  }

//=======================================================================================================//

   sairDoApp(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Sair do Sistema!'),
        content: const Text('Deseja realmente sair do Sistema?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom( primary: Palette.primary.shade400 ),
            onPressed: () async {
              await DadosAcesso.removerUsuario();
              Navigator.pop(context,"Sim");
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Sim'),
          ),

          TextButton(
            style: TextButton.styleFrom( primary: Palette.primary.shade500 ),
            onPressed: () {
              Navigator.pop(context,"Não");
            },
            child: const Text('Não'),
          ),

        ],
      ),
    );
  }

//============================================================================//

  visualizarImagemUser(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: fotoUsuario,)),
    );
  }

//----------------------------------------------------------------------------//

  visualizarImagemFazenda(){
    Navigator.push( context,
      MaterialPageRoute(
          builder: (context) => VisualizarImagem_PageView(fotoUsuario: fotoFazenda,)),
    );
  }

//=======================================================================================================//

}