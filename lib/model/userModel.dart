// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String? message;
  User? user;
  String? publicKey;

  UserDataModel();

  UserDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    publicKey = json['publicKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    data['publicKey'] = this.publicKey;
    return data;
  }
}




class User {
  String? userId;
  String? phone;
  String? password;
  String? balance;
  PrivateKey? privateKey;
  PrivateKey? publicKey;
  String? sId;
  int? iV;

  User();

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    phone = json['phone'];
    password = json['password'];
    balance = json['balance'];
    privateKey = json['privateKey'] != null
        ? new PrivateKey.fromJson(json['privateKey'])
        : null;
    publicKey = json['publicKey'] != null
        ? new PrivateKey.fromJson(json['publicKey'])
        : null;
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['balance'] = this.balance;
    if (this.privateKey != null) {
      data['privateKey'] = this.privateKey?.toJson();
    }
    if (this.publicKey != null) {
      data['publicKey'] = this.publicKey?.toJson();
    }
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

class PrivateKey {
  String? type;
  List<int>? data;

  PrivateKey();

  PrivateKey.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}
