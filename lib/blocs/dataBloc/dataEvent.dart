import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable{}

class FetchDataEvent extends DataEvent {
  @override
  List<Object> get props => null;
}