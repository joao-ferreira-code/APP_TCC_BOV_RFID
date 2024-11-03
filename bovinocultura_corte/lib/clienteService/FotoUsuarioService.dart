
import 'dart:convert';

import '../comunicacao/Requisicao.dart';
import '../comunicacao/Resposta.dart';
import '../comunicacao/Rotas.dart';
import '../dataModel/FotoUsuario.dart';
import '../dataModel/Usuario.dart';

class FotoUsuarioService{

  // METODOS PUBLICOS - NAO REQUER AUTENTICACAO OU AUTORIZACAO
  // METODOS PRIVADOS - REQUER AUTENTICACAO E/OU AUTORIZACAO

  static FotoUsuarioService? _instance = null;

  static FotoUsuarioService getInstance() {
    if (_instance == null) {
      _instance = FotoUsuarioService();
    }
    return _instance!;
  }

//=================================== METODOS PRIVADOS ===================================//

  Future<bool> createFotoUsuario({ String? token, required FotoUsuario fotoUsuario}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FOTO_PERFIL/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(fotoUsuario.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<FotoUsuario> fotoAtivaByUsuario({ String? token, required int fkUsuario }) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FOTO_PERFIL/getFotoAtivaByUsuario";
      Resposta pr = await Requisicao.post(urlComplete, jsonEncode(fkUsuario),isImage: true);

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return FotoUsuario.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}
