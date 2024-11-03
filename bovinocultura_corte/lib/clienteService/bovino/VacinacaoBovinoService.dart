
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/animal/VacinacaoBovino.dart';

class VacinacaoBovinoService{

  static VacinacaoBovinoService? _instance = null;

  static VacinacaoBovinoService getInstance() {
    if (_instance == null) {
      _instance = VacinacaoBovinoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createVacinacaoBovino({ String? token, required VacinacaoBovino vacinacaoBovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_VACINACAO_BOVINO/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(vacinacaoBovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<VacinacaoBovino>> getAllByPkBovino({ String? token, required int pkBovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_VACINACAO_BOVINO/create/${pkBovino}";
      Resposta pr = await Requisicao.get(urlComplete);

      List<VacinacaoBovino> result = (pr.value as List).map((i) => VacinacaoBovino.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<VacinacaoBovino>> getAllByPkBovinoAndPkFazenda({ String? token,
                        required int pkBovino, required int pkFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_VACINACAO_BOVINO/getAllVacinacaoByBovinoAndFazeda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([pkBovino,pkFazenda])) ;

      List<VacinacaoBovino> result = (pr.value as List).map((i) => VacinacaoBovino.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<dynamic>> resunoBY({ String? token, required int fkFazenda, required int intervalo}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_VACINACAO_BOVINO/getResumoBovinoFazendaByIntervalo";
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