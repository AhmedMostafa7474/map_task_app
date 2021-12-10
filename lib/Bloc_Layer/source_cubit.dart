import 'package:bloc/bloc.dart';
import 'package:map_task_app/Data/Models/Source.dart';
import 'package:map_task_app/Data/Repo/Source_Repo.dart';
import 'package:meta/meta.dart';

part 'source_state.dart';

class SourceCubit extends Cubit<SourceState> {
 final Source_Repo _source_repo;
 List<Source> _sources=[];
  SourceCubit(this._source_repo) : super(SourceInitial());
  Future <List<Source>>GetFirstPlaces()async
  {
    _sources=await _source_repo.GetFirstPlaces();
    emit(SourceLoaded(_sources));
    return _sources;
  }
 Future <List<Source>>GetNextPlaces()async
 {
   _sources=await _source_repo.GetNextPlaces();
   return _sources;
 }
}
