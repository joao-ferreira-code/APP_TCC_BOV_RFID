
import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/admSistema/Raca.dart';

class RacaService{

  static RacaService? _instance = null;

  static RacaService getInstance() {
    if (_instance == null) {
      _instance = RacaService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<List<Raca>> getAllRaca() async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_RACA/getAllRaca";

      Resposta pr = await Requisicao.get(urlComplete) ;

      List<Raca> result = (pr.value as List).map((i) => Raca.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<Raca> getRacaById(int pkRaca) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_RACA/$pkRaca";

      Resposta pr = await Requisicao.get(urlComplete) ;
      return Raca.fromJson(pr.value);

    } catch (e) {
      throw e;
    } finally {}
  }

//----------------------------------------------------------------------------//

}