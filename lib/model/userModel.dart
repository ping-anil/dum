// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.message,
    this.token,
    this.user,
    this.balance,
    this.publicKey,
  });

  String? message;
  String? token;
  User? user;
  String? balance;
  String? publicKey;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.userId,
    this.phone,
    this.password,
    this.privateKey,
    this.v=0,
  });

  String? id;
  String? userId;
  String? phone;
  String? password;
  PrivateKey? privateKey;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    userId: json["userId"],
    phone: json["phone"],
    password: json["password"],
    privateKey: PrivateKey.fromJson(json["privateKey"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "phone": phone,
    "password": password,
    "privateKey": privateKey?.toJson(),
    "__v": v,
  };
}

class PrivateKey {
  PrivateKey({
    this.type,
    required this.data,
  });

  String? type;
  List<int> data;

  factory PrivateKey.fromJson(Map<String, dynamic> json) => PrivateKey(
    type: json["type"],
    data: List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
