import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/constants/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO:1 위젯이 아닌곳에서 현재화면의 Context에 접근해주는 객체
// ViewModel과 같은 buildContext가 없는 객체에 Context를 넘겨주지 않아도 접근가능
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey << context가 없는 곳에서 context를 사용할 수 있는 방법 ( 아직몰라도 됨)
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Move.loginPage,
      routes: getRouters(),
      theme: theme(),
    );
  }
}
