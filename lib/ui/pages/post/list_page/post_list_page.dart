import 'package:flutter/material.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_body.dart';
import 'package:flutter_blog/ui/widgets/custom_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인이 완료되면 이 페이지로옴
// 여기로 이동할때 통신이 발동되어 데이터가 뿌려져야함
class PostListPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomNavigation(scaffoldKey),
      appBar: AppBar(
        title: Text("Blog"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: PostListBody(),
      ),
    );
  }
}
