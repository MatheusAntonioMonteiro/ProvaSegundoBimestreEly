class Pessoa {
  int _id;  
  String _nome;
  double _peso;
  double _altura;
  double _imc;

  Pessoa(this._nome, this._peso, this._altura, this._imc);

  Pessoa.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._peso = obj['peso'];
    this._altura = obj['altura'];
    this._imc = obj['imc'];
  }

  int get id => _id;
  String get nome => _nome;
  double get peso => _peso;
  double get altura => _altura;
  double get imc => _imc;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['peso'] = _peso;
    map['altura'] = _altura;
    map['imc'] = _imc;

    return map;
  }

  Pessoa.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._peso = map['peso'];
    this._altura = map['altura'];
    this._imc = map['imc'];
  }
}