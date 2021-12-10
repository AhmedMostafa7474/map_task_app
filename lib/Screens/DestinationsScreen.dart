import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:map_task_app/Bloc_Layer/destination_cubit.dart';
import 'package:map_task_app/Bloc_Layer/source_cubit.dart';
import 'package:map_task_app/Data/Models/Destination.dart';
import 'package:map_task_app/Data/Models/Source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class destintionsScreen extends StatefulWidget {
  @override
  _destintionsScreenState createState() => _destintionsScreenState();
}

class _destintionsScreenState extends State<destintionsScreen> {
  late final SharedPreferences _prefs;
  var Url =
      "https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json";
  List<Destination> _destinations = [];
  static List<Destination> searchedDestination = [];
  List<Destination>Current=[];
  var searchtextController = TextEditingController();
  bool isSearch = false;
  ScrollController _scrollController = ScrollController();
  var _isLoad = false;
  bool isLoading = false;
  List<int> data = [];
  int currentLength = 0;

  final int increment = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DestinationCubit>(context).GetAllPlaces(Url);
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _isLoad = true;
        });
      }
    });
  }

  @override
  void dispose() {
    BlocProvider.of<DestinationCubit>(context).close();
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
        body: BlocBuilder<DestinationCubit, DestinationState>(
                builder: (context, state) {
                  if (state is DestinationLoaded) {
                    _destinations = (state).places;
                    searchedDestination.isNotEmpty?Current=searchedDestination:Current=_destinations;
                    return  ListView.builder(
                        controller: _scrollController,
                        itemCount: Current.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              _prefs = await SharedPreferences.getInstance();
                              await _prefs.setString("destination",
                                  destinationToJson(Current[index]));
                              Navigator.pushNamed(context, "/");
                            },
                            child: ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Current[index].name,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    Current[index].country,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  )
                                ],
                              ),
                              title: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.my_location_outlined,
                                    color: Colors.blue,
                                  )),
                            ),
                          );
                        },
                    );
                  } else {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.grey,
                        size: 100,
                      ),
                    );
                  }
                },
              )
            );
  }

  AppBar _appbar() {
    return isSearch
        ? AppBar(
            title: searchField(),
            actions: [
              IconButton(
                icon: Icon(Icons.clear, color: Colors.white, size: 20),
                onPressed: () {
                  setState(() {
                    searchtextController.clear();
                    searchedDestination.clear();
                    print(isSearch);
                    isSearch = false;
                  });
                },
              )
            ],
          )
        : AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Places",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    print(isSearch);
                    isSearch = true;
                  });
                },
              )
            ],
          );
  }

  Widget searchField() {
    return TextField(
      controller: searchtextController,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: "Find a Place",
        border: InputBorder.none,
      ),
      style: TextStyle(color: Colors.white, fontSize: 18),
      onChanged: (searchtext) {
        setState(() {
          searchedDestination = _destinations
              .where((destination) => destination.name
                  .toLowerCase()
                  .startsWith(searchtext.toLowerCase()))
              .toList();
        });
      },
    );
  }
}
