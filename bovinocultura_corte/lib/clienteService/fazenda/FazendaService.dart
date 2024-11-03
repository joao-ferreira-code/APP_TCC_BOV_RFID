
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/fazenda/Fazenda.dart';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/fazenda/VWDadosFazenda.dart';

class FazendaService{

  static FazendaService? _instance = null;

  static FazendaService getInstance() {
    if (_instance == null) {
      _instance = FazendaService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createFazenda({ String? token, required Fazenda fazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FAZENDA/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(fazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> editFazenda({ String? token, required Fazenda fazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FAZENDA/edit";
      Resposta pr = await Requisicao.post(urlComplete, jsonEncode(fazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<Fazenda>> getAllFazendasAtivaByColaborador( {required int usuNrId} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_FAZENDA/getAllFazendasAtivaByColaborador";

      Resposta pr = await Requisicao.post(urlComplete, jsonEncode(usuNrId) ) ;

      List<Fazenda> result = (pr.value as List).map((i) => Fazenda.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> inativarFazenda({ String? token, required int pkFazenda, required int fkUsuario}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FAZENDA/inativarFazenda";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode([pkFazenda,fkUsuario])) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//
  
  Future<VWDadosFazenda> buscarFazendaByCodigoPublico({ String? token, required String codigoPublico }) async {

    try {
      String urlComplete = "${URL_BACKEND}/$BC_FAZENDA/buscarFazendaByCodigoPublico";
      Resposta pr =  await Requisicao.post(urlComplete, codigoPublico) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return VWDadosFazenda.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

}