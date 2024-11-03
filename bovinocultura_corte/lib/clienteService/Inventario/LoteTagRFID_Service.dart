
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/inventario/LoteTagRFID.dart';
import 'package:bovinocultura_corte/dataModel/inventario/LoteVacina.dart';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';

class LoteTagRFID_Service{

  static LoteTagRFID_Service? _instance = null;

  static LoteTagRFID_Service getInstance() {
    if (_instance == null) {
      _instance = LoteTagRFID_Service();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createLoteTagRFID({ String? token, required LoteTagRFID loteVacina}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_LOTE_TAG_RFID/create";
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

  Future<List<LoteTagRFID>> getAllLoteTagRFIDByFazenda( {required int fkFazenda} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_LOTE_TAG_RFID/getAllLoteTagRFIDByFazenda/${fkFazenda}";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<LoteTagRFID> result = (pr.value as List).map((i) => LoteTagRFID.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

}