import 'package:json_annotation/json_annotation.dart';
import "member.dart";
part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
    
     Transaction({
    this.id,
    this.price,
    this.title,
    this.date,
    this.isSelected = false,
    this.members,
    this.memberId,
  });
    String id;
    num price;
    String title;
    String memberId;
    String date;
    bool isSelected;
    List<Member> members;
    
    factory Transaction.fromJson(String prodId,Map<String,dynamic> json) {
        return _$TransactionFromJson(prodId,json);
    }
    Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

// Transaction({
//     this.id,
//     this.price,
//     this.title,
//     this.date,
//     this.isSelected = false,
//     this.members,
//   });