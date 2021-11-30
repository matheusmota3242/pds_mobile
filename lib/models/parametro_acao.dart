class ParametroAcao {
  late int _id;
  late String _tiquete;
  late double _valor;
  late String _token;

  toJson() => {'tiquete': _tiquete, 'valor': _valor, 'token': _token};

  get id => _id;
  set id(value) => _id = value;

  get tiquete => _tiquete;
  set tiquete(tiquete) => _tiquete = tiquete;

  get valor => _valor;
  set valor(value) => _valor = value;

  get token => _token;
  set token(value) => _token = value;
}
