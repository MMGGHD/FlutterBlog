import 'package:flutter/material.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_body.dart';
import 'package:flutter_blog/ui/widgets/custom_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 로그인이 완료되면 이 페이지로옴
// 여기로 이동할때 통신이 발동되어 데이터가 뿌려져야함
class PostListPage extends ConsumerWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomNavigation(scaffoldKey),
      appBar: AppBar(
        title: Text("Blog"),
      ),
      // RefreshIndicator << 아래로 잡아당기면 이벤트 발생
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          // Logger().d() << debug의 약자
          Logger().d("리프레시 됨");
          // 창고에 "내용6"이라는 글이 들어오면 postListProvider가 watch로 감지
          // read해서 notifyInit(초기값 갱신)하면 갱신 데이터를 뷰에 뿌려줌
          // notifyInit을 read해라 << 즉, 갱신(리빌드)해라
          ref.watch(postListProvider.notifier).notifyInit();
        },
        child: PostListBody(),
      ),
    );
  }
}
