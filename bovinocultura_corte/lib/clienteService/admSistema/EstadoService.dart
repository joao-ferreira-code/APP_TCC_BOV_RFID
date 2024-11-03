
import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/admSistema/Estado.dart';

class EstadoService {

  static EstadoService? _instance = null;

  static EstadoService getInstance() {
    if (_instance == null) {
      _instance = EstadoService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<List<Estado>> getAllEstado() async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_ESTADO/getAllEstado";

      Resposta pr = await Requisicao.get(urlComplete);

      List<Estado> result = (pr.value as List).map((i) => Estado.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<Estado> getEstadoById(int pkEstado) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_ESTADO/$pkEstado";

      Resposta pr = await Requisicao.get(urlComplete);
      return Estado.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//=========================== METODOS PARA SUPORTE ===========================//

  Estado buscarEstadoById(List<Estado> list, int id){

    for(Estado est in list){
      if(est.pkEstado == id){
        return est;
      }
    }
    return new Estado();
  }

//============================================================================//

}