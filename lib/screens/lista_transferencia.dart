
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/transferencia.dart';
import 'formulario_transferencia.dart';

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
  final List<Transferencia> transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}




