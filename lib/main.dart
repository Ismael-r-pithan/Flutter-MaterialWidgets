import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: <Widget>[
        Editor(controlador: _controladorNumeroConta, rotulo: '0000', dica: 'Numero Conta', icone: Icons.account_balance ),
          Editor(controlador: _controladorValor, rotulo: '0.00', dica: 'Valor', icone: Icons.monetization_on),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _criaTransferencia();
            },
          ),
        ],
      ),
    );
  }



  void _criaTransferencia() {
    final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
    final double? valor = double.tryParse(_controladorValor.text);
    if(numeroConta != null && valor != null){
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
    }
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}


class ListaTransferencias extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(children: <Widget>[
        ItemTransferencia(Transferencia(100.0, 1000)),
        ItemTransferencia(Transferencia(200.0, 2000)),
        ItemTransferencia(Transferencia(300.0, 3000)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({required this.controlador, required this.rotulo, required this.dica, required this.icone});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
