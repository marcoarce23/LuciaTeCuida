import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:luciatecuida/src/Util/Util.dart';


class MapModule extends StatefulWidget {
  @override
  State<MapModule> createState() => MapModuleState();
}

class MapModuleState extends State<MapModule> {
  List<Marker> allMarkers = [];
  GoogleMapController _controller;
  final Location location = Location();
  LatLng latlng;

  @override
  void initState() {
    super.initState();
    _crearMark();
  }

  _crearMark() {
    allMarkers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        icon: BitmapDescriptor.defaultMarker,

        draggable: true,
        onTap: () {
          //  //print('Es mica saaa: ${_location.latitude} -- ${_location.longitude}');
          Text('Es pararaaa');
        },
        position: LatLng(-18.5115,
            -68.1239), //LatLng(_location.latitude, _location.longitude),
        infoWindow: InfoWindow(
          title: 'Dejame Apoyarte',
          snippet: 'Mpedrooz',
        ),
      ),
    );
    allMarkers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        icon: BitmapDescriptor.defaultMarker,

        draggable: false,
        onTap: () {
          //  //print('Es mica saaa: ${_location.latitude} -- ${_location.longitude}');
          Text('Es pararaaaa');
        },
        position: LatLng(-18.5115,
            -68.1239), // LatLng(_location.latitude, _location.longitude),
        infoWindow: InfoWindow(
          title: 'Dejame Apoyarte',
          snippet: 'Marco Arcezz',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas COVID'),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(-18.5115, -68.1239), zoom: 12.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: getLocation,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green),
              child: Icon(Icons.forward, color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: movetoNewYork,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0), color: Colors.red),
              child: Icon(Icons.backspace, color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      // _crearMark();
    });
  }

  movetoBoston() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(-16.5115, -68.1239),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
  }

  movetoNewYork() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(-16.5115, -67.1239), zoom: 12.0),
    ));
  }
}

//  Future<LatLng> _getLocationI() async {
//    LocationData _location;
//     setState(() {
//      // _error = null;
//     });
//     try {
//       final LocationData _locationResult = await location.getLocation();
//       setState(() {
//         _location = _locationResult;
//         //print('Es mica saaa: ${_location.latitude} -- ${_location.longitude}');
//         latlng = LatLng(_location.latitude, _location.longitude);
//       });
//     }  catch (err) {
//       setState(() {
//        // _error = err.code;
//       });
//     }

//     return LatLng(_location.latitude, _location.longitude);
//  }
