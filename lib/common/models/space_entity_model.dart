import 'package:co_workspace/common/entity/space_entity.dart';

class SpaceEntityModel extends SpaceEntity {
  SpaceEntityModel({
    required super.capacity,
    required super.id,
    required super.name,
    required super.location,
    required super.images,
    required super.amenities,
    required super.pricePerHour,
    required super.discription,
    required super.privacy,
    required super.rating,
    required super.owner,
    required super.phoneNumber,
  });

  factory SpaceEntityModel.fromJson(Map<String, dynamic> json) =>
      SpaceEntityModel(
        capacity: json['capacity'].toString(),
        discription: json['description'].toString(),
        privacy: json['privacyPolicy'] ?? "",
        rating: json['ratings'].toString(),
        id: json['id'].toString(),
        name: json['name'].toString(),
        location: json['location'].toString(),
        images: (json['images'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        amenities: (json['amenities'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        pricePerHour: json['pricePerHour'].toString(),
        owner: json['ownerName'].toString(),
        phoneNumber: json['phoneNumber'].toString(),
      );

  factory SpaceEntityModel.fromEntity(SpaceEntity data) => SpaceEntityModel(
    capacity: data.capacity,
    id: data.id,
    name: data.name,
    location: data.location,
    images: data.images,
    amenities: data.amenities,
    pricePerHour: data.pricePerHour,
    discription: data.discription,
    privacy: data.privacy,
    rating: data.rating,
    owner: data.owner,
    phoneNumber: data.phoneNumber,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'images': images,
    'capacity': capacity,
    'amenities': amenities,
    'pricePerHour': pricePerHour,
    'ratings': rating,
    'description': discription,
    'privacyPolicy': privacy,
    'ownerName': owner,
    'phoneNumber': phoneNumber,
  };
}
