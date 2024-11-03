import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const MASCARA_NUMERO_CPF = "###.###.###-##";
const MASCARA_NUMERO_CNPJ = "##.###.###/####-##";

const MASCARA_NUMERO_CELULAR = "(##) # ####-####";
const MASCARA_NUMERO_TELEFONE = "(##) ####-####";

const MASCARA_DATA = "##/##/####";
const MASCARA_DATA_MES_ANO = "##/####";
const MASCARA_HORARIO = "##:##";


class InputFormatter {

  static var numeroCPF = new MaskTextInputFormatter(mask: MASCARA_NUMERO_CPF, filter: { "#": RegExp(r'[0-9]') });
  static var numeroCNPJ = new MaskTextInputFormatter(mask: MASCARA_NUMERO_CNPJ, filter: { "#": RegExp(r'[0-9]') });

  static var numeroCelular = new MaskTextInputFormatter(mask: MASCARA_NUMERO_CELULAR, filter: { "#": RegExp(r'[0-9]') });
  static var numeroTelefone = new MaskTextInputFormatter(mask: MASCARA_NUMERO_TELEFONE, filter: { "#": RegExp(r'[0-9]') });

  static var data = new MaskTextInputFormatter(mask: MASCARA_DATA, filter: { "#": RegExp(r'[0-9]') });
  static var data_MesAno = new MaskTextInputFormatter(mask: MASCARA_DATA_MES_ANO, filter: { "#": RegExp(r'[0-9]') });
  static var horario = new MaskTextInputFormatter(mask: MASCARA_HORARIO, filter: { "#": RegExp(r'[0-9]') });

}