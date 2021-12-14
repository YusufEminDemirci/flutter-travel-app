import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/Models/location.dart';

List<Location> seenRestaurant = [
  Location(
    id: "3",
    imageUrl: 'assets/tlemcen.jpg',
    name: 'Tlemcen',
    type: 'restaurant',
    description: "Description",
    location: cities[1].name,
    comment: 'This place is a beatiful place to stay',
    rate: "3.2",
    cityId: cities[1].id,
  ),
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