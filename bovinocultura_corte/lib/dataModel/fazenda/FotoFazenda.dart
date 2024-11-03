
class FotoFazenda {
  int? pkFotoFazenda;
  int? fkFazenda;
  int? fkUsuarioCadastrou;
  String? btFotoFazenda;
  bool? ativa;
  String? dtCadastro;

  FotoFazenda(
      {this.pkFotoFazenda,
        this.fkFazenda,
        this.fkUsuarioCadastrou,
        this.btFotoFazenda,
        this.ativa,
        this.dtCadastro});

  FotoFazenda.fromJson(Map<String, dynamic> json) {
    pkFotoFazenda = json['pkFotoFazenda'];
    fkFazenda = json['fkFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    btFotoFazenda = json['btFotoFazenda'];
    ativa = json['ativa'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkFotoFazenda'] = this.pkFotoFazenda;
    data['fkFazenda'] = this.fkFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['btFotoFazenda'] = this.btFotoFazenda;
    data['ativa'] = this.ativa;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }

}
