part of 'destination_cubit.dart';

@immutable
abstract class DestinationState {}

class DestinationInitial extends DestinationState {}
class DestinationLoaded extends DestinationState
{
  final List<Destination> places;
  DestinationLoaded(this.places);
}