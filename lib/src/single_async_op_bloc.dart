import 'package:bloc/bloc.dart';

class SingleAsyncOpBloc<T>
    extends Bloc<SingleAsyncOpEvent<T>, SingleAsyncOpState<T>> {
  @override
  SingleAsyncOpState<T> get initialState => SingleAsyncOpInitialState<T>();

  @override
  Stream<SingleAsyncOpState<T>> mapEventToState(SingleAsyncOpEvent event) async* {
    if (event is SingleAsyncOpRequestEvent<T>) {
      yield* _mapRequestToState(event.request);
    }
  }

  Stream<SingleAsyncOpState<T>> _mapRequestToState(Future<T> request) async* {
    yield SingleAsyncOpLoadingState<T>();
    try {
      var data = await request;
      yield SingleAsyncOpReadyState(data);
    } catch (e) {
      yield SingleAsyncOpErrorState(e);
    }
  }
}

/// states

abstract class SingleAsyncOpState<T> {}

class SingleAsyncOpInitialState<T> extends SingleAsyncOpState<T> {}

class SingleAsyncOpLoadingState<T> extends SingleAsyncOpState<T> {}

class SingleAsyncOpReadyState<T> extends SingleAsyncOpState<T> {
  /// The current [data] in the [State] is response that returned the request.
  final T data;

  SingleAsyncOpReadyState(this.data);
}

class SingleAsyncOpErrorState<T> extends SingleAsyncOpState<T> {
  final dynamic error;

  SingleAsyncOpErrorState(this.error);
}

/// events

abstract class SingleAsyncOpEvent<T> {}

class SingleAsyncOpRequestEvent<T> extends SingleAsyncOpEvent<T> {
  /// Request that will be executed.
  final Future<T> request;

  SingleAsyncOpRequestEvent(this.request);
}
