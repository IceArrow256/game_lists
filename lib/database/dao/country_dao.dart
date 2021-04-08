import 'package:floor/floor.dart';
import 'package:game_lists/database/entities/country.dart';

@dao
abstract class CountryDao {
  @insert
  Future<void> insertCountry(Country country);

  @Query('SELECT * FROM Country WHERE name = :name ORDER BY name')
  Future<List<Country>> findWithNames(String name);

  @Query('SELECT * FROM Country WHERE name LIKE :name ORDER BY name')
  Future<List<Country>> findWithNamesLike(String name);
}
