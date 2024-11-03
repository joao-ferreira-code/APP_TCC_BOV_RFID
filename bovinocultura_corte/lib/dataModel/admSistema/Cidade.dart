
class Cidade {
  int? pkCidade;
  int? fkEstado;
  String? txNome;
  String? dtCadastro;

  Cidade({this.pkCidade, this.fkEstado, this.txNome, this.dtCadastro});

  Cidade.fromJson(Map<String, dynamic> json) {
    pkCidade = json['pkCidade'];
    fkEstado = json['fkEstado'];
    txNome = json['txNome'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkCidade'] = this.pkCidade;
    data['fkEstado'] = this.fkEstado;
    data['txNome'] = this.txNome;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }
}
