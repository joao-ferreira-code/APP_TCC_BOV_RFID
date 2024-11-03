
class DescarteBovino {
  int? pkDescarteBovino;
  int? fkAnimalFazenda;
  int? fkUsuarioCadastrou;
  String? dtPerca;
  String? txMotivo;
  String? txObservacao;
  String? dtCadastro;
  bool? ativa;

  DescarteBovino(
      {this.pkDescarteBovino,
        this.fkAnimalFazenda,
        this.fkUsuarioCadastrou,
        this.dtPerca,
        this.txMotivo,
        this.txObservacao,
        this.dtCadastro,
        this.ativa});

  DescarteBovino.fromJson(Map<String, dynamic> json) {
    pkDescarteBovino = json['pkDescarteBovino'];
    fkAnimalFazenda = json['fkAnimalFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    dtPerca = json['dtPerca'];
    txMotivo = json['txMotivo'];
    txObservacao = json['txObservacao'];
    dtCadastro = json['dtCadastro'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkDescarteBovino'] = this.pkDescarteBovino;
    data['fkAnimalFazenda'] = this.fkAnimalFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['dtPerca'] = this.dtPerca;
    data['txMotivo'] = this.txMotivo;
    data['txObservacao'] = this.txObservacao;
    data['dtCadastro'] = this.dtCadastro;
    data['ativa'] = this.ativa;
    return data;
  }
}
