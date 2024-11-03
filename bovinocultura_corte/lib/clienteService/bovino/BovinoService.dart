
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/animal/Bovino.dart';

class BovinoService{

  static BovinoService? _instance = null;

  static BovinoService getInstance() {
    if (_instance == null) {
      _instance = BovinoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<bool> createBovinoNascimento({ String? token, required Bovino bovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_BOVINO/create";
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

  Future<bool> createBovinoCompra({ String? token, required Bovino bovino}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_BOVINO/create";
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

  Future<Bovino> getAnimaByCodigo(int codAnimal) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_BOVINO/$codAnimal";

      Resposta pr = await Requisicao.get(urlComplete) ;
      return Bovino.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}