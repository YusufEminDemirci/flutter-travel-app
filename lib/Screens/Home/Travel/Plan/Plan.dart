import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/place.dart';
import '../../../../Utils/TextStyles.dart';
import '../../../../Utils/consts.dart';
import 'Comment/Comment.dart';

class Plan extends StatefulWidget {
  final List selectedPlaces;
  final String cityId;
  final TravelMode travelMode;

  Plan(
    this.selectedPlaces,
    this.cityId,
    this.travelMode,
  );
  @override
  _PlanState createState() => _PlanState(
        this.selectedPlaces,
        this.cityId,
        this.travelMode,
      );
}

String userMail;

class _PlanState extends State<Plan> with SingleTickerProviderStateMixin {
  List<PlaceModel> selectedPlaces;
  String cityId;
  TravelMode travelMode;

  _PlanState(
    this.selectedPlaces,
    this.cityId,
    this.travelMode,
  );

  GoogleMapController _controller;
  List<Marker> markerList = [];
  Position _currentPosition;

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Trying to detect your location"),
            backgroundColor: Colors.amberAccent,
          ),
        );
        _currentPosition = position;
        selectedPlaces.add(
          PlaceModel(
            "0",
            "",
            "Current Position",
            "",
            "",
            "",
            "",
            "",
            _currentPosition.latitude.toString(),
            _currentPosition.longitude.toString(),
            [],
            {},
          ),
        );
        _createMarker();
        _getPolyline();
      });
    }).catchError((e) {
      print(e);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Your location has been detected"),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString("userEmail");
  }

  List<QueryDocumentSnapshot> selected;

  Set<Marker> _createMarker() {
    getUserMail();
    // _getCurrentLocation();
    markerList = [];
    List<QueryDocumentSnapshot> resultList = [];

    selectedPlaces.forEach((element) {
      double _latitude = double.parse(element.latitude);
      double _longitude = double.parse(element.longitude);

      markerList.add(
        Marker(
          markerId: MarkerId(element.id),
          position: LatLng(_latitude, _longitude),
          infoWindow: InfoWindow(
            title: element.name,
          ),
          icon: (element.name == "Current Position")
              ? BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                )
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet,
                ),
        ),
      );
    });

    return markerList.toSet();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    for (int i = 1; i < selectedPlaces.length; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyA-EuCciDiU3RbI_axYIXGqghI_5nTPS-A",
        PointLatLng(
          markerList[i - 1].position.latitude,
          markerList[i - 1].position.longitude,
        ),
        PointLatLng(
          markerList[i].position.latitude,
          markerList[i].position.longitude,
        ),
        travelMode: travelMode,
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    _createMarker();
    _getPolyline();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TravelMode> travelModes = [
      TravelMode.bicycling,
      TravelMode.driving,
      TravelMode.transit,
      TravelMode.walking,
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: BackButton(color: dayTextColor),
          backgroundColor: Colors.white70,
          title: Stack(
            children: [
              Align(
                alignment: Alignment(-0.2, -0.8),
                child: BoldText("", 20, dayTextColor),
              ),
              Align(
                alignment: Alignment(0.9, -0.8),
                child: DropdownButton<TravelMode>(
                  value: travelMode,
                  icon: const Icon(Icons.route_rounded),
                  elevation: 16,
                  style: TextStyle(color: dayTextColor),
                  underline: Container(
                    height: 2,
                    color: Colors.deepOrangeAccent,
                  ),
                  onChanged: (TravelMode newValue) {
                    setState(() {
                      travelMode = newValue;
                      _getPolyline();
                    });
                  },
                  items: travelModes
                      .map<DropdownMenuItem<TravelMode>>((TravelMode value) {
                    return DropdownMenuItem<TravelMode>(
                      value: value,
                      child: Text(
                        value.toString().split(".")[1][0].toUpperCase() +
                            value.toString().split(".")[1].substring(1) +
                            " Mode",
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(markerList[0].position.latitude,
              markerList[0].position.longitude),
          zoom: 13,
        ),
        zoomControlsEnabled: false,
        tiltGesturesEnabled: true,
        compassEnabled: false,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        markers: _createMarker(),
        polylines: Set<Polyline>.of(polylines.values),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new Comment(cityId)));
        },
        child: Icon(
          FontAwesomeIcons.arrowRight,
          color: kwhite,
        ),
        backgroundColor: dayMainColor,
      ),
    );
  }
}
