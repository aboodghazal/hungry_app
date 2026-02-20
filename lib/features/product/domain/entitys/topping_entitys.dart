
class ToppingResponseEntity{
  final List<ToppingEntity> listTopping;
  ToppingResponseEntity(this.listTopping);
}

class ToppingEntity {
  final int id;
  final String name;
  final String image;

  ToppingEntity({required this.id, required this.name, required this.image});

}