class ParametroHelper {
  static String getArgumentoTipoAtivo(String texto) {
    String argumento = '';
    if (texto == 'Ação') {
      argumento = 'ACAO';
    } else if (texto == 'Criptomoeda') {
      argumento = 'CRIPTOMOEDA';
    }
    return argumento;
  }
}
