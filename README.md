# blocify

A library that makes using the BLoC (Business Logic Component) design pattern easier.

## Usage

Full example can be found [here](https://github.com/san-smith/blocify/tree/master/example)

### DataBloc

  ```dart
  import 'package:blocify/blocify.dart';

  ...


  // Create data bloc
  DataBloc<bool> _switchBloc = DataBloc(true);


  // Use data bloc
  Widget _getSwitch() {
    return BlocBuilder<DataBloc<bool>, DataState<bool>>(
      bloc: _switchBloc,
      builder: (context, state) {
        return Switch(
          value: state.data,
          // Update data in state
          onChanged: (value) => _switchBloc.add(
            DataSetEvent(value),
          ),
        );
      },
    );
  }
  ```

### SingleAsyncOpBloc

  ```dart
  import 'package:blocify/blocify.dart';

  ...


  // Create bloc
  SingleAsyncOpBloc<User> _bloc = SingleAsyncOpBloc();

  void _findUser() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      // Send the event with an async request
      _bloc.add(
          SingleAsyncOpRequestEvent(_repository.getUser(_controller.text)));
    }
  }

  // Use bloc
  Widget _getContent() {
    return BlocBuilder<SingleAsyncOpBloc<User>, SingleAsyncOpState<User>>(
      bloc: _bloc,
      builder: (context, state) {
        // Use state for updating UI
        if (state is SingleAsyncOpLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SingleAsyncOpReadyState<User>) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: _getUserInfo(state.data),
          );
        }
        if (state is SingleAsyncOpErrorState) {
          return Center(
            child: Text('''Can't find user "${_controller.text}"'''),
          );
        }
        return Container();
      },
    );
  }
  ```
