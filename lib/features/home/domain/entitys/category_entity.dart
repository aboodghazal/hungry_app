class CategoryResponseEntity {
  final List<CategoryEntity> listCate;

  CategoryResponseEntity({required this.listCate});

}

class CategoryEntity{
  final int id;
  final String name;

  CategoryEntity({required this.id, required this.name});


}