import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
part 'member.g.dart';

@JsonSerializable()
class Member {
  Member({this.name, this.userId, this.grpId, this.isActive = false});

  String userId;
  String grpId;
  String name;
  bool isActive;

  factory Member.fromJson(String prodId,Map<String, dynamic> json) => _$MemberFromJson(prodId,json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

//Member({this.name, this.userId, this.id, this.isActive = false});
