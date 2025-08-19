import 'package:co_workspace/common/models/space_entity_model.dart';
import 'package:co_workspace/feature/booking/domain/entity/booking_entity.dart';

class BookingEntityModel extends BookingEntity {
  BookingEntityModel({
    required super.space,
    required super.name,
    required super.seat,
    required super.sDate,
    required super.eDate,
    required super.time,
  });
  factory BookingEntityModel.fromJson(Map<String, dynamic> json) =>
      BookingEntityModel(
        space: SpaceEntityModel.fromJson(
          (json['space'] as Map).cast<String, dynamic>(),
        ),
        name: json['name'] ?? "",
        seat: json['no_seats'] ?? "",
        sDate: json['start_date'] ?? "",
        eDate: json['end_date'] ?? "",
        time: json['time'] ?? "",
      );
}
