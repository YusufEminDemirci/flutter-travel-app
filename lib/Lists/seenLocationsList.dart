import 'package:lets_head_out/Lists/citiesList.dart';
import 'package:lets_head_out/utils/locationModel.dart';

List<Location> seenLocations = [
  Location(
    id: "1",
    imageUrl: 'assets/sheraton.jpg',
    name: 'Sheraton',
    type: 'restaurant',
    description: "Description",
    location: city[1].id,
    comment: 'This place is a beatiful place to stay',
    rate: "4.5",
  ),
  Location(
    id: "3",
    imageUrl: 'assets/tlemcen.jpg',
    name: 'Tlemcen',
    type: 'place',
    description: "Description",
    location: city[1].id,
    comment: 'This place is a beatiful place to stay',
    rate: "3.2",
  ),
];
