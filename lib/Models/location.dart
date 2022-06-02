class LocationModel {
  String id;
  String imageUrl;
  String name;
  String location;
  String description;
  String rate;
  String type;
  String telephone;
  String latitude;
  String longitude;
  List whoSee;
  Map hours;

  LocationModel(
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
      this.hours);
}
