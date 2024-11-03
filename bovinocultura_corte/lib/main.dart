
import 'package:bovinocultura_corte/pageView/Login_PageView.dart';
import 'package:bovinocultura_corte/pageView/componentes/PaletaCores.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Bovinocultura Corte',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Palette.primary,
        canvasColor: Colors.blue.shade50
      ),

      home: const Login_PageView(),


    );
  }
}


/*
showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return pagina();
        });
*/