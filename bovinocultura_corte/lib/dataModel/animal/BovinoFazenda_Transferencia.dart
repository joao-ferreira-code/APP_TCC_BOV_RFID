
import 'Bovino.dart';
import 'CompraBovino.dart';

class BovinoFazenda_Transferencia {

  int? fkFazenda;
  int? pkBovinoRegistro;
  int? pkBovinoFazendaRegistro;

  CompraBovino? compraBovino;


  BovinoFazenda_Transferencia({
      this.fkFazenda,
      this.compraBovino,
      this.pkBovinoRegistro,
      this.pkBovinoFazendaRegistro,
    });

  BovinoFazenda_Transferencia.fromJson(Map<String, dynamic> json) {
    fkFazenda = json['fkFazenda'];
    compraBovino = json['compraBovino'];

    pkBovinoRegistro = json['pkBovinoRegistro'];
    pkBovinoFazendaRegistro = json['pkBovinoFazendaRegistro'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fkFazenda'] = this.fkFazenda;
    data['compraBovino'] = this.compraBovino;

    data['pkBovinoRegistro'] = this.pkBovinoRegistro;
    data['pkBovinoFazendaRegistro'] = this.pkBovinoFazendaRegistro;

    return data;
  }
}
