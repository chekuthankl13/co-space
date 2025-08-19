import 'package:co_workspace/common/entity/space_entity.dart';
import 'package:co_workspace/common/models/space_entity_model.dart';
import 'package:co_workspace/core/db/db_service.dart';
import 'package:co_workspace/core/dummy/dummy_data.dart';
import 'package:co_workspace/core/error/exceptions.dart';

abstract interface class SearchLocalDataSource {
  Future<List<SpaceEntity>> search({required String search});
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final DbService dbService;

  SearchLocalDataSourceImpl({required this.dbService});

  @override
  Future<List<SpaceEntity>> search({required String search})async {
    try {
      await Future.delayed(Duration(seconds: 2));
      List<Map<String, dynamic>> res = DummyData.spaces;
    final filteredRes = res.where((e) {
        final name = (e['name'] ?? '').toString().toLowerCase();
        final location = (e['location'] ?? '').toString().toLowerCase();
        final searchLower = search.toLowerCase();
        return name.contains(searchLower) || location.contains(searchLower);
      }).toList();
     return filteredRes.map((e) => SpaceEntityModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
  
  
}
