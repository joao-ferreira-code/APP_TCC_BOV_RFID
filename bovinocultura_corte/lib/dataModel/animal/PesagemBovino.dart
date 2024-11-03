
class PesagemBovino {
  int? pkPesagemBovino;
  int? fkAnimalFazenda;
  int? fkUsuarioCadastrou;
  String? dtPesagem;
  double? nrPeso;
  String? dtCadastro;

  PesagemBovino(
      {this.pkPesagemBovino,
        this.fkAnimalFazenda,
        this.fkUsuarioCadastrou,
        this.dtPesagem,
        this.nrPeso,
        this.dtCadastro});

  PesagemBovino.fromJson(Map<String, dynamic> json) {
    pkPesagemBovino = json['pkPesagemBovino'];
    fkAnimalFazenda = json['fkAnimalFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    dtPesagem = json['dtPesagem'];
    nrPeso = json['nrPeso'];
    dtCadastro = json['dtCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkPesagemBovino'] = this.pkPesagemBovino;
    data['fkAnimalFazenda'] = this.fkAnimalFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['dtPesagem'] = this.dtPesagem;
    data['nrPeso'] = this.nrPeso;
    data['dtCadastro'] = this.dtCadastro;
    return data;
  }
}
