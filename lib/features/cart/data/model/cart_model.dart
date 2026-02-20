

import 'package:huungry/features/cart/domain/entity/cart_entity.dart';
import 'package:huungry/features/product/data/model/topping_model.dart';

class CartResponseModel {
  final int id;
  final String totalPrice;
  final List<CartItemModel> items;

  CartResponseModel({
    required this.id, required this.totalPrice, required this.items,
  });

  // ✅ البناء من JSON: نستخرج البيانات من مفتاح 'data'
  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'] ?? {};
    final List<dynamic> itemsList = data['items'] ?? [];

    return CartResponseModel(
      id: data['id'] ?? 0,
      totalPrice: data['total_price']?.toString() ?? '0.00',
      items: itemsList.map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }

  // ✅ النموذج الفارغ
  factory CartResponseModel.empty() {
    return CartResponseModel(
      id: 0,
      totalPrice: '0.00',
      items: [],
    );
  }

  // ✅ التحويل إلى Entity
  CartResponseEntity toEntity() {
    return CartResponseEntity(
      id: id,
      totalPrice: totalPrice,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}
class CartItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final String price;
  final String spicy;
  final List<ToppingModel> toppings;
  final List<ToppingModel> sideOptions;

  CartItemModel({
    required this.itemId, required this.productId, required this.name,
    required this.image, required this.quantity, required this.price,
    required this.spicy, required this.toppings, required this.sideOptions,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // التحقق وتحويل القوائم الفرعية
    final List<dynamic> toppingsList = json['toppings'] ?? [];
    final List<dynamic> sidesList = json['side_options'] ?? [];

    return CartItemModel(
      itemId: json['item_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price']?.toString() ?? '0.00',
      // التأكد من أن Spicy هو String (كما في الـ Response)
      spicy: json['spicy']?.toString() ?? '0.00',
      toppings: toppingsList.map((e) => ToppingModel.fromJson(e)).toList(),
      sideOptions: sidesList.map((e) => ToppingModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": double.tryParse(spicy) ?? 0.0,
      "toppings": toppings.map((e) => e.id).toList(), // فقط الـ IDs
      "side_options": sideOptions.map((e) => e.id).toList(), // فقط الـ IDs
    };
  }

  factory CartItemModel.empty() {
    return CartItemModel(
      itemId: 0, productId: 0, name: '', image: '', quantity: 0,
      price: '0.00', spicy: '0.00', toppings: [], sideOptions: [],
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      itemId: itemId,
      productId: productId,
      name: name,
      image: image,
      quantity: quantity,
      price: price,
      spicy: spicy,
      toppings: toppings.map((e) => e.toEntity()).toList(),
      sideOptions: sideOptions.map((e) => e.toEntity()).toList(),
    );
  }
}