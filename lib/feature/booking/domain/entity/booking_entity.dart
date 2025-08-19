import 'package:co_workspace/common/entity/space_entity.dart';

abstract class BookingEntity {
  final SpaceEntity space;
  final String name;
  final String seat;
  final String sDate;
  final String eDate;
  final String time;

  BookingEntity({
    required this.space,
    required this.name,
    required this.seat,
    required this.sDate,
    required this.eDate,
    required this.time,
  });
}
