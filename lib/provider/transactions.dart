import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _items = [
    // Transaction(
    //   id: 'p1',
    //   title: 'Yellow Scarf',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'p2',
    //   title: 'shoes',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'p4',
    //   title: 'Yellow Scarf',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'p5',
    //   title: 'shoes',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'p6',
    //   title: 'Yellow Scarf',
    //   price: 19.99,
    //   date: DateTime.now(),
    // ),
  ];
  String _authToken;
  set authToken(String value) {
    _authToken = value;
  }

  List<Transaction> get item {
    //http.get(url)
    return [..._items];
  }

  Transaction findById(String id) {
    print('id');
    return _items.firstWhere((trans) => trans.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        "https://group-expense-a0ce5.firebaseio.com/transaction.json?auth=$_authToken";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> loadedProducts = [];
      print(extractedData);
      if (extractedData != null) {
        extractedData.forEach((prodId, prodData) {
          loadedProducts.insert(0, Transaction.fromJson(prodId, prodData));
        });
      }
      // extractedData.forEach((prodId, prodData) {
      //   loadedProducts.add(Transaction (
      //     id: prodId,
      //     title: prodData['title'],
      //     price: prodData['price'],
      //     isSelected: prodData['isSelected'],
      //     date: prodData['date'],
      //   ));
      // });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addTransaction(Transaction expense) async {
    final url =
        "https://group-expense-a0ce5.firebaseio.com/transaction.json?auth=$_authToken";
    // try {
    //   print('in json');
    //   await http.post(
    //     url,
    //     body: expense.toJson(),
    //   );
    //   print(
    //       "safdnkjaesbfjkbawkjgfbkjsbadzkjfb awskgjbvkjsadbfjwkjasdbfkjbsgadjbgjkragkjbjkdn");
    //   _items.add(expense);
    //   notifyListeners();
    // } catch (error) {
    //   print("error=");
    //   print(error);
    //   throw error;
    // }
    try {
      await http.post(url,
          body: json.encode({
            'id': expense.id,
            'title': expense.title,
            'price': expense.price,
            'date': expense.date.toString(),
            'isSelected': expense.isSelected,
            'memberId': expense.memberId,
            'members': expense.members.length == 0
                ? []
                : expense.members, ////chances of error
          }));
      print(
          "safdnkjaesbfjkbawkjgfbkjsbadzkjfb awskgjbvkjsadbfjwkjasdbfkjbsgadjbgjkragkjbjkdn");
      _items.add(expense);
      notifyListeners();
    } catch (error) {
      print("error=");
      print(error);
      throw error;
    }

    // final newExpense = Transaction(
    //   id: DateTime.now().toString(),
    //   title: expense.title,
    //   description: expense.description,
    //   date: expense.date,
    //   price: expense.price,
    //   type: expense.type,
    // );
  }

  Future<void> deleteTransaction(String id) async {
    final existingProductIndex = _items.indexWhere((trans) => trans.id == id);
    print('id= $id');
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final url =
        "https://group-expense-a0ce5.firebaseio.com/transaction/$id.json?auth=$_authToken";
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      print(response.statusCode);
      print(Exception());
      throw Exception();
    }
    existingProduct = null;
  }

  Future<void> updateProduct(String id, Transaction newTransaction) async {
    final transIndex = _items.indexWhere((prod) => prod.id == id);

    if (transIndex >= 0) {
      final url =
          "https://group-expense-a0ce5.firebaseio.com/transaction/$id.json?auth=$_authToken";
      try {
        print('update');
        await http.patch(url,
            body: json.encode({
              'id': newTransaction.id,
              'title': newTransaction.title,
              'price': newTransaction.price,
              'date': newTransaction.date.toString(),
              'isSelected': newTransaction.isSelected,
              'memberId': newTransaction.memberId,
              'members': newTransaction.members,
            }));
        _items[transIndex] = newTransaction;
        notifyListeners();
      } catch (error) {
        print(error);
      }
    } else {
      print('...');
    }
  }
}

//while deleting or updating keep in mind id is just under transaction,the id which we define is child.
