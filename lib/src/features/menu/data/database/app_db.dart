import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'drink_table.dart';

part 'app_db.g.dart';

@DriftDatabase(tables: [Drinks])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<DrinkData>> getDrinksForPage(int page, int limit) async {
    return (select(drinks)..limit(limit, offset: page * limit)).get();
  }

  Future<void> insertDrinks(List<DrinkData> drinkDataList) async {
    await batch((batch) {
      batch.insertAll(drinks, drinkDataList);
    });
  }

  Future<void> clearDrinks() async {
    await delete(drinks).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
