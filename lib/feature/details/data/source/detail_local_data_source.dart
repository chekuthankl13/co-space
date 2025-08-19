import 'package:co_workspace/common/models/space_entity_model.dart';
import 'package:co_workspace/core/db/db_service.dart';
import 'package:co_workspace/core/dummy/dummy_data.dart';
import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/core/error/failure.dart';

abstract interface class DetailLocalDataSource {
  Future<SpaceEntityModel> getDetail({required String id});
  Future<String> book({required Map<String, dynamic> param});
}

class DetailLocalDataSourceImpl extends DetailLocalDataSource {
  final DbService dbService;

  DetailLocalDataSourceImpl({required this.dbService});

  @override
  Future<SpaceEntityModel> getDetail({required String id}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      var res = DummyData.spaces
          .where((element) => element['id'] == id)
          .toList();

      if (res.isNotEmpty) {
        return SpaceEntityModel.fromJson(res.first);
      } else {
        throw NotFoundFailure(error: "co-workspace not found !!");
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String> book({required Map<String, dynamic> param}) async {
    try {
      await dbService.getBox().add(param);
      return "ok";
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
