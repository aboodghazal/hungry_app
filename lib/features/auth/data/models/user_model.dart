import '../../domain/entity/user_entity.dart';

class UserModel {
  final String name;
  final String email;

  final String? image;
   final String? visa;
  final String? address;

  UserModel({
    required this.name,
    required this.email,
    this.image,
     this.address,
    this.visa,
  });

  // تحويل من JSON إلى كائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing user data - token field: ${json['token']}');
    return UserModel(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
       address: json['address']?.toString() ?? '',
      visa: json['Visa']?.toString() ?? '',
    );
  }

  // نموذج فارغ
  factory UserModel.emptyOne() => UserModel(
    name: '',
    email: '',
    address: '',
    image: '',
     visa: '',
  );

  // تحويل من UserModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image ?? '',
       'address': address ?? '',
      'Visa': visa ?? '',
    };
  }

  // داخل UserModel
  UserEntity toEntity() {
    return UserEntity(
      name: name,
      email: email, image: image ?? '', address: address ?? '', visa: visa ?? '',
     );
  }

}
