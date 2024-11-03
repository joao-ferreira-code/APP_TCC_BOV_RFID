
class Usuario {
  int? pkUsuario;
  int? fkCidade;
  String? txNome;
  String? dtNascimento;
  String? txTelefone;
  String? txLogin;
  String? txSenha;
  String? txToken;
  String? txTokenJWT;
  bool? isAutenticado;
  bool? isVerficado;
  bool? isAtiva;
  String? dtCadastro;
  String? btFotoUsuario;

  Usuario(
      {this.pkUsuario,
        this.fkCidade,
        this.txNome,
        this.dtNascimento,
        this.txTelefone,
        this.txLogin,
        this.txSenha,
        this.txToken,
        this.txTokenJWT,
        this.isAutenticado,
        this.isVerficado,
        this.isAtiva,
        this.dtCadastro, this.btFotoUsuario});

  Usuario.fromJson(Map<String, dynamic> json) {
    pkUsuario = json['pkUsuario'];
    fkCidade = json['fkCidade'];
    txNome = json['txNome'];
    dtNascimento = json['dtNascimento'];
    txTelefone = json['txTelefone'];
    txLogin = json['txLogin'];
    txSenha = json['txSenha'];
    txToken = json['txToken'];
    txTokenJWT = json['txTokenJWT'];
    isAutenticado = json['isAutenticado'];
    isVerficado = json['isVerficado'];
    isAtiva = json['isAtiva'];
    dtCadastro = json['dtCadastro'];
    btFotoUsuario = json['btFotoUsuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkUsuario'] = this.pkUsuario;
    data['fkCidade'] = this.fkCidade;
    data['txNome'] = this.txNome;
    data['dtNascimento'] = this.dtNascimento;
    data['txTelefone'] = this.txTelefone;
    data['txLogin'] = this.txLogin;
    data['txSenha'] = this.txSenha;
    data['txToken'] = this.txToken;
    data['txTokenJWT'] = this.txTokenJWT;
    data['isAutenticado'] = this.isAutenticado;
    data['isVerficado'] = this.isVerficado;
    data['isAtiva'] = this.isAtiva;
    data['dtCadastro'] = this.dtCadastro;
    data['btFotoUsuario'] = this.btFotoUsuario;
    return data;
  }
}
