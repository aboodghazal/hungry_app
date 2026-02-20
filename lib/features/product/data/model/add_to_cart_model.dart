class AddToCartModel {
   final int productId;
   final int quantity;
   final String spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  AddToCartModel({
    required this.productId,
      required this.quantity,
    required this.spicy, required this.toppings, required this.sideOptions,
  });



  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": double.tryParse(spicy) ?? 0.0,
      "toppings": toppings, // فقط الـ IDs
      "side_options": sideOptions, // فقط الـ IDs
    };
  }




}