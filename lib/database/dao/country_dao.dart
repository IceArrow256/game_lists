import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/country.dart';

@dao
abstract class CountryDao {
  @insert
  Future<void> insertCountry(Country country);
}
