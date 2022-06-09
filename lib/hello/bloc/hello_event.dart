part of 'hello_bloc.dart';

@immutable
abstract class HelloEvent extends Equatable {}

class HelloNameRequested extends HelloEvent {
  HelloNameRequested();
  @override
  List<Object?> get props => [];
}

class HelloRandomNameSet extends HelloEvent {
  HelloRandomNameSet();

  @override
  List<Object?> get props => [];
}
