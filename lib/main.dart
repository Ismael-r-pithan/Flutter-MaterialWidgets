import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: Colors.deepPurpleAccent,
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.primary
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Editor(controlador: _controladorNumeroConta, rotulo: '0000', dica: 'Numero Conta', icone: null ),
            Editor(controlador: _controladorValor, rotulo: '0.00', dica: 'Valor', icone: Icons.monetization_on),
            ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () {
                _criaTransferencia(context);
              },
            ),
          ],
        ),
      ),
    );
  }



  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
    final double? valor = double.tryParse(_controladorValor.text);
    if(numeroConta != null && valor != null){
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
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


class ListaTransferencias extends StatefulWidget{
  final List<Transferencia> _transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}


class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormularioTransferencia();
        }));
        future.then((transferenciaRecebida) {
          debugPrint('chegou no then do future');
          debugPrint('$transferenciaRecebida');
          if(widget._transferencias != null) {
            widget._transferencias.add(transferenciaRecebida);
          }
        });
      },),
    );
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

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
