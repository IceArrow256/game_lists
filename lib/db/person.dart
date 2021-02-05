import 'package:floor/floor.dart';

@entity
class Person {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name;

  Person(this.id, this.name);
}
