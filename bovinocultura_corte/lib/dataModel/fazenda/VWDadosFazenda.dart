
class VWDadosFazenda {
  int? pkFazenda;
  int? fkUsuarioCadastrou;
  int? fkCidade;
  String? txNome;
  int? nrTotalHectares;
  String? dtCadastro;
  Null? dtRemocao;
  String? txTelefone;
  String? txCodigoPublico;
  String? cidTxNome;
  String? txSigla;
  bool? ativa;

  VWDadosFazenda(
      {this.pkFazenda,
        this.fkUsuarioCadastrou,
        this.fkCidade,
        this.txNome,
        this.nrTotalHectares,
        this.dtCadastro,
        this.dtRemocao,
        this.txTelefone,
        this.txCodigoPublico,
        this.cidTxNome,
        this.txSigla,
        this.ativa});

  VWDadosFazenda.fromJson(Map<String, dynamic> json) {
    pkFazenda = json['pkFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    fkCidade = json['fkCidade'];
    txNome = json['txNome'];
    nrTotalHectares = json['nrTotalHectares'];
    dtCadastro = json['dtCadastro'];
    dtRemocao = json['dtRemocao'];
    txTelefone = json['txTelefone'];
    txCodigoPublico = json['txCodigoPublico'];
    cidTxNome = json['cidTxNome'];
    txSigla = json['txSigla'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkFazenda'] = this.pkFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['fkCidade'] = this.fkCidade;
    data['txNome'] = this.txNome;
    data['nrTotalHectares'] = this.nrTotalHectares;
    data['dtCadastro'] = this.dtCadastro;
    data['dtRemocao'] = this.dtRemocao;
    data['txTelefone'] = this.txTelefone;
    data['txCodigoPublico'] = this.txCodigoPublico;
    data['cidTxNome'] = this.cidTxNome;
    data['txSigla'] = this.txSigla;
    data['ativa'] = this.ativa;
    return data;
  }
}
