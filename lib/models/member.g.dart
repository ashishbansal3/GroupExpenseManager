// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(String prodId,Map<String, dynamic> json) {
  return Member()
    ..userId = json['userId'] as String
    ..grpId = json['id'] as String
    ..name = json['name'] as String
    ..isActive = json['isActive'] as bool;
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.grpId,
      'name': instance.name,
      'isActive': instance.isActive,
      
    };
