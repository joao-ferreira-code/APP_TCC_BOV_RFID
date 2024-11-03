
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/inventario/TagRFID.dart';

class TagRFID_Service{

  static TagRFID_Service? _instance = null;

  static TagRFID_Service getInstance() {
    if (_instance == null) {
      _instance = TagRFID_Service();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createTagRFID({ String? token, required TagRFID tagRFID}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_TAG_RFID/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(tagRFID.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<TagRFID>> getAllByFazendaAndLote( {required int fkFazenda, required int fkLote} ) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_TAG_RFID/getAllByFazendaAndLote";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<TagRFID> result = (pr.value as List).map((i) => TagRFID.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> inativarFazenda({ String? token, required int pkTAG}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_TAG_RFID/inativar";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(pkTAG)) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return true;

    } catch (e) {
      throw e;
    }
  }

}