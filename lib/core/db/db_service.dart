import 'package:hive_flutter/hive_flutter.dart';

class DbService {
  // Future<void> initDb() async {
  //   await Hive.initFlutter();
  //   await Hive.openBox('workspace');
  // }

 Box  getBox() => Hive.box("workspace");

 
}
