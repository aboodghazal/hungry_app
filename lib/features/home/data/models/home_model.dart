
import '../../../../core/global_model/product_model.dart';
import '../../domain/entitys/product_entitys.dart';

class ProductResponseModel {
  final List<ProductModel> listProduct;

  ProductResponseModel({required this.listProduct});

  // ✅ إنشاء من JSON
  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'] ?? [];
    return ProductResponseModel(
      listProduct: list.map((e) => ProductModel.fromJson(e)).toList(),
    );
  }

  // ✅ نموذج فارغ
  factory ProductResponseModel.empty() {
    return ProductResponseModel(listProduct: []);
  }

  // ✅ تحويل إلى Entity
  ProductResponseEntity toEntity() => ProductResponseEntity(
      products: listProduct.map((e) => e.toEntity()).toList(), );
}


