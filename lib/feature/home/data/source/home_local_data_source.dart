import 'package:co_workspace/core/db/db_service.dart';
import 'package:co_workspace/core/dummy/dummy_data.dart';
import 'package:co_workspace/core/error/exceptions.dart';
import 'package:co_workspace/common/models/space_entity_model.dart';

abstract interface class HomeLocalDataSource {
  Future<List<SpaceEntityModel>> loadSpaces();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DbService dbService;

  HomeLocalDataSourceImpl({required this.dbService});

  @override
  Future<List<SpaceEntityModel>> loadSpaces() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      List<Map<String, dynamic>> res = DummyData.spaces;

      return res.map((e) => SpaceEntityModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
