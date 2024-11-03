
import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/admSistema/NivelAcesso.dart';

class NivelAcessoService{

  static NivelAcessoService? _instance = null;

  static NivelAcessoService getInstance() {
    if (_instance == null) {
      _instance = NivelAcessoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<List<NivelAcesso>> getAllNivelAcesso() async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_NIVEL_ACESSO/getAllNivelAcesso";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<NivelAcesso> result = (pr.value as List).map((i) => NivelAcesso.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

}