import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:map_task_app/Bloc_Layer/source_cubit.dart';
import 'package:map_task_app/Data/Models/Source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sourcescreen extends StatefulWidget {
  @override
  _sourcescreenState createState() => _sourcescreenState();
}

class _sourcescreenState extends State<sourcescreen> {
  late final SharedPreferences _prefs;
  static List<Source> searched_sources = [];
  List<Source>Current=[];
  List<Source> _sources = [];
  var searchtextController = TextEditingController();
  bool isSearch = false;
  ScrollController _scrollController = ScrollController();
  var _isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     BlocProvider.of<SourceCubit>(context).GetFirstPlaces();
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _sources.addAll(
            await BlocProvider.of<SourceCubit>(context).GetNextPlaces());
        setState(() {
          _isLoad = true;
        });
      }
    });
  }

  @override
  void dispose() {
    BlocProvider.of<SourceCubit>(context).close();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: BlocBuilder<SourceCubit, SourceState>(
        builder: (context, state) {
          if (state is SourceLoaded) {
            _sources = (state).places;
            searched_sources.isNotEmpty?Current=searched_sources:Current=_sources;
            return ListView.builder(
                controller: _scrollController,
                itemCount:
                _isLoad ? _sources.length + 1 : Current.length,
                itemBuilder: (BuildContext context, int index) {
                  return index == _sources.length
                      ? Center(child: CircularProgressIndicator())
                      : InkWell(
                    onTap: () async {
                      _prefs =
                      await SharedPreferences.getInstance();
                      await _prefs.setString("source",
                          sourceToJson(Current[index]));
                      Navigator.pushNamed(context, "/");
                    },
                    child: ListTile(
                      leading: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            Current[index].name,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
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
                });
          } else {
            return Center(
              child: SpinKitCircle(
                color: Colors.grey,
                size: 100,
              ),
            );
          }
        },
      ),
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
              searched_sources.clear();
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
          _isLoad=false;
          searched_sources = _sources
              .where((destination) => destination.name
              .toLowerCase()
              .startsWith(searchtext.toLowerCase()))
              .toList();
        });
      },
    );
  }
}

