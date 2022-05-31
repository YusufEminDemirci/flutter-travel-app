import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_food/Lists/selectedPlaces.dart';
import 'package:travel_food/Lists/selectedRestaurants.dart';
import 'package:travel_food/Prefabs/CommentArea.dart';
import 'package:travel_food/Screens/Comment.dart';
import 'package:travel_food/Utils/TextStyles.dart';
import 'package:travel_food/Utils/consts.dart';

class TravelPlan extends StatefulWidget {
  final String cityName;
  final String cityId;
  final TravelMode travelMode;

  TravelPlan(
    this.cityName,
    this.cityId,
    this.travelMode,
  );
  @override
  _TravelPlanState createState() => _TravelPlanState(
        this.cityName,
        this.cityId,
        this.travelMode,
      );
}

class _TravelPlanState extends State<TravelPlan>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;
  TravelMode travelMode;

  _TravelPlanState(
    this.cityName,
    this.cityId,
    this.travelMode,
  );

  GoogleMapController _controller;
  List<Marker> markerList = [];
  // Position _currentPosition;

  // _getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  Set<Marker> _createMarker() {
    markerList = [];
    for (var i = 0; i < selectedPlaces.length; i++) {
      double _latitude = double.parse(selectedPlaces[i].latitude);
      double _longitude = double.parse(selectedPlaces[i].longitude);

      markerList.add(Marker(
        markerId: MarkerId(selectedPlaces[i].id),
        position: LatLng(_latitude, _longitude),
        infoWindow: InfoWindow(
          title: selectedPlaces[i].name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      ));
    }
    for (var i = 0; i < selectedRestaurants.length; i++) {
      double _latitude = double.parse(selectedRestaurants[i].latitude);
      double _longitude = double.parse(selectedRestaurants[i].longitude);

      markerList.add(Marker(
        markerId: MarkerId(selectedRestaurants[i].id),
        position: LatLng(_latitude, _longitude),
        infoWindow: InfoWindow(
          title: selectedRestaurants[i].name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      ));
    }

    return markerList.toSet();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA-EuCciDiU3RbI_axYIXGqghI_5nTPS-A",
      // PointLatLng(
      //   _currentPosition.latitude,
      //   _currentPosition.longitude,
      // ),
      PointLatLng(
        markerList[0].position.latitude,
        markerList[0].position.longitude,
      ),
      PointLatLng(
        markerList[markerList.length - 1].position.latitude,
        markerList[markerList.length - 1].position.longitude,
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
    // _getCurrentLocation();
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
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white70,
          title: Stack(
            children: [
              Align(
                alignment: Alignment(-0.2, -0.8),
                child: BoldText(cityName, 20, Colors.black),
              ),
              Align(
                alignment: Alignment(0.9, -0.8),
                child: DropdownButton<TravelMode>(
                  value: travelMode,
                  icon: const Icon(Icons.route_rounded),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new CommentScreen(cityName, cityId)));
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

getSelectedPlaces(String cityId, String cityName) {
  List<Widget> places = [];
  for (int index = 0; index < selectedPlaces.length; index) {
    places.add(CommentArea(
      selectedPlaces[index].id,
      selectedPlaces[index].imageUrl,
      selectedPlaces[index].name,
      selectedPlaces[index].location,
      selectedPlaces[index].description,
      selectedPlaces[index].rate,
      selectedPlaces[index].type,
      selectedPlaces[index].telephone,
      selectedPlaces[index].whoSee,
      selectedPlaces[index].hours,
      cityId,
      cityName,
    ));
  }
  return places;
}

getSelectedRestaurants(String cityId, String cityName) {
  List<Widget> places = [];
  for (int index = 0; index < selectedRestaurants.length; index) {
    places.add(CommentArea(
      selectedRestaurants[index].id,
      selectedRestaurants[index].imageUrl,
      selectedRestaurants[index].name,
      selectedRestaurants[index].location,
      selectedRestaurants[index].description,
      selectedRestaurants[index].rate,
      selectedRestaurants[index].type,
      selectedRestaurants[index].telephone,
      selectedRestaurants[index].whoSee,
      selectedRestaurants[index].hours,
      cityId,
      cityName,
    ));
  }
  return places;
}
