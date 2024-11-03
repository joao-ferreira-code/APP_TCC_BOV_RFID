
import 'dart:convert';

import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/fazenda/FotoFazenda.dart';

class FotoFazendaService{

  // METODOS PUBLICOS - NAO REQUER AUTENTICACAO OU AUTORIZACAO
  // METODOS PRIVADOS - REQUER AUTENTICACAO E/OU AUTORIZACAO

  static FotoFazendaService? _instance = null;

  static FotoFazendaService getInstance() {
    if (_instance == null) {
      _instance = FotoFazendaService();
    }
    return _instance!;
  }

//=================================== METODOS PRIVADOS ===================================//

  Future<bool> createFotoFazenda({ String? token, required FotoFazenda fotoFazenda}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FOTO_FAZENDA/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(fotoFazenda.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<FotoFazenda> fotoAtivaByFazenda({ String? token, required int pkFotoFazenda }) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_FOTO_FAZENDA/getFotoPerfilFazenda";
      Resposta pr = await Requisicao.post(urlComplete, jsonEncode(pkFotoFazenda),isImage: true);

      if (pr.value == null ) {
        throw Exception(pr.message);
      }
      return FotoFazenda.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}
