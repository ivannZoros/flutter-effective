import '../../models/drink.dart';
import '../data_source/drink_data_source.dart';
import '../database/app_db.dart';

class DrinkRepository {
  final DrinkDataSource _drinkDataSource;
  final AppDb _appDb;

  DrinkRepository(this._drinkDataSource, this._appDb);

  Future<List<Drink>> getDrinks(int page, int limit) async {
    try {
      final networkDrinks = await _drinkDataSource.getDrinks(page, limit);
      print("Clearing drinks..."); //
      await _appDb.clearDrinks();
      await _appDb.insertDrinks(networkDrinks
          .map((drink) => DrinkData(
              id: drink.id,
              name: drink.name,
              slug: drink.slug,
              imagePath: drink.imagePath,
              price: drink.price))
          .toList());

      print("Reading drinks from DB..."); //
      final insertedDrinks = await _appDb.getDrinksForPage(page, limit); //
      print("Inserted drinks from DB: $insertedDrinks"); //

      return networkDrinks;
    } catch (e) {
      final dbDrinks = await _appDb.getDrinksForPage(page, limit);
      return dbDrinks
          .map((drinkData) => Drink(
                id: drinkData.id,
                name: drinkData.name,
                slug: drinkData.slug ?? '',
                imagePath: drinkData.imagePath,
                price: drinkData.price,
              ))
          .toList();
    }
  }
}
