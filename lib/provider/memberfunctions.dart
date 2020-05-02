import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './transactions.dart';
class Members with ChangeNotifier {
  
  List<Member> _listMember = [
    // Member(
    //   name: "Ashish",
    // ),
    // Member(
    //   name: "Robin",
    // ),
    // Member(
    //   name: "Mohit",
    // ),
    // Member(
    //   name: "Mani",
    // ),
    // Member(
    //   name: "Aryan",
    // ),
  ];
  // String _authToken;
  // set authToken(String value) {
  //   _authToken = value;
  // }

  List<Member> get list {
    return _listMember.toList();
  }

  Future<void> fetchAndSetProducts(String _authToken) async {
    final url =
        "https://group-expense-a0ce5.firebaseio.com/member.json?auth=$_authToken";

    try {
      print('in fetch member');
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Member> loadedProducts = [];
      print(extractedData);
      if (extractedData != null) {
        extractedData.forEach((prodId, prodData) {
          loadedProducts.add(Member.fromJson(prodId, prodData));
        });
      }
      _listMember = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addMember(String name, String grpId,String _authToken,String _userId) async {
    final url =
        "https://group-expense-a0ce5.firebaseio.com/member.json?auth=$_authToken";
        print('in add member');
        print(_authToken);
        
    try {
      await http.post(url,
          body: json.encode({
            'name': name,
            'userId': _userId,
            'grpId': grpId,
            'isActive': false,
          }));
      _listMember.add(Member(name: name,grpId: grpId,isActive: false,userId: name+grpId));
      notifyListeners();
    } catch (error) {
      print("error=");
      print(error);
      throw error;
    }
  }
}
