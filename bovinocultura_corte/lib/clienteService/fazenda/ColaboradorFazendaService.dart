
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/Usuario.dart';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/fazenda/ColaboradorFazenda.dart';
import '../../dataModel/fazenda/VWColaboradorFazenda.dart';

class ColaboradorFazendaService{

  static ColaboradorFazendaService? _instance = null;

  static ColaboradorFazendaService getInstance() {
    if (_instance == null) {
      _instance = ColaboradorFazendaService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createColaboradorFazenda({ String? token, required ColaboradorFazenda colaboradorFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_COLABORADOR_FAZENDA/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(colaboradorFazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> editColaboradorFazenda({ String? token, required ColaboradorFazenda colaboradorFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_COLABORADOR_FAZENDA/edit";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(colaboradorFazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<VWColaboradorFazenda>> getAllByFazenda({ String? token, required int pkFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_COLABORADOR_FAZENDA/getAllByFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(pkFazenda)) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }

      List<VWColaboradorFazenda> result = (pr.value as List).map((i) => VWColaboradorFazenda.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> inativarColaboradorFazenda({ String? token, required ColaboradorFazenda colaboradorFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_COLABORADOR_FAZENDA/inativarColaboradorFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(colaboradorFazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

}