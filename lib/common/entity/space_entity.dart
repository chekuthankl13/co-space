abstract class SpaceEntity {
  final String id;
  final String name;
  final String location;
  final List<String> images;
  final List<String> amenities;
  final String pricePerHour;
  final String privacy;
  final String discription;
  final String rating;
  final String phoneNumber;
  final String owner;
  final String capacity;

  SpaceEntity({
    required this.amenities,
    required this.capacity,
    required this.owner,
    required this.phoneNumber,
    required this.discription,
    required this.privacy,
    required this.rating,
    required this.pricePerHour,
    required this.id,
    required this.name,
    required this.location,
    required this.images,
  });
}
