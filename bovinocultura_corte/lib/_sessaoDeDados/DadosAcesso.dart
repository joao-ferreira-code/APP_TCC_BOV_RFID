
import 'dart:convert';

import 'package:bovinocultura_corte/dataModel/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosAcesso {

  static String _LOGIN="@MyLog";
  static String _USER="@MyUser";

//============================================================================//
//                                   CREATE

  static salvarLogin(String login) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_LOGIN, login);
  }

//----------------------------------------------------------------------------//

  static salvarUsuario(Usuario usuario) async{
    var prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(usuario.toJson());
    prefs.setString(_USER, user);
  }

//============================================================================//
//                                    GET

  static Future<String> getLogin() async{
    var prefs = await SharedPreferences.getInstance();
    String? resul = prefs.getString(_LOGIN);
    print(resul);
    if(resul != null){
      return resul;
    }
    return "";
  }

//----------------------------------------------------------------------------//

  static Future<Usuario> getUsuario() async{
    var prefs = await SharedPreferences.getInstance();
    return Usuario.fromJson( jsonDecode(prefs.getString(_USER)!) );
  }


//============================================================================//
//                                  REMOVE

  static removerLogin() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(_LOGIN);
  }

//----------------------------------------------------------------------------//

  static removerUsuario() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(_USER);
  }

//============================================================================//

}