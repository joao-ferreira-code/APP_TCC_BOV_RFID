
class Dimensionamento{

//----------------------------------------------------------------------------//

  static tamanhoComponentes(double tamanhoTela, {double? porcentagemTela}){
    if(porcentagemTela == null){
      porcentagemTela = 0.94;
    }

    if(tamanhoTela>480){
      return (480 * porcentagemTela)/1;
    }
    return (tamanhoTela * porcentagemTela)/1;
  }

//----------------------------------------------------------------------------//

  static tamanhoComponentesFull(int tamanhoTela, {double? porcentagemTela}){
    if(porcentagemTela == null){
      porcentagemTela = 0.9;
    }
    if(tamanhoTela<550){
      return 550 * porcentagemTela;
    }
    return (tamanhoTela * .86)~/1;
  }

//----------------------------------------------------------------------------//

}