import 'package:bloc/bloc.dart';
import 'package:coinedone/repository/dataRepository.dart';

import 'dataEvent.dart';
import 'dataState.dart';
import 'package:coinedone/models/data.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataRepository repository;

  DataBloc({this.repository}) : super(null);

  @override
  DataState get initialState => DataInitialState();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      yield DataLoadingState();
      try {
        Data data = await repository.getData();
        print(data);
        yield DataLoadedState(data: data);
      } catch (e) {
        yield DataErrorState(message: e.toString());
      }
    }
  }
}
