
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/animal/DescarteBovino.dart';
import '../../dataModel/animal/VWDadosDescarte.dart';

class DescarteBovinoService{

  static DescarteBovinoService? _instance = null;

  static DescarteBovinoService getInstance() {
    if (_instance == null) {
      _instance = DescarteBovinoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createDescarteBovino({ String? token, required DescarteBovino descarteBovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_DESCARTE_BOVINO/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(descarteBovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<VWDadosDescarte>> getAllByPkFazenda({ String? token, required int fkFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_DESCARTE_BOVINO/getAllByPkFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(fkFazenda)) ;

      List<VWDadosDescarte> result = (pr.value as List).map((i) => VWDadosDescarte.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<dynamic>> resunoBY({ String? token, required int fkFazenda, required int intervalo}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_DESCARTE_BOVINO/getResumoBovinoFazendaByIntervalo";
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