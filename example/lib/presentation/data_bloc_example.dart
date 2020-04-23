import 'package:blocify/blocify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataBlocExample extends StatefulWidget {
  @override
  _DataBlocExampleState createState() => _DataBlocExampleState();
}

class _DataBlocExampleState extends State<DataBlocExample> {
  DataBloc<int> _counterBloc = DataBloc(0);
  DataBloc<bool> _switchBloc = DataBloc(true);

  void _incrementCounter() {
    _counterBloc.add(
      DataSetEvent(_counterBloc.state.data + 1),
    );
  }

  @override
  void dispose() {
    _counterBloc.close();
    _switchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataBloc example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            _getCounter(),
            SizedBox(height: 50),
            Text('Can you add something?'),
            _getSwitch(),
          ],
        ),
      ),
      floatingActionButton: _getFloatingButton(),
    );
  }

  Widget _getCounter() {
    return BlocBuilder<DataBloc<int>, DataState<int>>(
      bloc: _counterBloc,
      builder: (context, state) {
        return Text(
          '${state.data}',
          style: Theme.of(context).textTheme.display1,
        );
      },
    );
  }

  Widget _getSwitch() {
    return BlocBuilder<DataBloc<bool>, DataState<bool>>(
      bloc: _switchBloc,
      builder: (context, state) {
        return Switch(
          value: state.data,
          onChanged: (value) => _switchBloc.add(
            DataSetEvent(value),
          ),
        );
      },
    );
  }

  Widget _getFloatingButton() {
    return BlocBuilder<DataBloc<bool>, DataState<bool>>(
      bloc: _switchBloc,
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: state.data ? _incrementCounter : null,
          disabledElevation: 1,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        );
      },
    );
  }
}
