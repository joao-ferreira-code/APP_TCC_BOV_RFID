
class CompraBovino {
  int? pkCompraBovino;
  int? fkAnimalFazenda;
  int? fkUsuarioCadastrou;
  int? nrPesagem;
  int? nrValor;
  int? nrValorArroba;
  String? dtCadastro;
  String? dtCompra;
  bool? ativa;
  bool? pesagemEstimada;

  CompraBovino(
      {this.pkCompraBovino,
        this.fkAnimalFazenda,
        this.fkUsuarioCadastrou,
        this.nrPesagem,
        this.nrValor,
        this.nrValorArroba,
        this.dtCadastro,
        this.dtCompra,
        this.ativa,
        this.pesagemEstimada});

  CompraBovino.fromJson(Map<String, dynamic> json) {
    pkCompraBovino = json['pkCompraBovino'];
    fkAnimalFazenda = json['fkAnimalFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    nrPesagem = json['nrPesagem'];
    nrValor = json['nrValor'];
    nrValorArroba = json['nrValorArroba'];
    dtCadastro = json['dtCadastro'];
    dtCompra = json['dtCompra'];
    ativa = json['ativa'];
    pesagemEstimada = json['pesagemEstimada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkCompraBovino'] = this.pkCompraBovino;
    data['fkAnimalFazenda'] = this.fkAnimalFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['nrPesagem'] = this.nrPesagem;
    data['nrValor'] = this.nrValor;
    data['nrValorArroba'] = this.nrValorArroba;
    data['dtCadastro'] = this.dtCadastro;
    data['dtCompra'] = this.dtCompra;
    data['ativa'] = this.ativa;
    data['pesagemEstimada'] = this.pesagemEstimada;
    return data;
  }
}
