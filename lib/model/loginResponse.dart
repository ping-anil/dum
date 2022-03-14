import 'dart:convert';




class LoginResponse {
  String? message;
  String? token;
  User? user;
  int? balance;
  String? publicKey;

  LoginResponse(
      {this.message, this.token, this.user, this.balance, this.publicKey});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    balance = json['balance'];
    publicKey = json['publicKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    data['balance'] = this.balance;
    data['publicKey'] = this.publicKey;
    return data;
  }
}

class User {
  String? sId;
  String? userId;
  String? phone;
  String? password;
  PrivateKey? privateKey;
  PrivateKey? publicKey;
  String? balance;
  int? iV;

  User();

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    phone = json['phone'];
    password = json['password'];
    privateKey = json['privateKey'] != null
        ? new PrivateKey.fromJson(json['privateKey'])
        : null;
    publicKey = json['publicKey'] != null
        ? new PrivateKey.fromJson(json['publicKey'])
        : null;
    balance = json['balance'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['password'] = this.password;
    if (this.privateKey != null) {
      data['privateKey'] = this.privateKey?.toJson();
    }
    if (this.publicKey != null) {
      data['publicKey'] = this.publicKey?.toJson();
    }
    data['balance'] = this.balance;
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
