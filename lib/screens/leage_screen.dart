import 'package:flutter/material.dart';
import 'package:soccer_app/components/loader_component.dart';
import 'package:soccer_app/models/data.dart';


class LeageScreen extends StatefulWidget {
  final Data leage;

  LeageScreen({required this.leage});

  @override
  _LeageScreenState createState() => _LeageScreenState();
}

class _LeageScreenState extends State<LeageScreen> {
  late Data _leage;
  bool _showLoader = true;
  late ScrollController _controller;


  @override
  void initState() {
    super.initState();
    _leage = widget.leage;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);//the listener for up and down. 
 super.initState();
 _showLoader = false;
  }

  _scrollListener() {
  if (_controller.offset >= _controller.position.maxScrollExtent &&
     !_controller.position.outOfRange) {
   setState(() {//you can do anything here
   });
 }
 if (_controller.offset <= _controller.position.minScrollExtent &&
    !_controller.position.outOfRange) {
   setState(() {//you can do anything here
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Center(child: Text(_leage.name)),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _showLeages(),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Lista de ligas', style: TextStyle(fontSize: 30)),
                  ),
                  _listLeages(),
              ],),
              ),
              _showLoader ? LoaderComponent(text: 'Cargando...',) : Container(),
          ],
        ),
      ),
      );
  }

  Widget _showLeages() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'ligas ${widget.leage.id}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.logos}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            'leage ${widget.leage.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _listLeages() {
    return ListView(
      
    );
  }
}