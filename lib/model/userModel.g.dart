// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel()
      ..message = json['message'] as String?
      ..token = json['token'] as String?
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>)
      ..balance = json['balance'] as String?
      ..publicKey = json['publicKey'] as String?;

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'user': instance.user,
      'balance': instance.balance,
      'publicKey': instance.publicKey,
    };

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['userId'] as String?
  ..phone = json['phone'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'phone': instance.phone,
    };
