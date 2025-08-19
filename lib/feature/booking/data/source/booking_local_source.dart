import 'package:co_workspace/core/db/db_service.dart';
import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/feature/booking/data/models/booking_entity_model.dart';

abstract interface class BookingLocalSource {
  Future<List<BookingEntityModel>> bookings();

  Future<String> delete({required String id});
}

class BookingLocalSourceImpl implements BookingLocalSource {
  final DbService dbService;

  BookingLocalSourceImpl({required this.dbService});
  @override
  Future<List<BookingEntityModel>> bookings() async {
    try {
      var res = dbService.getBox().values.toList();

      if ((res).isEmpty) {
        return [];
      } else {
        return res
            .map(
              (e) => BookingEntityModel.fromJson(
                (e as Map).cast<String, dynamic>(),
              ),
            ) // Cast to Map<String, dynamic>
            .toList();
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String> delete({required String id}) async {
    try {
      await dbService.getBox().deleteAt(int.parse(id));

      return "ok";
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
