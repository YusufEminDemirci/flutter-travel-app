import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/Models/location.dart';

List<Location> restaurants = [
  Location(
    id: "1",
    imageUrl: 'assets/sheraton.jpg',
    name: 'Sheraton',
    description: "Good Place",
    location: cities[0].name,
    comment: 'This place is a beatiful place to stay',
    rate: "4.5",
    cityId: cities[0].id,
  ),
  Location(
    id: "2",
    imageUrl: 'assets/tlemcen.jpg',
    name: 'Tlemcen',
    description: "Good Place",
    location: cities[0].name,
    comment: 'This place is a beatiful place to stay',
    rate: "3.2",
    cityId: cities[0].id,
  ),
  Location(
    id: "3",
    imageUrl: 'assets/tlemcen.jpg',
    name: 'Tlemcen',
    description: "Good Place",
    location: cities[0].name,
    comment: 'This place is a beatiful place to stay',
    rate: "3.2",
    cityId: cities[0].id,
  ),
  Location(
    id: "4",
    imageUrl: 'assets/alger.jpg',
    name: 'Alger',
    description: "Good Place",
    location: cities[0].name,
    comment: 'This place is a beatiful place to stay',
    rate: "4.7",
    cityId: cities[0].id,
  ),
];
