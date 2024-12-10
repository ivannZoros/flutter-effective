import 'package:drift/drift.dart';

@DataClassName('DrinkData')
class Drinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  TextColumn get imagePath => text()();
  RealColumn get price => real()();
  IntColumn get quantity => integer().nullable()();
  IntColumn get page => integer().nullable()();
}
