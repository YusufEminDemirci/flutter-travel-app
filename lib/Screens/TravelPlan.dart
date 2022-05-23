import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  TravelPlan(
    this.cityName,
    this.cityId,
  );
  @override
  _TravelPlanState createState() => _TravelPlanState(
        this.cityName,
        this.cityId,
      );
}

double _originLatitude = 36.988558;
double _originLongitude = 35.329461;
double _destLatitude = 36.99;
double _destLongitude = 35.33;

class _TravelPlanState extends State<TravelPlan>
    with SingleTickerProviderStateMixin {
  String cityName;
  String cityId;

  _TravelPlanState(
    this.cityName,
    this.cityId,
  );

  GoogleMapController _controller;

  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 13,
  );

  Set<Marker> _createMarker() {
    List<Marker> markerList = [];

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

    return markerList.toSet();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA-EuCciDiU3RbI_axYIXGqghI_5nTPS-A",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
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
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getPolyline();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          leading: BackButton(color: dayMainColor),
          backgroundColor: Colors.transparent,
          title: BoldText("Travel Plan", 20, dayMainColor),
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
      body: Container(
        alignment: Alignment.center,
        child: GoogleMap(
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _initalCameraPosition,
          zoomControlsEnabled: false,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: _createMarker(),
          polylines: Set<Polyline>.of(polylines.values),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
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
