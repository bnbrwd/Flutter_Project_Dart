part of 'wethr_bloc.dart';

abstract class WethrState extends Equatable {
  const WethrState();
  
  @override
  List<Object> get props => [];
}

class WethrInitial extends WethrState {}
