import '../../features/home/domain/entitys/product_entitys.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final String price;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
    required this.isFavorite,
  });

  // ✅ إنشاء من JSON مع قيم افتراضية
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? -1,
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    image: json['image'] ?? '',
    rating: json['rating']?.toString() ?? '0',
    price: json['price']?.toString() ?? '0',
    isFavorite: json['is_favorite'] ?? false,
  );

  // ✅ نموذج فارغ
  factory ProductModel.empty() => ProductModel(
    id: 0,
    name: '',
    description: '',
    image: '',
    rating: '0',
    price: '0',
    isFavorite: false,
  );

  // ✅ تحويل إلى Entity
  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    description: description,
    image: image,
    rating: rating,
    price: price,
    isFavorite: isFavorite,
  );
}
