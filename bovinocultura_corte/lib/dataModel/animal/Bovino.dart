
class Bovino {
  int? pkBovino;
  int? fkBovinoMatrizFemea;
  int? fkBovinoMatrizMacho;
  int? fkRaca;
  int? fkUsuarioCadastrou;
  String? txSexo;
  String? dtNascimento;
  String? txGrauSangue;
  String? txAvaliacao;
  String? dtCadastro;
  bool? ativa;
  bool? inseminacao;

  Bovino(
      {this.pkBovino,
        this.fkBovinoMatrizFemea,
        this.fkBovinoMatrizMacho,
        this.fkRaca,
        this.fkUsuarioCadastrou,
        this.txSexo,
        this.dtNascimento,
        this.txGrauSangue,
        this.txAvaliacao,
        this.dtCadastro,
        this.ativa,
        this.inseminacao});

  Bovino.fromJson(Map<String, dynamic> json) {
    pkBovino = json['pkBovino'];
    fkBovinoMatrizFemea = json['fkBovinoMatrizFemea'];
    fkBovinoMatrizMacho = json['fkBovinoMatrizMacho'];
    fkRaca = json['fkRaca'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    txSexo = json['txSexo'];
    dtNascimento = json['dtNascimento'];
    txGrauSangue = json['txGrauSangue'];
    txAvaliacao = json['txAvaliacao'];
    dtCadastro = json['dtCadastro'];
    ativa = json['ativa'];
    inseminacao = json['inseminacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkBovino'] = this.pkBovino;
    data['fkBovinoMatrizFemea'] = this.fkBovinoMatrizFemea;
    data['fkBovinoMatrizMacho'] = this.fkBovinoMatrizMacho;
    data['fkRaca'] = this.fkRaca;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['txSexo'] = this.txSexo;
    data['dtNascimento'] = this.dtNascimento;
    data['txGrauSangue'] = this.txGrauSangue;
    data['txAvaliacao'] = this.txAvaliacao;
    data['dtCadastro'] = this.dtCadastro;
    data['ativa'] = this.ativa;
    data['inseminacao'] = this.inseminacao;
    return data;
  }
}
