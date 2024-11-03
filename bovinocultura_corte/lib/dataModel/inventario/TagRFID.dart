
class TagRFID {
  int? pkTagRfid;
  int? fkLoteTag;
  int? fkUsuarioCadastrou;
  String? txCodigoEpc;
  String? txMotivoRemocao;
  String? dtCadastro;
  String? dtRemocao;
  bool? ativa;

  TagRFID(
      {this.pkTagRfid,
        this.fkLoteTag,
        this.fkUsuarioCadastrou,
        this.txCodigoEpc,
        this.txMotivoRemocao,
        this.dtCadastro,
        this.dtRemocao,
        this.ativa});

  TagRFID.fromJson(Map<String, dynamic> json) {
    pkTagRfid = json['pkTagRfid'];
    fkLoteTag = json['fkLoteTag'];
    fkUsuarioCadastrou = json['fkUsuarioCadastrou'];
    txCodigoEpc = json['txCodigoEpc'];
    txMotivoRemocao = json['txMotivoRemocao'];
    dtCadastro = json['dtCadastro'];
    dtRemocao = json['dtRemocao'];
    ativa = json['ativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkTagRfid'] = this.pkTagRfid;
    data['fkLoteTag'] = this.fkLoteTag;
    data['fkUsuarioCadastrou'] = this.fkUsuarioCadastrou;
    data['txCodigoEpc'] = this.txCodigoEpc;
    data['txMotivoRemocao'] = this.txMotivoRemocao;
    data['dtCadastro'] = this.dtCadastro;
    data['dtRemocao'] = this.dtRemocao;
    data['ativa'] = this.ativa;
    return data;
  }
}

