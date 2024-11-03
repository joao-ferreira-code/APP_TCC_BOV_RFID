
class VWDadosDescarte {
  int? pkDescarteBovino;
  int? fkAnimalFazenda;
  int? fkUsuarioCadastrou;
  int? fkFazenda;
  String? dtPerca;
  String? txMotivo;
  String? txObservacao;
  String? dtCadastro;
  String? txNome;
  String? txSexo;
  bool? ativa;

  VWDadosDescarte(
      {this.pkDescarteBovino,
        this.fkAnimalFazenda,
        this.fkUsuarioCadastrou,
        this.fkFazenda,
        this.dtPerca,
        this.txMotivo,
        this.txObservacao,
        this.dtCadastro,
        this.txNome,
        this.txSexo,
        this.ativa});

  VWDadosDescarte.fromJson(Map<String, dynamic> json) {
    pkDescarteBovino = json['pkDescarteBovino'];
    fkAnimalFazenda = json['fkAnimalFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    fkFazenda = json['fkFazenda'];
    dtPerca = json['dtPerca'];
    txMotivo = json['txMotivo'];
    txObservacao = json['txObservacao'];
    dtCadastro = json['dtCadastro'];
    txNome = json['txNome'];
    txSexo = json['txSexo'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkDescarteBovino'] = this.pkDescarteBovino;
    data['fkAnimalFazenda'] = this.fkAnimalFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['fkFazenda'] = this.fkFazenda;
    data['dtPerca'] = this.dtPerca;
    data['txMotivo'] = this.txMotivo;
    data['txObservacao'] = this.txObservacao;
    data['dtCadastro'] = this.dtCadastro;
    data['txNome'] = this.txNome;
    data['txSexo'] = this.txSexo;
    data['ativa'] = this.ativa;
    return data;
  }
}

