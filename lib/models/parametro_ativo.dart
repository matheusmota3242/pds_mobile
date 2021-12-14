class ParametroAtivo {
  late int _id;
  late String _simbolo;
  late double _valor;
  late String _token;
  late String _tipoAtivo;

  Map<String, dynamic> toJson() => {
        'simbolo': _simbolo,
        'valor': _valor,
        'token': _token,
        'tipoAtivo': _tipoAtivo
      };

  ParametroAtivo();

  ParametroAtivo.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _simbolo = json['simbolo'],
        _valor = json['valor'],
        _tipoAtivo = json['tipoAtivo'];

  get id => _id;
  set id(value) => _id = value;

  get simbolo => _simbolo;
  set simbolo(simbolo) => _simbolo = simbolo;

  get valor => _valor;
  set valor(value) => _valor = value;

  get token => _token;
  set token(value) => _token = value;

  get tipoAtivo => _tipoAtivo;
  set tipoAtivo(tipoAtivo) => _tipoAtivo = tipoAtivo;
}
