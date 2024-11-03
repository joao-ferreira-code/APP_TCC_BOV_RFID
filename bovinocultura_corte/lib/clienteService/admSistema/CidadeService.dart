
import '../../comunicacao/Requisicao.dart';
import '../../comunicacao/Resposta.dart';
import '../../comunicacao/Rotas.dart';
import '../../dataModel/admSistema/Cidade.dart';

class CidadeService {

  static CidadeService? _instance = null;

  static CidadeService getInstance() {
    if (_instance == null) {
      _instance = CidadeService();
    }
    return _instance!;
  }

//----------------------------------------------------------------------------//

  Future<List<Cidade>> getAllCidade() async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_CIDADE/getAllCidade";

      Resposta pr = await Requisicao.get(urlComplete);

      List<Cidade> result = (pr.value as List).map((i) => Cidade.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<List<Cidade>> getAllCidadeByEstadoId(int fkEstado) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_CIDADE/getAllCidadeByEstadoId/${fkEstado}";

      Resposta pr = await Requisicao.get(urlComplete);

      List<Cidade> result = (pr.value as List).map((i) => Cidade.fromJson(i)).toList();
      return result;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<Cidade> getCidadeById(int pkCidade) async {
    try {
      String urlComplete = "${URL_BACKEND}/$BC_CIDADE/$pkCidade";

      Resposta pr = await Requisicao.get(urlComplete);

      return Cidade.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//=========================== METODOS PARA SUPORTE ===========================//

  Cidade buscarCidadeById(List<Cidade> list, int id){

    for(Cidade cid in list){
      if(cid.pkCidade == id){
        print(' >>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n\n\n');
        return cid;
      }
    }
    return new Cidade();
  }

//============================================================================//

}