import 'package:calculoIMC/pessoa.dart';
import 'package:flutter/material.dart';
import 'database_Helper.dart';

class PessoaScreen extends StatefulWidget {
  final Pessoa pessoa;
  PessoaScreen(this.pessoa);
  @override
  State<StatefulWidget> createState() => new _PessoaScreenState();
}

class _PessoaScreenState extends State<PessoaScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _pesoController;
  TextEditingController _alturaController;
  TextEditingController _imcController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.pessoa.nome);
    _pesoController = new TextEditingController(text: widget.pessoa.peso.toString());
    _alturaController = new TextEditingController(text: widget.pessoa.altura.toString());
    _imcController = new TextEditingController(text: widget.pessoa.imc.toString());
  }

  var imc = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pessoa')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children:[
            Image.asset('images/imc.png'),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'altura'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _imcController,
              decoration: InputDecoration(labelText: 'imc'),
              readOnly: true,
              enabled: false,
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
                child: (widget.pessoa.id != null) ? Text('Alterar') : Text('Inserir'),
                onPressed: () {
                  if (widget.pessoa.id != null) {
                    db.updatePessoa(Pessoa.fromMap({
                      'id': widget.pessoa.id,
                      'nome': _nomeController.text,
                      'peso': double.parse(_pesoController.text),
                      'altura': double.parse(_alturaController.text),
                      'imc': double.parse(_imcController.text)
                    })).then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db.inserirPessoa(Pessoa(_nomeController.text, double.parse(_pesoController.text), double.parse(_alturaController.text), double.parse(_pesoController.text)/(double.parse(_alturaController.text)*double.parse(_alturaController.text))))
                        .then((_) {
                          Navigator.pop(context, 'save');
                        });
                    }
                },
            ),
          ],
        ),
      ),
    );
  }
}



