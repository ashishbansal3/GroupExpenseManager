// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(String prodId, Map<String, dynamic> json) {
  return Transaction()
    ..id = prodId as String
    ..price = json['price'] as num
    ..title = json['title'] as String
    ..date = json['date'] as String
    ..isSelected = json['isSelected'] as bool
    ..memberId = json['memberId'] as String
    ..members = (json['members'] as List)
        .map((i) => Member.fromJson(i['userId'], i))
        .toList();
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'title': instance.title,
      'date': instance.date,
      'isSelected': instance.isSelected,
      'members': instance.members,
      'memberIdTransaction': instance.memberId,
    };

//  Member(
//                   grpId: json['userId'].toString(),
//                   isActive: json['isActive'],
//                   name: json['name'].toString(),
//                   userId: json['userId'].toString()),
