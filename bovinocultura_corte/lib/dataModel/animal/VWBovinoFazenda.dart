
class VWBovinoFazenda {
  int? pkBovinoFazenda;
  int? fkFazenda;
  String? bofTxObtencao;
  String? bofTxBaixa;
  String? bofIsAtiva;
  String? bofDtCadastro;
  String? bofDtBaixa;
  int? pkBovino;
  String? bovTxSexo;
  String? bovDtNascimento;
  String? bovTxGrauSangue;
  String? bovIsInseminacao;
  String? bovTxAvaliacao;
  String? racTxNome;
  String? pkRaca;
  String? pkTagRfid;
  String? txCodigoEpc;
  String? pkVenda;
  String? venNrPesagem;
  String? venNrValor;
  String? venNrValorArroba;
  String? venIsPesagemEstimada;
  String? venIsAtiva;
  String? venDtCadastro;
  String? venDtVenda;
  String? pkCompraBovino;
  String? cmpNrPesagem;
  String? cmpNrValor;
  String? cmpNrValorArroba;
  String? cmpIsPesagemEstimada;
  String? cmpIsAtiva;
  String? cmpDtCompra;
  String? cmpDtCadastro;
  String? pkDescarteBovino;
  String? dsbDtPerca;
  String? dsbTxMotivo;
  String? dsbTxObservacao;
  String? dsbIsAtiva;
  String? dsbDtCadastro;
  String? colabCadBovinoNome;
  String? colabCadVendNome;
  String? colabCadComNome;
  String? colabCadDesNome;

  VWBovinoFazenda(
      {this.pkBovinoFazenda,
        this.fkFazenda,
        this.bofTxObtencao,
        this.bofTxBaixa,
        this.bofIsAtiva,
        this.bofDtCadastro,
        this.bofDtBaixa,
        this.pkBovino,
        this.bovTxSexo,
        this.bovDtNascimento,
        this.bovTxGrauSangue,
        this.bovIsInseminacao,
        this.bovTxAvaliacao,
        this.racTxNome,
        this.pkRaca,
        this.pkTagRfid,
        this.txCodigoEpc,
        this.pkVenda,
        this.venNrPesagem,
        this.venNrValor,
        this.venNrValorArroba,
        this.venIsPesagemEstimada,
        this.venIsAtiva,
        this.venDtCadastro,
        this.venDtVenda,
        this.pkCompraBovino,
        this.cmpNrPesagem,
        this.cmpNrValor,
        this.cmpNrValorArroba,
        this.cmpIsPesagemEstimada,
        this.cmpIsAtiva,
        this.cmpDtCompra,
        this.cmpDtCadastro,
        this.pkDescarteBovino,
        this.dsbDtPerca,
        this.dsbTxMotivo,
        this.dsbTxObservacao,
        this.dsbIsAtiva,
        this.dsbDtCadastro,
        this.colabCadBovinoNome,
        this.colabCadVendNome,
        this.colabCadComNome,
        this.colabCadDesNome});

  VWBovinoFazenda.fromJson(Map<String, dynamic> json) {
    pkBovinoFazenda = json['pkBovinoFazenda'];
    fkFazenda = json['fkFazenda'];
    bofTxObtencao = json['bofTxObtencao'];
    bofTxBaixa = json['bofTxBaixa'];
    bofIsAtiva = json['bofIsAtiva'];
    bofDtCadastro = json['bofDtCadastro'];
    bofDtBaixa = json['bofDtBaixa'];
    pkBovino = json['pkBovino'];
    bovTxSexo = json['bovTxSexo'];
    bovDtNascimento = json['bovDtNascimento'];
    bovTxGrauSangue = json['bovTxGrauSangue'];
    bovIsInseminacao = json['bovIsInseminacao'];
    bovTxAvaliacao = json['bovTxAvaliacao'];
    racTxNome = json['racTxNome'];
    pkRaca = json['pkRaca'];
    pkTagRfid = json['pkTagRfid'];
    txCodigoEpc = json['txCodigoEpc'];
    pkVenda = json['pkVenda'];
    venNrPesagem = json['venNrPesagem'];
    venNrValor = json['venNrValor'];
    venNrValorArroba = json['venNrValorArroba'];
    venIsPesagemEstimada = json['venIsPesagemEstimada'];
    venIsAtiva = json['venIsAtiva'];
    venDtCadastro = json['venDtCadastro'];
    venDtVenda = json['venDtVenda'];
    pkCompraBovino = json['pkCompraBovino'];
    cmpNrPesagem = json['cmpNrPesagem'];
    cmpNrValor = json['cmpNrValor'];
    cmpNrValorArroba = json['cmpNrValorArroba'];
    cmpIsPesagemEstimada = json['cmpIsPesagemEstimada'];
    cmpIsAtiva = json['cmpIsAtiva'];
    cmpDtCompra = json['cmpDtCompra'];
    cmpDtCadastro = json['cmpDtCadastro'];
    pkDescarteBovino = json['pkDescarteBovino'];
    dsbDtPerca = json['dsbDtPerca'];
    dsbTxMotivo = json['dsbTxMotivo'];
    dsbTxObservacao = json['dsbTxObservacao'];
    dsbIsAtiva = json['dsbIsAtiva'];
    dsbDtCadastro = json['dsbDtCadastro'];
    colabCadBovinoNome = json['colabCadBovinoNome'];
    colabCadVendNome = json['colabCadVendNome'];
    colabCadComNome = json['colabCadComNome'];
    colabCadDesNome = json['colabCadDesNome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkBovinoFazenda'] = this.pkBovinoFazenda;
    data['fkFazenda'] = this.fkFazenda;
    data['bofTxObtencao'] = this.bofTxObtencao;
    data['bofTxBaixa'] = this.bofTxBaixa;
    data['bofIsAtiva'] = this.bofIsAtiva;
    data['bofDtCadastro'] = this.bofDtCadastro;
    data['bofDtBaixa'] = this.bofDtBaixa;
    data['pkBovino'] = this.pkBovino;
    data['bovTxSexo'] = this.bovTxSexo;
    data['bovDtNascimento'] = this.bovDtNascimento;
    data['bovTxGrauSangue'] = this.bovTxGrauSangue;
    data['bovIsInseminacao'] = this.bovIsInseminacao;
    data['bovTxAvaliacao'] = this.bovTxAvaliacao;
    data['racTxNome'] = this.racTxNome;
    data['pkRaca'] = this.pkRaca;
    data['pkTagRfid'] = this.pkTagRfid;
    data['txCodigoEpc'] = this.txCodigoEpc;
    data['pkVenda'] = this.pkVenda;
    data['venNrPesagem'] = this.venNrPesagem;
    data['venNrValor'] = this.venNrValor;
    data['venNrValorArroba'] = this.venNrValorArroba;
    data['venIsPesagemEstimada'] = this.venIsPesagemEstimada;
    data['venIsAtiva'] = this.venIsAtiva;
    data['venDtCadastro'] = this.venDtCadastro;
    data['venDtVenda'] = this.venDtVenda;
    data['pkCompraBovino'] = this.pkCompraBovino;
    data['cmpNrPesagem'] = this.cmpNrPesagem;
    data['cmpNrValor'] = this.cmpNrValor;
    data['cmpNrValorArroba'] = this.cmpNrValorArroba;
    data['cmpIsPesagemEstimada'] = this.cmpIsPesagemEstimada;
    data['cmpIsAtiva'] = this.cmpIsAtiva;
    data['cmpDtCompra'] = this.cmpDtCompra;
    data['cmpDtCadastro'] = this.cmpDtCadastro;
    data['pkDescarteBovino'] = this.pkDescarteBovino;
    data['dsbDtPerca'] = this.dsbDtPerca;
    data['dsbTxMotivo'] = this.dsbTxMotivo;
    data['dsbTxObservacao'] = this.dsbTxObservacao;
    data['dsbIsAtiva'] = this.dsbIsAtiva;
    data['dsbDtCadastro'] = this.dsbDtCadastro;
    data['colabCadBovinoNome'] = this.colabCadBovinoNome;
    data['colabCadVendNome'] = this.colabCadVendNome;
    data['colabCadComNome'] = this.colabCadComNome;
    data['colabCadDesNome'] = this.colabCadDesNome;
    return data;
  }
}
