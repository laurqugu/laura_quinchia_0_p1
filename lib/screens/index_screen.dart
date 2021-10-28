import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({ Key? key }) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showLogo(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/soccer-logo.png'),
      width: 250,
    );
  }
}