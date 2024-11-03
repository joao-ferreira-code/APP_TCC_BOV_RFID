
class NivelAcesso {
  int? pkNivelAcesso;
  String? txNome;
  String? txDescricaoNivelAcesso;
  String? dtCadastro;
  String? authority;
  bool? ativa;

  NivelAcesso(
      {this.pkNivelAcesso,
        this.txNome,
        this.txDescricaoNivelAcesso,
        this.dtCadastro,
        this.authority,
        this.ativa});

  NivelAcesso.fromJson(Map<String, dynamic> json) {
    pkNivelAcesso = json['pkNivelAcesso'];
    txNome = json['txNome'];
    txDescricaoNivelAcesso = json['txDescricaoNivelAcesso'];
    dtCadastro = json['dtCadastro'];
    authority = json['authority'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkNivelAcesso'] = this.pkNivelAcesso;
    data['txNome'] = this.txNome;
    data['txDescricaoNivelAcesso'] = this.txDescricaoNivelAcesso;
    data['dtCadastro'] = this.dtCadastro;
    data['authority'] = this.authority;
    data['ativa'] = this.ativa;
    return data;
  }
}
