
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/animal/PesagemBovino.dart';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/animal/Bovino.dart';

class PesagemBovinoService{

  static PesagemBovinoService? _instance = null;

  static PesagemBovinoService getInstance() {
    if (_instance == null) {
      _instance = PesagemBovinoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createPesagemBovino({ String? token, required PesagemBovino pesagemBovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_PESAGEM_BOVINO/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(pesagemBovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<PesagemBovino>> getAllByPkBovino({ String? token, required int pkBovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_PESAGEM_BOVINO/create/${pkBovino}";
      Resposta pr = await Requisicao.get(urlComplete);

      List<PesagemBovino> result = (pr.value as List).map((i) => PesagemBovino.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<PesagemBovino>> getAllByPkBovinoAndPkFazenda({ String? token,
                        required int pkBovino, required int pkFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_PESAGEM_BOVINO/getAllPesagemByBovinoAndFazeda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([pkBovino,pkFazenda])) ;

      List<PesagemBovino> result = (pr.value as List).map((i) => PesagemBovino.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<dynamic>> resunoBY({ String? token, required int fkFazenda, required int intervalo}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_PESAGEM_BOVINO/getResumoBovinoFazendaByIntervalo";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([fkFazenda,intervalo])) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}