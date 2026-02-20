// OrderItemEntity.dart (Domain Layer)
import 'package:huungry/features/product/domain/entitys/topping_entitys.dart'; // ToppingEntity
// OrderDetailsResponseEntity.dart (Domain Layer)

class CartResponseEntity {
  final int id;
  final String totalPrice;
  final List<CartEntity> items;

  CartResponseEntity({
    required this.id, required this.totalPrice, required this.items,
  });
}
class CartEntity {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final String price;
  final String spicy;
  final List<ToppingEntity> toppings;
  final List<ToppingEntity> sideOptions;

  CartEntity({
    required this.itemId, required this.productId, required this.name,
    required this.image, required this.quantity, required this.price,
    required this.spicy, required this.toppings, required this.sideOptions,
  });
}