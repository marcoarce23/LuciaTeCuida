import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPositionModule extends StatefulWidget {
  MapPositionModule({Key key}) : super(key: key);

  @override
  _MapPositionModuleState createState() => _MapPositionModuleState();
}

class _MapPositionModuleState extends State<MapPositionModule> {
   BitmapDescriptor customIcon;
  Set<Marker> markers;
  @override
  void initState() {
    super.initState();
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
       );
  }
}
