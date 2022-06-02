import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_food/Models/city.dart';

import '../../../Utils/TextStyles.dart';
import '../../../Utils/consts.dart';
import 'Place/Place.dart';

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

GoogleMapController _controller;
List<Marker> markerList = [];
List<CityModel> travelList = [];
CustomInfoWindowController _customInfoWindowController =
    CustomInfoWindowController();

@override
void dispose() {
  _customInfoWindowController.dispose();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: AppBar(
          backgroundColor: Colors.white70,
          title: BoldText("Türkiye", 20, dayTextColor),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Cities").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String cityId = snapshot.data.documents[0].data()["location"];

                snapshot.data.documents.forEach((element) {
                  travelList.add(
                    CityModel(
                      id: element.data()["id"],
                      imageUrl: element.data()["imageUrl"],
                      name: element.data()["name"],
                      latitude: element.data()["latitude"],
                      longitude: element.data()["longitude"],
                    ),
                  );
                });

                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(38.985243, 34.75),
                    zoom: 5.65,
                    bearing: -90,
                  ),
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  liteModeEnabled: false,
                  tiltGesturesEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  markers: _createMarker(context, travelList),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    // markerList.forEach((element) {
                    //   controller.showMarkerInfoWindow(
                    //     MarkerId(
                    //       element.markerId.toString(),
                    //     ),
                    //   );
                    // });
                  },
                  onTap: (position) {
                    _customInfoWindowController.hideInfoWindow();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove();
                  },
                );
              } else {
                return Container();
              }
            }),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 75,
          width: 150,
          offset: 50,
        ),
      ]),
    );
  }
}

Set<Marker> _createMarker(BuildContext context, List<CityModel> cityList) {
  markerList = [];

  cityList.forEach((element) {
    double _latitude = double.parse(element.latitude);
    double _longitude = double.parse(element.longitude);

    markerList.add(
      Marker(
          markerId: MarkerId(element.id),
          position: LatLng(_latitude, _longitude),
          rotation: 90,
          infoWindow: _customInfoWindowController.addInfoWindow(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "I am here",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            LatLng(_latitude, _longitude),
          ),
          icon: (element.name == "Current Position")
              ? BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                )
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet,
                ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new Places(element.id, element.name),
              ),
            );
          }),
    );
  });

  return markerList.toSet();
}
