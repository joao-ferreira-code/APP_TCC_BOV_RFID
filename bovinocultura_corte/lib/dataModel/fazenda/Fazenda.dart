
class Fazenda {
  int? pkFazenda;
  int? fkCidade;
  int? fkUsuarioCadastrou;
  String? txNome;
  double? nrTotalHectares;
  String? txTelefone;
  String? dtCadastro;
  String? dtRemocao;
  bool? ativa;
  String? btFotoFazenda;
  String? txCodigoPublico;

  Fazenda(
      {this.pkFazenda,
        this.fkUsuarioCadastrou,
        this.fkCidade,
        this.txNome,
        this.nrTotalHectares,
        this.txTelefone,
        this.dtCadastro,
        this.dtRemocao,
        this.ativa,
        this.btFotoFazenda,
        this.txCodigoPublico,
      });

  Fazenda.fromJson(Map<String, dynamic> json) {
    pkFazenda = json['pkFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    fkCidade = json['fkCidade'];
    txNome = json['txNome'];
    nrTotalHectares = json['nrTotalHectares'];
    txTelefone = json['txTelefone'];
    dtCadastro = json['dtCadastro'];
    dtRemocao = json['dtRemocao'];
    ativa = json['ativa'];
    btFotoFazenda = json['btFotoFazenda'];
    txCodigoPublico = json['txCodigoPublico'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['pkFazenda'] = this.pkFazenda;
    data['fkCidade'] = this.fkCidade;
    data['txNome'] = this.txNome;
    data['nrTotalHectares'] = this.nrTotalHectares;
    data['txTelefone'] = this.txTelefone;
    data['dtCadastro'] = this.dtCadastro;
    data['dtRemocao'] = this.dtRemocao;
    data['ativa'] = this.ativa;
    data['btFotoFazenda'] = this.btFotoFazenda;
    data['txCodigoPublico'] = this.txCodigoPublico;
    return data;
  }

}
