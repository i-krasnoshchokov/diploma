import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBikeRoadsView extends StatefulWidget {

  MapBikeRoadsView({Key key}) : super(key: key);

  @override
  _MapBikeRoadsViewState createState() => _MapBikeRoadsViewState();
}

class _MapBikeRoadsViewState extends State<MapBikeRoadsView> {

  Set<Polyline> _polylines = HashSet<Polyline>();

  GoogleMapController _mapController;
  bool _showMapStyle = false;

  @override
  void initState() {
    super.initState();
    _setPolylines();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _toggleMapStyle();
  }

  void _setPolylines() {

    //Tupoleva str
    // ignore: deprecated_member_use
    List<LatLng> street1 = List<LatLng>();
    street1.add(LatLng(50.485346, 30.395709));
    street1.add(LatLng(50.458858, 30.396020));


    //Peremohy avn 1
    // ignore: deprecated_member_use
    List<LatLng> street2s1 = List<LatLng>();
    street2s1.add(LatLng(50.455478, 30.359410));
    street2s1.add(LatLng(50.457199, 30.385186));

    //Peremohy avn 2
    // ignore: deprecated_member_use
    List<LatLng> street2s2 = List<LatLng>();
    street2s2.add(LatLng(50.457719, 30.393071));
    street2s2.add(LatLng(50.458204, 30.400024));
    street2s2.add(LatLng(50.458820, 30.410453));

    //Peremohy avn 3
    // ignore: deprecated_member_use
    List<LatLng> street2s3 = List<LatLng>();
    street2s3.add(LatLng(50.457113, 30.429400));
    street2s3.add(LatLng(50.455639, 30.438490));

    //Peremohy avn 4
    // ignore: deprecated_member_use
    List<LatLng> street2s4 = List<LatLng>();
    street2s4.add(LatLng(50.455491, 30.439353));
    street2s4.add(LatLng(50.454458, 30.445734));

    //Peremohy avn 5
    // ignore: deprecated_member_use
    List<LatLng> street2s5 = List<LatLng>();
    street2s5.add(LatLng(50.454070, 30.448133));
    street2s5.add(LatLng(50.453166, 30.453576));
    street2s5.add(LatLng(50.453014, 30.453780));
    street2s5.add(LatLng(50.451145, 30.465363));
    street2s5.add(LatLng(50.451177, 30.465732));

    //Peremohy avn 6
    // ignore: deprecated_member_use
    List<LatLng> street2s6 = List<LatLng>();
    street2s6.add(LatLng(50.450860, 30.467635));
    street2s6.add(LatLng(50.450611, 30.469135));
    street2s6.add(LatLng(50.450396, 30.469390));
    street2s6.add(LatLng(50.449509, 30.474796));
    street2s6.add(LatLng(50.449611, 30.475211));
    street2s6.add(LatLng(50.448812, 30.479879));


    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: street1,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("1"),
        points: street2s1,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("2"),
        points: street2s2,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("2"),
        points: street2s3,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("2"),
        points: street2s4,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("2"),
        points: street2s5,
        color: Colors.purple,
        width: 3,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId("2"),
        points: street2s6,
        color: Colors.purple,
        width: 3,
      ),
    );
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    _mapController.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Text('bike map', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200, color: Colors.black)),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.453261, 30.528935),
              zoom: 12,
            ),
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
