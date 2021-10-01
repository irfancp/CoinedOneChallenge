import 'package:coinedone/models/data.dart';
import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {}

class DataInitialState extends DataState {
  @override
  List<Object> get props => [];
}

class DataLoadingState extends DataState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DataLoadedState extends DataState {

  Data data;

  DataLoadedState({this.data});

  @override
  List<Object> get props => [Data];
}

class DataErrorState extends DataState {

  String message;

  DataErrorState({this.message});

  @override
  List<Object> get props => [message];
}