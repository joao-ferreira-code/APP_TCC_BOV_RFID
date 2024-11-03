
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/inventario/LoteVacina.dart';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';

class LoteVacinaService{

  static LoteVacinaService? _instance = null;

  static LoteVacinaService getInstance() {
    if (_instance == null) {
      _instance = LoteVacinaService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createVacina({ String? token, required LoteVacina loteVacina}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_LOTE_VACINA/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(loteVacina.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<LoteVacina>> getAllLoteObrigatorioByFazenda( {required int fkFazenda} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_LOTE_VACINA/getAllLoteObrigatorioByFazenda/${fkFazenda}";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<LoteVacina> result = (pr.value as List).map((i) => LoteVacina.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<LoteVacina>> getAllLoteRotineiraByFazenda( {required int fkFazenda} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_LOTE_VACINA/getAllLoteRotineiraByFazenda/${fkFazenda}";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<LoteVacina> result = (pr.value as List).map((i) => LoteVacina.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<LoteVacina>> getAllLoteAtivoByFazenda( {required int fkFazenda} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_LOTE_VACINA/getAllLoteAtivoByFazenda/${fkFazenda}";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<LoteVacina> result = (pr.value as List).map((i) => LoteVacina.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

}