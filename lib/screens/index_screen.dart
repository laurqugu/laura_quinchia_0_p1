import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:soccer_app/components/loader_component.dart';
import 'package:soccer_app/helpers/constants.dart';
import 'package:soccer_app/models/data.dart';

import 'leage_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({ Key? key }) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool _showLoader = false;
  bool _showInfo = false;
  bool _showList = false;
  String _searchInfo = '';

  List<Data> _data = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Soccer'),
        actions: <Widget>[
          _showInfo
          ? IconButton(
              onPressed: _return, 
              icon: Icon(Icons.filter_none)
            )
          : IconButton(
              onPressed: _showInfoLeage, 
              icon: Icon(Icons.filter_alt)
            )
        ],
        ),
        body: Stack(
          children: [
            _showLogo(),
            _showList ? _getList() : Container(),
            _showLoader ? LoaderComponent(text: 'Cargando...'): Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _list(),
        label: const Text('Listar'),
        icon: const Icon(Icons.list),
        backgroundColor: Colors.blueGrey,
      ),
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/soccer-logo.png'),
      width: 250,
    );
  }

  Widget _getList() {
    return Container(
      child: ListView(
        children: _data.map((e) {
          return ListTile(
            onTap: () => _details(e),
            leading: Image.network(e.logos.dark),
              title: Text(e.name),
          );
        }).toList(),
      ),
    );
  }

  void _return(){
    setState(() {
      _showInfo = false;
    });
    _list();
  }

 void _list() async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        _showLoader = false;
      });

      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse('${Constants.apiUrl}');
    var response = await http.get(url);

    print(response);

    if(response.statusCode >= 400){
      print(response);
      setState(() {
        _showLoader = false;
      });
      return;
    }

    var body = response.body;
    var decodedJson = jsonDecode(body);

    if(decodedJson != null){
        for (var i in decodedJson['results']) {
          _data.add(Data.fromJson(i));
        }
      }
      setState(() {
        _showLoader = false;
        _showList = true;
      });
  }

  void _showInfoLeage() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba el criterio de búsqueda'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  _searchInfo = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _leage(), 
              child: Text('Filtrar')
            ),
          ],
        );
      }
    );
  }

  void _leage() {
    print(_searchInfo);
      if (_searchInfo.isEmpty) {
        return;
      }
      List<Data> filteredList = [];
      for (var data in _data) {
        if (data.name.toLowerCase().contains(_searchInfo.toLowerCase())) {
          filteredList.add(data);
        }
      }

      
      setState(() {
        _data = filteredList;
        _showInfo = true;
      });

      Navigator.of(context).pop();
  }

  void _details(Data e) async{
    String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LeageScreen (
          leage : e,
        )
      )
    );
    if (result == 'yes') {
      _list();
    }
  }
}