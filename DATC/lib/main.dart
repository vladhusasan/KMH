
import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'API_conector_user.dart';
import 'Login.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class DrawerItem {
  String title;
  IconData icon;
  Function body;
  DrawerItem(this.title, this.icon, this.body);
}

class MyHomePage extends StatefulWidget {
  final User user;
  MyHomePage({Key key,this.user}) : super(key: key);
  final drawerScreens = [
    new DrawerItem("Acasa", Icons.account_circle, () => new MyHomePage()),
    new DrawerItem("Alerta", Icons.search,() => new MyHomePage()),
  ];
  @override
  _MyHomePageState createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<MyHomePage> {
  User user= new User();
  _MyHomePageState(this.user);


  _onSelectScreen(int index) {
    if (widget.drawerScreens[index] != null) {
      Navigator.of(context).pop(); // close drawer
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => widget.drawerScreens[index].body())
      );
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  LatLng _center ;
  final Set<Marker> _markers = {};
  @override
  void initState(){
    super.initState();
    _getUserLocation();
    Server.fetchUser("a","a");
  }
  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
  }
  LatLng _lastMapPosition;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
      var d = widget.drawerScreens;
      for (var i = 0; i < d.length; i++) {

        drawerOptions.add(
            new ListTile(
              leading: new Icon(d[i].icon),
              title: new Text(d[i].title),
              onTap: () => _onSelectScreen(i),
            )
        );

      }

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
      ),
      drawer: new SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: new Drawer(
          child:  SingleChildScrollView(child:
          new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(decoration: new BoxDecoration(color: Color.fromARGB(255,33, 156, 210,),),accountName: new Text("Andrei "), accountEmail: new Text("@"),),
              new Column(children: drawerOptions)
            ],
          )
          ),
        ),
      ),
      body: _center == null ? Container(child: Center(child:Text('loading map..', style: TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),),),) : Container(
        child:Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled:false,

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget> [
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }

}
