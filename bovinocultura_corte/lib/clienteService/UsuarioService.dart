
import 'dart:convert';

import '../comunicacao/Requisicao.dart';
import '../comunicacao/Resposta.dart';
import '../comunicacao/Rotas.dart';
import '../dataModel/Usuario.dart';

class UsuarioService{

  // METODOS PUBLICOS - NAO REQUER AUTENTICACAO OU AUTORIZACAO
  // METODOS PRIVADOS - REQUER AUTENTICACAO E/OU AUTORIZACAO

  static UsuarioService? _instance = null;

  static UsuarioService getInstance() {
    if (_instance == null) {
      _instance = UsuarioService();
    }
    return _instance!;
  }

//=================================== METODOS PUBLICOS ===================================//

  Future<bool> createUsuario({ String? token, required Usuario usuario}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/create";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(usuario.toJson())) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> isEmailValido({ required String email}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/isEmailValido/${email}";
      Resposta pr = await Requisicao.get(urlComplete);

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> reiviarEmailValidacao({ required String email}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/reiviarEmailValidacao/${email}";
      Resposta pr = await Requisicao.get(urlComplete);

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<Usuario> autenticar({ String? token, required String login, required String senha}) async {
    try {
      Map<String, dynamic> data = new Map<String, dynamic>();
      data['username'] = login;
      data['password'] = senha;

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/autenticar";
      print(">>>>>>> ${urlComplete}");
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(data) );

      if (pr.value == null) {
        throw Exception(pr.message);
      }

      return Usuario.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> esqueciMinhaSenha({ required String email}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_REC_SENHA/esqueciMinhaSenha";
      Resposta pr = await Requisicao.post(urlComplete, email);

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<Usuario> buscarUsuario({ required String email}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/buscarUsuario";
      Resposta pr = await Requisicao.post(urlComplete, email);

      if (pr.message == null) {
        throw Exception(pr.message);
      }

      if (pr.value == null) {
        return new Usuario();
      }
      return Usuario.fromJson(pr.value);

    } catch (e) {
      throw e;
    }
  }

//=================================== METODOS PRIVADOS ===================================//

  Future<bool> editarDadosUsuario({ String? token, required List<String> listDados}) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/editarDadosUsuario";
      Resposta pr =  await Requisicao.post(urlComplete, jsonEncode(listDados)) ;

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//

  Future<bool> editarSenha({ String? token, required List<String> listDados }) async {
    try {

      String urlComplete = "${URL_BACKEND}/$BC_USUARIO/editarSenha";
      Resposta pr = await Requisicao.post(urlComplete, jsonEncode(listDados));

      if (pr.value == null) {
        throw Exception(pr.message);
      }
      return pr.value;

    } catch (e) {
      throw e;
    }
  }

//----------------------------------------------------------------------------//


}
