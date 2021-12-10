part of 'source_cubit.dart';

@immutable
abstract class SourceState {}

class SourceInitial extends SourceState {}
class SourceLoaded extends SourceState{
  final List<Source>places;

  SourceLoaded(this.places);
}