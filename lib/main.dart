import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/ExpandedScreens/particular_member_transactions.dart';
import 'package:flutter_complete_guide/ExpandedScreens/show_members.dart';

import './Widget/selectmember.dart';
import './ExpandedScreens/splash_screen.dart';
import './ExpandedScreens/members_transactions.dart';
import './ExpandedScreens/tabbar.dart';
import 'package:provider/provider.dart';
import './provider/transactions.dart';
import './provider/memberfunctions.dart';
import './provider/auth.dart';
import './Widget/auth_screen.dart';
import './ExpandedScreens/show_members.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Transactions>(
          create: (_) => Transactions(),
          update: (_, auth, products) => products..authToken = auth.token,
        ),
        // ChangeNotifierProxyProvider<Auth, Members>(
        //   create: (_) => Members(),
        //   update: (_, auth, members) => members..authToken = auth.token,
        // ),
        ChangeNotifierProvider.value(value: Members()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? TabBarr()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          //  home: TabBarr(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            TabBarr.routeName: (ctx) => TabBarr(),
            SelectMember.routeName: (ctx) => SelectMember(),
            MemberTransactions.routeName: (ctx) => MemberTransactions(),
            ShowMembers.routeName: (ctx) => ShowMembers(),
            ParticularMemberTransactions.routeName: (ctx)=> ParticularMemberTransactions(),
          },
        ),
      ),
    );
  }
}
