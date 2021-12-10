import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_task_app/Bloc_Layer/destination_cubit.dart';
import 'package:map_task_app/Bloc_Layer/source_cubit.dart';
import 'package:map_task_app/Data/Repo/Destination_Repo.dart';
import 'package:map_task_app/Data/Repo/Source_Repo.dart';
import 'package:map_task_app/Data/Web_Services/Destination_web_services.dart';
import 'package:map_task_app/Data/Web_Services/Source_web_services.dart';
import 'package:map_task_app/Screens/DestinationsScreen.dart';
import 'package:map_task_app/Screens/HomeScreen.dart';
import 'package:map_task_app/Screens/SourceScreen.dart';

class AppRouter {
  late Destination_Repo _destination_repo;
  late DestinationCubit _destinationCubit;
  late Source_Repo _source_repo;
  late SourceCubit _sourceCubit;

  AppRouter() {
    _destination_repo = Destination_Repo(Destination_web_services());
    _destinationCubit = DestinationCubit(_destination_repo);
    _source_repo=Source_Repo(Source_web_services());
    _sourceCubit=SourceCubit(_source_repo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/':
        return MaterialPageRoute(
          builder: (_) =>  homescreen(),
        );
      case "Destination":
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (BuildContext context) => _destinationCubit,
                  child: destintionsScreen()),
        );
      case "Source":
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (BuildContext context) => _sourceCubit,
                  child: sourcescreen()),
        );
    }
  }
}
