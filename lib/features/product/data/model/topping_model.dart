import 'package:huungry/features/product/domain/entitys/topping_entitys.dart';

class ToppingResponseModel{
  final List<ToppingModel> listTopping;

  ToppingResponseModel({required this.listTopping});

  factory ToppingResponseModel.fromJson(Map<String,dynamic> json){
    final List<dynamic> list = json['data'] ?? [];
    return ToppingResponseModel(listTopping: list.map((e) => ToppingModel.fromJson(e),).toList());

  }
  factory ToppingResponseModel.empty(){
    return ToppingResponseModel(listTopping: []);
  }
  ToppingResponseEntity toEntity(){
    return ToppingResponseEntity(listTopping.map((e) => e.toEntity(),).toList());
  }



}
class ToppingModel {
  final int id;
   final String name;
  final String image;

  ToppingModel({required this.id, required this.name, required this.image});


  factory ToppingModel.fromJson(Map<String,dynamic> json){
    return ToppingModel(id: json['id']??-1, name: json['name']??'', image: json['image']??'');
  }

  factory ToppingModel.empty() {
    return ToppingModel(id: -1, name: '', image: '');
  }

  ToppingEntity toEntity(){
    return ToppingEntity(id: id, name: name, image: image);
  }

}