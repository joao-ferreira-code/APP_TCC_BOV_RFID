
class Estado {
  int? pkEstado;
  String? txNome;
  String? txSigla;
  String? dtCadastro;

  Estado({this.pkEstado, this.txNome, this.txSigla, this.dtCadastro});

  Estado.fromJson(Map<String, dynamic> json) {
    pkEstado = json['pkEstado'];
    txNome = json['txNome'];
    txSigla = json['txSigla'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkEstado'] = this.pkEstado;
    data['txNome'] = this.txNome;
    data['txSigla'] = this.txSigla;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }
}
