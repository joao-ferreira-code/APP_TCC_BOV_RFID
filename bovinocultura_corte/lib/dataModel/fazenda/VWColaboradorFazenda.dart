

class VWColaboradorFazenda {
  int? pkColaboradorFazenda;
  int? fkFazenda;
  int? fkUsuario;
  int? fkUsuarioCadastrou;
  int? fkNivelAcesso;
  String? txMotivoSaida;
  String? dtCadastro;
  String? dtRemocao;
  String? nivAcessNome;
  String? nivAcessDescricao;
  String? txNome;
  String? txLogin;
  String? dtNascimento;
  bool? ativa;
  bool? autenticado;

  VWColaboradorFazenda(
      {this.pkColaboradorFazenda,
        this.fkFazenda,
        this.fkUsuario,
        this.fkUsuarioCadastrou,
        this.fkNivelAcesso,
        this.txMotivoSaida,
        this.dtCadastro,
        this.dtRemocao,
        this.nivAcessNome,
        this.nivAcessDescricao,
        this.txNome,
        this.txLogin,
        this.dtNascimento,
        this.ativa,
        this.autenticado});

  VWColaboradorFazenda.fromJson(Map<String, dynamic> json) {
    pkColaboradorFazenda = json['pkColaboradorFazenda'];
    fkFazenda = json['fkFazenda'];
    fkUsuario = json['fkUsuario'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    fkNivelAcesso = json['fkNivelAcesso'];
    txMotivoSaida = json['txMotivoSaida'];
    dtCadastro = json['dtCadastro'];
    dtRemocao = json['dtRemocao'];
    nivAcessNome = json['nivAcessNome'];
    nivAcessDescricao = json['nivAcessDescricao'];
    txNome = json['txNome'];
    txLogin = json['txLogin'];
    dtNascimento = json['dtNascimento'];
    ativa = json['ativa'];
    autenticado = json['autenticado'];
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
    data['nivAcessNome'] = this.nivAcessNome;
    data['nivAcessDescricao'] = this.nivAcessDescricao;
    data['txNome'] = this.txNome;
    data['txLogin'] = this.txLogin;
    data['dtNascimento'] = this.dtNascimento;
    data['ativa'] = this.ativa;
    data['autenticado'] = this.autenticado;
    return data;
  }
}
