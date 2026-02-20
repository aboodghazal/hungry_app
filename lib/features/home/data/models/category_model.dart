import 'package:huungry/features/home/domain/entitys/category_entity.dart';

class CategoryResponseModel{
  final List<CategoryModel> listCategory;

  CategoryResponseModel({required this.listCategory});

  // ✅ تم تبسيط عملية التحقق من 'data' واستخدام toList
  factory CategoryResponseModel.fromJson(Map<String,dynamic> json ){
    final List<dynamic> list = json['data'] ?? [];
    return CategoryResponseModel(
      listCategory: list.map((e) => CategoryModel.fromJson(e)).toList(),
    );
  }

  // ✅ تصحيح: النموذج الفارغ لا يحتاج إلى تمرير JSON
  factory CategoryResponseModel.empty() {
    return CategoryResponseModel(listCategory: []);
  }
  
  CategoryResponseEntity toEntity()=>CategoryResponseEntity(listCate: listCategory.map((e) => e.toEntity(),).toList());
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json['id'] ?? -1, name: json['name'] ?? '');

  // ✅ تصحيح: النموذج الفارغ لا يحتاج إلى تمرير JSON
  factory CategoryModel.empty() =>
      CategoryModel(id: 0, name: 'name');
  
  CategoryEntity toEntity()=>CategoryEntity(id: id, name: name);
}
