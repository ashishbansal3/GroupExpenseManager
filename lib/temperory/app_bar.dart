// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/auth.dart';
// import '../ExpandedScreens/my_transactions.dart';

// class AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           AppBar(
//             title: Text('Hello Friend!'),
//             automaticallyImplyLeading: false,
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.attach_money),
//             title: Text('My Transactions'),
//             onTap: () {
//               Navigator.of(context).pushNamed(MyTransactions.routeName);
//             },
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pushReplacementNamed('/');

//               // Navigator.of(context)
//               //     .pushReplacementNamed(UserProductsScreen.routeName);
//               Provider.of<Auth>(context, listen: false).logout();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
