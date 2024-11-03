
class LoteTagRFID {
  int? pkLoteTag;
  int? fkFazenda;
  int? fkUsuarioCadastrou;
  int? nrUnidades;
  double? nrValorPago;
  String? txFrequenciaOperacao;
  String? txModeloLeitura;
  String? txSenhaLote;
  String? txObservacaoResumo;
  String? dtCadastro;
  bool? ativa;
  bool? tampProof;
  bool? metalica;

  LoteTagRFID(
      {this.pkLoteTag,
        this.fkFazenda,
        this.fkUsuarioCadastrou,
        this.nrUnidades,
        this.nrValorPago,
        this.txFrequenciaOperacao,
        this.txModeloLeitura,
        this.txSenhaLote,
        this.txObservacaoResumo,
        this.dtCadastro,
        this.ativa,
        this.tampProof,
        this.metalica});

  LoteTagRFID.fromJson(Map<String, dynamic> json) {
    pkLoteTag = json['pkLoteTag'];
    fkFazenda = json['fkFazenda'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    nrUnidades = json['nrUnidades'];
    nrValorPago = json['nrValorPago'];
    txFrequenciaOperacao = json['txFrequenciaOperacao'];
    txModeloLeitura = json['txModeloLeitura'];
    txSenhaLote = json['txSenhaLote'];
    txObservacaoResumo = json['txObservacaoResumo'];
    dtCadastro = json['dtCadastro'];
    ativa = json['ativa'];
    tampProof = json['tampProof'];
    metalica = json['metalica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkLoteTag'] = this.pkLoteTag;
    data['fkFazenda'] = this.fkFazenda;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['nrUnidades'] = this.nrUnidades;
    data['nrValorPago'] = this.nrValorPago;
    data['txFrequenciaOperacao'] = this.txFrequenciaOperacao;
    data['txModeloLeitura'] = this.txModeloLeitura;
    data['txSenhaLote'] = this.txSenhaLote;
    data['txObservacaoResumo'] = this.txObservacaoResumo;
    data['dtCadastro'] = this.dtCadastro;
    data['ativa'] = this.ativa;
    data['tampProof'] = this.tampProof;
    data['metalica'] = this.metalica;
    return data;
  }
}
