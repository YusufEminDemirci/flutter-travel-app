import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocationMap extends StatefulWidget {
  final String description;
  final Map hours;
  final String id;
  final String imageUrl;
  final String location;
  final String name;
  final String rate;
  final String telephone;
  String latitude;
  String longitude;
  final String type;
  final List whoSee;
  final String cityName;

  PlaceLocationMap(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.latitude,
    this.longitude,
    this.whoSee,
    this.hours,
    this.cityName,
  );

  @override
  _PlaceLocationMap createState() => _PlaceLocationMap(
        this.id,
        this.imageUrl,
        this.name,
        this.location,
        this.description,
        this.rate,
        this.type,
        this.telephone,
        this.latitude,
        this.longitude,
        this.whoSee,
        this.hours,
        this.cityName,
      );
}

class _PlaceLocationMap extends State<PlaceLocationMap>
    with SingleTickerProviderStateMixin {
  String description;
  Map hours;
  String id;
  String imageUrl;
  String location;
  String name;
  String rate;
  String telephone;
  String latitude;
  String longitude;
  String type;
  List whoSee;
  String cityName;

  _PlaceLocationMap(
    this.id,
    this.imageUrl,
    this.name,
    this.location,
    this.description,
    this.rate,
    this.type,
    this.telephone,
    this.latitude,
    this.longitude,
    this.whoSee,
    this.hours,
    this.cityName,
  );

  @override
  Widget build(BuildContext context) {
    GoogleMapController _controller;

    final CameraPosition _initalCameraPosition = CameraPosition(
      target: LatLng(double.parse(latitude), double.parse(longitude)),
      zoom: 16,
    );

    Set<Marker> _createMarker() {
      List<Marker> markerList = [];

      markerList.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(double.parse(latitude), double.parse(longitude)),
        infoWindow: InfoWindow(
          title: name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      ));

      return markerList.toSet();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            SizedBox(
              height: 330,
              width: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initalCameraPosition,
                  zoomControlsEnabled: false,
                  compassEnabled: true,
                  markers: _createMarker(),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
