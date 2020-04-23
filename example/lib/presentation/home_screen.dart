import 'package:example/presentation/data_bloc_example.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('DataBloc example'),
              onPressed: _goToDataBlocExample,
            ),
          ],
        ),
      ),
    );
  }

  void _goToDataBlocExample() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DataBlocExample(),
      ),
    );
  }
}
