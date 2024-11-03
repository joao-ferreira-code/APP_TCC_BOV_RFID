
class Raca {
  int? pkRaca;
  String? txNome;
  String? txDescricao;
  String? dtCadastro;
  bool? ativa;

  Raca(
      {this.pkRaca,
        this.txNome,
        this.txDescricao,
        this.dtCadastro,
        this.ativa});

  Raca.fromJson(Map<String, dynamic> json) {
    pkRaca = json['pkRaca'];
    txNome = json['txNome'];
    txDescricao = json['txDescricao'];
    dtCadastro = json['dtCadastro'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkRaca'] = this.pkRaca;
    data['txNome'] = this.txNome;
    data['txDescricao'] = this.txDescricao;
    data['dtCadastro'] = this.dtCadastro;
    data['ativa'] = this.ativa;
    return data;
  }
}
