import 'package:bloc/bloc.dart';

class DataBloc<T> extends Bloc<DataEvent<T>, DataState<T>> {
  /// Initial [data] to be placed in the [State]
  final T initialData;

  DataBloc(this.initialData);

  @override
  DataState<T> get initialState => DataState<T>(initialData);

  @override
  Stream<DataState<T>> mapEventToState(DataEvent<T> event) async* {
    if (event is DataSetEvent<T>) {
      yield DataState<T>(event.data);
    }
  }
}

class DataState<T> {
  /// The current [data] in the [State]
  final T data;

  DataState(this.data);
}

abstract class DataEvent<T> {}

class DataSetEvent<T> extends DataEvent<T> {
  /// New [data] to be placed in the [State]
  final T data;

  DataSetEvent(this.data);
}
