
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/animal/BovinoFazenda.dart';
import '../../dataModel/animal/BovinoFazenda_Transferencia.dart';
import '../../dataModel/animal/VWBovinoFazenda.dart';

class BovinoFazendaService{

  static BovinoFazendaService? _instance = null;

  static BovinoFazendaService getInstance() {
    if (_instance == null) {
      _instance = BovinoFazendaService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createBovinoNascimento({ String? token, required BovinoFazenda_Cad bovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/createByNascimeto";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(bovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> createByCompraCadAnimal({ String? token, required BovinoFazenda_Cad bovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/createByCompraCadAnimal";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(bovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> createByCompraByTransferencia({ String? token, required BovinoFazenda_Transferencia bovino}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/createByCompraByTransferencia";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(bovino.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<VWBovinoFazenda>> buscarBovinoFullDados({ String? token, required int fkFazenda,
                                  required int pkBovino, required int isViaRFID}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/getDadosCompletosByFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([fkFazenda,pkBovino, isViaRFID])) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }

      List<VWBovinoFazenda> result = (pr.value as List).map((i) => VWBovinoFazenda.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<VWBovinoFazenda> buscarBovinoSimpleDados({ String? token, required int fkFazenda,
    required int pkBovino, required int isViaRFID}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/getDadosSimplificadosByFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([fkFazenda,pkBovino, isViaRFID])) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }

      VWBovinoFazenda result = VWBovinoFazenda.fromJson(pr.value);
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<dynamic>> resunoBY({ String? token, required int fkFazenda, required int intervalo}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/getResumoBovinoFazendaByIntervalo";
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

  Future<List<VWBovinoFazenda>> getAllBovinoByFazenda({ String? token, required int fkFazenda}) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO_FAZENDA/getAllBovinoByFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(fkFazenda)) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }

      List<VWBovinoFazenda> result = (pr.value as List).map((i) => VWBovinoFazenda.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}