
class Resposta {
  String? key;
  int? code;
  String? message;
  String? errorDetail;
  dynamic? value;

//----------------------------------------------------------------------------//

  Resposta(
      {this.key, this.code, this.message, this.errorDetail, this.value});

//----------------------------------------------------------------------------//

  Resposta.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    message = json['message'];
    errorDetail = json['errorDetail'];
    value = json['value'];
  }

//----------------------------------------------------------------------------//

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    data['message'] = this.message;
    data['errorDetail'] = this.errorDetail;
    data['value'] = this.value!.toJson();

    return data;
  }

//----------------------------------------------------------------------------//

}
