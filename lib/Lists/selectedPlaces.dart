import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/Models/location.dart';

List<Location> selectedPlaces = [
  Location(
    id: "1",
    imageUrl: 'assets/sheraton.jpg',
    name: 'Sheraton',
    type: 'restaurant',
    description: "Description",
    location: cities[1].name,
    comment: 'This place is a beatiful place to stay',
    rate: "4.5",
    cityId: cities[1].id,
  ),
];
