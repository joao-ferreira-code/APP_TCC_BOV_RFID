
class VacinacaoBovino {
  int? pkVacinacaoBovino;
  int? fkAnimalFazenda;
  int? fkVacina;
  int? fkUsuarioCadastrou;
  String? txMotivo;
  String? dtVacinacao;
  String? dtCadastro;

  VacinacaoBovino(
      {this.pkVacinacaoBovino,
        this.fkAnimalFazenda,
        this.fkVacina,
        this.fkUsuarioCadastrou,
        this.txMotivo,
        this.dtVacinacao,
        this.dtCadastro});

  VacinacaoBovino.fromJson(Map<String, dynamic> json) {
    pkVacinacaoBovino = json['pkVacinacaoBovino'];
    fkAnimalFazenda = json['fkAnimalFazenda'];
    fkVacina = json['fkVacina'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    txMotivo = json['txMotivo'];
    dtVacinacao = json['dtVacinacao'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkVacinacaoBovino'] = this.pkVacinacaoBovino;
    data['fkAnimalFazenda'] = this.fkAnimalFazenda;
    data['fkVacina'] = this.fkVacina;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['txMotivo'] = this.txMotivo;
    data['dtVacinacao'] = this.dtVacinacao;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }
}
