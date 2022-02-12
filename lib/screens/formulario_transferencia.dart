import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/editor.dart';
import '../main.dart';
import '../models/transferencia.dart';
import 'lista_transferencia.dart';


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

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget.transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget.transferencias[indice];
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
          if(widget.transferencias != null) {
            widget.transferencias.add(transferenciaRecebida);
          }
        });
      },),
    );
  }
}
