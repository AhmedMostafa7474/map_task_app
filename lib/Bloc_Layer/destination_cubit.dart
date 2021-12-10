import 'package:bloc/bloc.dart';
import 'package:map_task_app/Data/Models/Destination.dart';
import 'package:map_task_app/Data/Repo/Destination_Repo.dart';
import 'package:meta/meta.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
 final Destination_Repo _destination_repo;
 List<Destination> _destination=[];
  DestinationCubit(this._destination_repo) : super(DestinationInitial());
  Future <List<Destination>>GetAllPlaces(String Url)
 async {
   _destination=await _destination_repo.GetAllPlaces(Url);
   emit(DestinationLoaded(_destination));
   return _destination;
 }
}
