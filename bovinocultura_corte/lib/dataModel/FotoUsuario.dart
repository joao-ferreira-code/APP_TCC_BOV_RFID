
class FotoUsuario {
  int? pkFotoUsuario;
  int? fkUsuario;
  String? btFotoUsuario;
  bool? ativa;
  int? dtCadastro;

  FotoUsuario(
      {this.pkFotoUsuario,
        this.fkUsuario,
        this.btFotoUsuario,
        this.ativa,
        this.dtCadastro});

  FotoUsuario.fromJson(Map<String, dynamic> json) {
    pkFotoUsuario = json['pkFotoUsuario'];
    fkUsuario = json['fkUsuario'];
    btFotoUsuario = json['btFotoUsuario'];
    ativa = json['ativa'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkFotoUsuario'] = this.pkFotoUsuario;
    data['fkUsuario'] = this.fkUsuario;
    data['btFotoUsuario'] = this.btFotoUsuario;
    data['ativa'] = this.ativa;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }
}
