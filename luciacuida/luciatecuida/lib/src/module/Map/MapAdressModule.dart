
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:luciatecuida/src/Model/PreferenceUser.dart';
import 'package:luciatecuida/src/module/HomePage/HomePageModule.dart';

class MapAdressModule extends StatefulWidget {
  static final String routeName = 'mapAtencion';
  MapAdressModule({Key key}) : super(key: key);

  @override
  _MapAdressModuleState createState() => _MapAdressModuleState();
}

class _MapAdressModuleState extends State<MapAdressModule> {
   final prefs = new PreferensUser();
   
   GoogleMapController mapController;

  String buscarDireccion;
 List<Marker> allMarkers = [];
   BitmapDescriptor customIcon;
     Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = MapAdressModule.routeName;
  //  _crearMark();
    markers = Set.from([]);
  }


  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/fd.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
       body: Stack(
         children: <Widget>[
            Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(-16.5132967736163, -68.12992248684166), zoom: 11.0),
          markers: markers,
            mapType: MapType.hybrid,
              onTap: (pos) {
                //print(pos);
                Marker m = Marker(
                  markerId: MarkerId('1'),
                  draggable: true,
                  icon:  BitmapDescriptor.defaultMarker,//customIcon,
                  position: pos,
                  infoWindow: InfoWindow(
                    title: 'Dejame Apoyarte',
                    snippet: 'Mpedrooz',
                  ),
                );
                setState(() {
                  //print('valor mmm: $m');
                  markers.add(m);
                
                 //   Navigator.of(context).pop();
                   
                });
              },
            onMapCreated: onMapCreated,
          ),
        ),
                        Positioned(
                          top: 30.0,
                          right: 15.0,
                          left: 15.0,
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ingrese Direccion a Buscar',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: barraBusqueda,
                                    iconSize: 30.0,
                                  )
                                ),                                
                              ),
                              onChanged: (val) {
                                setState(() {
                                 buscarDireccion = val; 
                                });
                              }
                            ),
                          ),
                        )
                      ],
                    ),
                     drawer: DrawerCitizen(),
  
                 );
               }


          //Funcion que creamos para busqueda por direccion
          barraBusqueda() {
            Geolocator().placemarkFromAddress(buscarDireccion).then((result) {
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target:
                      LatLng(result[0].position.latitude, result[0].position.longitude),
                  zoom: 10.0)));
            });
          }
             
               void onMapCreated(controller) {
                 setState(() {
                  mapController = controller; 
                 });
  }
}