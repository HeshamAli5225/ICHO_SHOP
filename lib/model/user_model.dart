
class UserModel{

  late String id;
  late String name;
  late String email;
  late String phone;
  late String address;
  late String type;
  String ? image;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.type,
    this.image,

  });

  UserModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];

    address = json['address'];
    type = json['type'];
    image = json['image'];

  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phone':phone,
      'address':address,
      'type':type,
      'image':image,
    };
  }
}