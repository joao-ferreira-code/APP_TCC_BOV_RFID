
class ColaboradorFazenda {
  int? pkColaboradorFazenda;
  int? fkFazenda;
  int? fkUsuario;
  int? fkUsuarioCadastrou;
  int? fkNivelAcesso;
  String? txMotivoSaida;
  String? dtCadastro;
  String? dtRemocao;
  bool? ativa;

  ColaboradorFazenda(
      {this.pkColaboradorFazenda,
        this.fkFazenda,
        this.fkUsuario,
        this.fkUsuarioCadastrou,
        this.fkNivelAcesso,
        this.txMotivoSaida,
        this.dtCadastro,
        this.dtRemocao,
        this.ativa});

  ColaboradorFazenda.fromJson(Map<String, dynamic> json) {
    pkColaboradorFazenda = json['pkColaboradorFazenda'];
    fkFazenda = json['fkFazenda'];
    fkUsuario = json['fkUsuario'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    fkNivelAcesso = json['fkNivelAcesso'];
    txMotivoSaida = json['txMotivoSaida'];
    dtCadastro = json['dtCadastro'];
    dtRemocao = json['dtRemocao'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkColaboradorFazenda'] = this.pkColaboradorFazenda;
    data['fkFazenda'] = this.fkFazenda;
    data['fkUsuario'] = this.fkUsuario;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['fkNivelAcesso'] = this.fkNivelAcesso;
    data['txMotivoSaida'] = this.txMotivoSaida;
    data['dtCadastro'] = this.dtCadastro;
    data['dtRemocao'] = this.dtRemocao;
    data['ativa'] = this.ativa;
    return data;
  }
}
