import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:soccer_app/components/loader_component.dart';
import 'package:soccer_app/helpers/constants.dart';
import 'package:soccer_app/models/data.dart';
import 'package:soccer_app/models/info.dart';
import 'package:soccer_app/models/logos.dart';

import 'leage_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({ Key? key }) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool _showLoader = false;
  bool _showInfo = false;
  bool _showImage = false;

  String _searchInfo = '';

  List<Data> _data = [];
  List<Logos> _logos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showLogo(),
                SizedBox(height: 9,),
                _showImage ? _getListView() : Container(),
                _showLoader ? LoaderComponent(text: 'Cargando...') : Container(),
              ],
            )
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _list(),
        label: const Text('Listar'),
        icon: const Icon(Icons.list),
        backgroundColor: Colors.blue[250], //Colors.blueGrey,
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/soccer-logo.png'),
      width: 250,
    );
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
       message: 'Verifica tu conexión a internet.',
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
   var response = await http.get(
     url,
     headers: {
       'accept': '*/*',
     },
   );
   
   print('primer pausa ${response}');
   
   if(response.statusCode >= 400){
     setState(() {
       _showLoader = false;
     });
   }

   var body = response.body;
   var decodedJson = jsonDecode(body);

   if(decodedJson != null){
     for(var i in decodedJson['data']){
       _data.add(Data.fromJson(i));
     }
     setState(() {
       _showLoader = false;
       _showImage = true;
     });
   }
 }

 Widget _getListView() {
   return Container(
     child: ListView(
       children: _data.map((e) {
         return ListTile(
           onTap: () => _listDetail(e),
           title: Text(e.name),
         );
       }).toList(),
     ),
   );
 }


 void _listDetail(Data e) async{
   String? data = await Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => LeageScreen(
         leage: e,
       )
     ),
   );
 }
}