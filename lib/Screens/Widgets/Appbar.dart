import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_task_app/Data/Models/Destination.dart';
class appbarr extends StatefulWidget implements  PreferredSizeWidget {
  bool isSearch;
  List<Destination> destinations;
  List<Destination> searchedDestination;
  TextEditingController searchtextController;

  appbarr(this.isSearch, this.destinations,
      this.searchedDestination, this.searchtextController);


  @override
  _appbarrState createState() => _appbarrState(this.isSearch, this.destinations,
  this.searchedDestination, this.searchtextController);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _appbarrState extends State<appbarr> {
  bool isSearch;
  List<Destination> destinations;
  List<Destination> searchedDestination;
  TextEditingController searchtextController;

  _appbarrState(this.isSearch, this.destinations,
      this.searchedDestination, this.searchtextController);

  @override
  Widget build(BuildContext context) {
  return  isSearch?  AppBar(
        title: searchField(searchtextController,searchedDestination,destinations),
    actions: [
    IconButton(
    icon: Icon(Icons.clear, color: Colors.white, size: 20), onPressed: () {
    setState(() {
    searchtextController.clear();
    searchedDestination.clear();
    print(isSearch);
    isSearch = false;
    });
    },)
    ],
    ) :
     AppBar(
      backgroundColor: Colors.black,
      title: Text(
        "Places",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(icon: Icon(Icons.search, color: Colors.white, size: 20,),
          onPressed: () {
            setState(() {
              print(isSearch);
              isSearch = true;
            });
          },)
      ],
    );
  }
Widget searchField(TextEditingController searchtextController, List<Destination> searchedDestination, List<Destination> destinations)
{
  return TextField(
    controller: searchtextController,
    cursorColor: Colors.grey,
    decoration: InputDecoration(
      hintText: "Find a Place"
      ,border: InputBorder.none,
    ),
    style: TextStyle(
        color: Colors.white ,fontSize: 18
    ),
    onChanged: (searchtext){
      setState(() {
        searchedDestination=destinations.where((destination) => destination.name.toLowerCase().startsWith(searchtext.toLowerCase())).toList();
      });
    },
  );
}
}