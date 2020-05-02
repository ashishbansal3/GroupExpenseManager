// import 'dart:ffi';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_complete_guide/Widget/newtransaction.dart';
// import 'package:flutter_complete_guide/provider/members.dart';
// import 'package:provider/provider.dart';
// import './transaction.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../provider/memberfunctions.dart';

// class Transactions with ChangeNotifier {
//   // var members= Provider.of<Members>(context).list;
//   List<Transaction> _items = [
//     Transaction(
//         id: 'p1',
//         title: 'Yellow Scarf',
//         price: 19.99,
//         date: DateTime.now(),
//         members: [
//           Member(id: '2', name: 'Aryan'),
//           Member(
//             id: '1',
//             name: 'ashish',
//           ),
//         ]),
//     Transaction(
//         id: 'p2',
//         title: 'shoes',
//         price: 19.99,
//         date: DateTime.now(),
//         members: [
//           Member(
//             id: '2',
//             name: 'Aryan',
//           ),
//           Member(
//             id: '1',
//             name: 'ashish',
//           ),
//           Member(
//             id: '3',
//             name: 'Robin',
//           ),
//         ]),
//          Transaction(
//         id: 'p3',
//         title: 'Yellow Scarf',
//         price: 19.99,
//         date: DateTime.now(),
//         members: [
//           Member(id: '2', name: 'Aryan'),
//           Member(
//             id: '1',
//             name: 'ashish',
            
//           ),
//         ]),
//     Transaction(
//         id: 'p4',
//         title: 'shoes',
//         price: 19.99,
//         date: DateTime.now(),
//         members: [
//           Member(
//             id: '2',
//             name: 'Aryan',
//           ),
//           Member(
//             id: '1',
//             name: 'ashish',
//           ),
//           Member(
//             id: '3',
//             name: 'Mani',
//           ),
//         ]),
//     // Transaction(
//     //   id: 'p3',
//     //   title: 'Yellow Scarf',
//     //   price: 19.99,
//     //   date: DateTime.now(),
//     // ),
//     // Transaction(
//     //   id: 'p4',
//     //   title: 'Yellow Scarf',
//     //   price: 19.99,
//     //   date: DateTime.now(),
//     // ),
//     // Transaction(
//     //   id: 'p5',
//     //   title: 'shoes',
//     //   price: 19.99,
//     //   date: DateTime.now(),
//     // ),
//     // Transaction(
//     //   id: 'p6',
//     //   title: 'Yellow Scarf',
//     //   price: 19.99,
//     //   date: DateTime.now(),
//     // ),
//   ];
//   List<Transaction> get item {
//     //http.get(url)
//     return _items.toList();
//   }

//   // Future<void> fetchAndSetProducts() async {
//   //   const url = "https://group-expense-a0ce5.firebaseio.com/transaction.json";
//   //   try {
//   //     final response = await http.get(url);
//   //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
//   //     final List<Transaction> loadedProducts = [];
//   //     extractedData.forEach((prodId, prodData) {

//   //       loadedProducts.add(Transaction(
//   //         id: prodId,
//   //         title: prodData['title'],
//   //         price: double.parse(prodData['price']),
//   //         isSelected: prodData['isSelected'],
//   //         date: DateTime.parse(prodData['date']),
//   //       ));
//   //     });
//   //     _items = loadedProducts;
//   //     notifyListeners();
//   //   } catch (error) {
//   //     print(error);
//   //     throw (error);
//   //   }
//   // }

//   void addTransaction(Transaction expense) {
//     // const url = "https://group-expense-a0ce5.firebaseio.com/transaction.json";
//     // try {
//     //   await http.post(url,
//     //       body: json.encode({
//     //         'id': expense.id,
//     //         'title': expense.title,
//     //         'price': expense.price,
//     //         'date': expense.date.toString(),
//     //         'isSelected': expense.isSelected,
//     //         // 'member' : expense.members
//     //       }));
//     //   print(
//     //       "safdnkjaesbfjkbawkjgfbkjsbadzkjfb awskgjbvkjsadbfjwkjasdbfkjbsgadjbgjkragkjbjkdn");
//     //   _items.add(expense);
//     //   notifyListeners();
//     // } catch (error) {
//     //   print("error=");
//     //   print(error);
//     //   throw error;
//     // }

//     final newExpense = Transaction(
//       id: DateTime.now().toString(),
//       title: expense.title,
//       date: expense.date,
//       price: expense.price,
//       isSelected: expense.isSelected,
//       members: expense.members,
//     );
//     _items.add(newExpense);
//     notifyListeners();
//   }

//   void deleteTransaction(String id) {
//     // final url =
//     //     "https://group-expense-a0ce5.firebaseio.com/transaction/$id.json";
//     final existingProductIndex = _items.indexWhere((trans) => trans.id == id);
//     var existingProduct = _items[existingProductIndex];
//     _items.removeAt(existingProductIndex);
//     notifyListeners();
//     // final response = await http.delete(url);
//     // if (response.statusCode >= 400) {
//     //   _items.insert(existingProductIndex, existingProduct);
//     //   notifyListeners();
//     //   throw Exception();
//     // }
//     // existingProduct = null;
//   }

//   void updateProduct(String id, Transaction newTransaction) {
//     final transIndex = _items.indexWhere((prod) => prod.id == id);
//     if (transIndex >= 0) {
//       _items[transIndex].id = newTransaction.id;
//       _items[transIndex].isSelected = newTransaction.isSelected;
//       _items[transIndex].members = newTransaction.members;
//       _items[transIndex].price = newTransaction.price;
//       _items[transIndex].title = newTransaction.title;
//     }

//     // if (transIndex >= 0) {
//     //   final url =
//     //       "https://group-expense-a0ce5.firebaseio.com/transaction/$id.json";
//     //   try {
//     //     await http.patch(url,
//     //         body: json.encode({
//     //           'id': newTransaction.id,
//     //           'title': newTransaction.title,
//     //           'price': newTransaction.price,
//     //           'date': newTransaction.date.toString(),
//     //           'isSelected': newTransaction.isSelected,
//     //         }));
//     //     _items[transIndex] = newTransaction;
//     //     notifyListeners();
//     //   } catch (error) {
//     //     print(error);
//     //   }
//     // } else {
//     //   print('...');
//     // }
//   }

//   Transaction findById(String id) {
//     print('id');
//     return _items.firstWhere((trans) => trans.id == id);
//   }
// }