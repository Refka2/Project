class UserModel {
  UserModel({
    this.userId,
    this.username,
    this.email,
    this.age,
    this.imageUrl,
    this.itemsNb,
  });
  final String? userId;
  final String? username;
  final String? email;
  final String? age;
  final String? imageUrl;
  final int? itemsNb;

  // factory UserModel.fromJson(Map<String, dynamic> data){
  //   return UserModel(
  //     userId: data['userId'] as String,
  //     username: data['username'] as String,
  //     email: data['email'] as String ,
  //     age: data['age'] as String ,
  //
  //   );
  // }

  static UserModel fromFirestore(Map<String, dynamic>? data) => UserModel(
      userId: data?['userId'],
      username: data?['username'],
      email: data?['email'],
      age: data?['age'],
      imageUrl: data?['imageUrl'],
      itemsNb: data?['itemsNb']);

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'age': age,
      'imageUrl': imageUrl,
      'itemsNb': itemsNb,
    };
  }
}
