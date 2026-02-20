class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;
   bool isFavorite;

  ProductEntity({required this.id, required this.name, required this.description, required this.image, required this.rating, required this.price, required this.isFavorite});
}


class ProductResponseEntity{
  final List<ProductEntity> products;

  ProductResponseEntity({required this.products});


}