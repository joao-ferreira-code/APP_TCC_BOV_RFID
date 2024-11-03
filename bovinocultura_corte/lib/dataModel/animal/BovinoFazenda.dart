
import 'Bovino.dart';
import 'CompraBovino.dart';

class BovinoFazenda_Cad {

//---------- Dados Fundamentais ----------//

  int? fkFazenda;

  Bovino? bovino;
  CompraBovino? compraBovino;


//---------- Animais  ----------//

  int? pkBovinoRegistro;
  int? pkBovinoFazendaRegistro;
  int? fkTagRFID_Registro;
  String? txCodigoEpc;


  int? pkBovinoMatrizFemea;
  int? pkBovinoFazendaMatrizFemea;
  String? fkTagRFID_MatrizFemea;

  int? pkBovinoMatrizMacho;
  int? pkBovinoFazendaMatrizMacho;
  String? fkTagRFID_MatrizMacho;

//----------------------------------------------------------------------------//

  BovinoFazenda_Cad({
        this.fkFazenda,
        this.bovino,
        this.compraBovino,


        this.pkBovinoRegistro,
        this.pkBovinoFazendaRegistro,
        this.fkTagRFID_Registro,

        this.pkBovinoMatrizFemea,
        this.pkBovinoFazendaMatrizFemea,
        this.fkTagRFID_MatrizFemea,

        this.pkBovinoMatrizMacho,
        this.pkBovinoFazendaMatrizMacho,
        this.fkTagRFID_MatrizMacho,

        this.txCodigoEpc,
      });

  BovinoFazenda_Cad.fromJson(Map<String, dynamic> json) {
    fkFazenda = json['fkFazenda'];
    bovino = json['bovino'];
    compraBovino = json['compraBovino'];

    pkBovinoRegistro = json['pkBovinoRegistro'];
    pkBovinoFazendaRegistro = json['pkBovinoFazendaRegistro'];
    fkTagRFID_Registro = json['fkTagRFID_Registro'];

    pkBovinoMatrizFemea = json['pkBovinoMatrizFemea'];
    pkBovinoFazendaMatrizFemea = json['pkBovinoFazendaMatrizFemea'];
    fkTagRFID_MatrizFemea = json['fkTagRFID_MatrizFemea'];

    pkBovinoMatrizMacho = json['pkBovinoMatrizMacho'];
    pkBovinoFazendaMatrizMacho = json['pkBovinoFazendaMatrizMacho'];
    fkTagRFID_MatrizMacho = json['fkTagRFID_MatrizMacho'];

    txCodigoEpc = json['txCodigoEpc'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fkFazenda'] = this.fkFazenda;
    data['bovino'] = this.bovino;
    data['compraBovino'] = this.compraBovino;

    data['pkBovinoRegistro'] = this.pkBovinoRegistro;
    data['pkBovinoFazendaRegistro'] = this.pkBovinoFazendaRegistro;
    data['fkTagRFID_Registro'] = this.fkTagRFID_Registro;

    data['pkBovinoMatrizFemea'] = this.pkBovinoMatrizFemea;
    data['pkBovinoFazendaMatrizFemea'] = this.pkBovinoFazendaMatrizFemea;
    data['fkTagRFID_MatrizFemea'] = this.fkTagRFID_MatrizFemea;

    data['pkBovinoMatrizMacho'] = this.pkBovinoMatrizMacho;
    data['pkBovinoFazendaMatrizMacho'] = this.pkBovinoFazendaMatrizMacho;
    data['fkTagRFID_MatrizMacho'] = this.fkTagRFID_MatrizMacho;

    return data;
  }
}
