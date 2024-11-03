
class LoteVacina {
  int? pkVacina;
  int? fkFazenda;
  int? fkUsuarioCadastrou;
  String? txNomeVacina;
  String? txNomeLoteVacina;
  int? nrCusto;
  int? nrUnidades;
  String? dtVencimento;
  String? txObservacao;
  String? dtCadastro;
  bool? ativa;
  bool? registradaIndagro;
  bool? obrigatoria;

  LoteVacina(
      {this.pkVacina,
        this.fkFazenda,
        this.fkUsuarioCadastrou,
        this.txNomeVacina,
        this.txNomeLoteVacina,
        this.nrCusto,
        this.nrUnidades,
        this.dtVencimento,
        this.txObservacao,
        this.dtCadastro,
        this.ativa,
        this.registradaIndagro,
        this.obrigatoria});

  LoteVacina.fromJson(Map<String, dynamic> json) {
    pkVacina = json['pkVacina'];
    fkFazenda = json['fkFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    txNomeVacina = json['txNomeVacina'];
    txNomeLoteVacina = json['txNomeLoteVacina'];
    nrCusto = json['nrCusto'];
    nrUnidades = json['nrUnidades'];
    dtVencimento = json['dtVencimento'];
    txObservacao = json['txObservacao'];
    dtCadastro = json['dtCadastro'];
    ativa = json['ativa'];
    registradaIndagro = json['registradaIndagro'];
    obrigatoria = json['obrigatoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkVacina'] = this.pkVacina;
    data['fkFazenda'] = this.fkFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['txNomeVacina'] = this.txNomeVacina;
    data['txNomeLoteVacina'] = this.txNomeLoteVacina;
    data['nrCusto'] = this.nrCusto;
    data['nrUnidades'] = this.nrUnidades;
    data['dtVencimento'] = this.dtVencimento;
    data['txObservacao'] = this.txObservacao;
    data['dtCadastro'] = this.dtCadastro;
    data['ativa'] = this.ativa;
    data['registradaIndagro'] = this.registradaIndagro;
    data['obrigatoria'] = this.obrigatoria;
    return data;
  }
}
