import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_task_app/Data/Models/Destination.dart';
import 'package:map_task_app/Data/Models/Source.dart';
import 'package:map_task_app/Screens/Widgets/Drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
class homescreen extends StatefulWidget {

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  late final SharedPreferences _prefs;
 late Source _source;
 late Destination _destination;
  var SourceController=TextEditingController();
  var DestintionController=TextEditingController();
  late final GlobalKey<ScaffoldState> _scaffoldKey ;
  num distance=0;
  Future<void> loadpreferences()
  async {
    _prefs= await SharedPreferences.getInstance();
    setState(() {
      DestintionController.text=_prefs.containsKey("destination")?destinationFromJson(_prefs.getString("destination")).name:"";
      SourceController.text= _prefs.containsKey("source")?sourceFromJson(_prefs.getString("source")).name:"";
      _source=sourceFromJson(_prefs.getString("source"));
      _destination=destinationFromJson(_prefs.getString("destination"));
    });
  }

  num Distance(num lat1,num lon1,num lat2,num lon2) {
    var p = math.pi/180 ;
    var a = 0.5 - math.cos((lat2 - lat1) * p)/2 + math.cos(lat1 * p) * math.cos(lat2 * p) * (1 - math.cos((lon2 - lon1)* p))/2;
    return 12742 * math.asin(math.sqrt(a)); // R = 6371 km
  }

//  late GoogleMapController mapController;
//
// LatLng _center= LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadpreferences();
    _scaffoldKey= new GlobalKey<ScaffoldState>();
  }
  @override
  Widget build(BuildContext context) {
   var ScreenSize= MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawerr(),
      body: FutureBuilder(
        future: loadpreferences(),
  builder: (context, state) {
    return Stack(
        children: [
          Container(
            height: ScreenSize.height,
            width: ScreenSize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background5.jpg"),
                fit: BoxFit.cover
              )
            ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80.0),
            child: Container(
              height: 210,
              width: ScreenSize.width,
              decoration: BoxDecoration(
                color: Color(0xFFe5e4e9),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 280,top: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius:22.0 ,
                        child: IconButton(
                          onPressed: () =>_scaffoldKey.currentState!.openDrawer()
                          ,
                          icon:Icon (Icons.menu,color:Color(0xFF979797),),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      height: 50.0,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: SourceController,
                          onTap: (){
                            Navigator.pushNamed(context, "Source");
                          },
                          decoration: InputDecoration(
                            hintText: "Your Location"
                            ,border: InputBorder.none
                            ,hintStyle: TextStyle(
                            color: Color(0xFFcbcbcb),
                            fontSize: 15,
                          ),
                          ),
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      height: 50.0,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)
                        ,
                      ),
                      child: Center(
                        child: TextField(
                          controller: DestintionController,
                          onTap: (){
                                Navigator.pushNamed(context, "Destination");
                          },
                          decoration: InputDecoration(
                            hintText: "Destination",
                            border: InputBorder.none
                            ,hintStyle: TextStyle(
                            color: Color(0xFFcbcbcb),
                            fontSize: 15,
                          ),
                          ),
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    color: Color(0xFF0065b3),
                    borderRadius: BorderRadius.circular(11)
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary:Color(0xFF0065b3),
                  ),
                  onPressed: () async {
                    if(SourceController.text.isEmpty||DestintionController.text.isEmpty)
                      {
                        Get.defaultDialog(title: "Error",content:  Text("Please select source/destination"),
                        onConfirm: (){
                          Get.back();
                            });
                      }
                    else
                      {
                        distance=Distance(_source.latitude, _source.longitude,double.parse(_destination.lat) ,double.parse(_destination.lng));
                        Get.defaultDialog(
                          title: "Calculated",
                          content: Text("Distance is ${distance.toStringAsFixed(3)} ${distance.isGreaterThan(1)?"Km":"m"}")
                           , onConfirm:(){
                            Get.back();
                        }
                        );
                      }
                  },
                  child:Text("REQUEST RD",style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  },
),
    );
  }
}
