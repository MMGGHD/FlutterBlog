import 'package:flutter/material.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListBody extends ConsumerWidget {
  const PostListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostListModel? model = ref.watch(postListProvider);

    List<Post> posts = [];

    if (model != null) {
      posts = model.posts;
    }

    return ListView.separated(
      // separated 는 줄 그어주는것
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // // <2번 방식> 선택된 Post를 창고에 저장하려면 여기 타이밍에서 저장한다.
            // ref.read(postDetialProvider.notifier).init(posts[index]);
            // read는 읽을때 처음 객체를 로드한 그 상태를 싱글톤으로 읽는다.

            // // <3번 방식> Detail 창고관리자에게 id값 전달
            // // family 함수를 쓰면 notifier를 사용하지 않아도 값을 바로 전달할수 있다.
            // // 하지만 값을 전달하기 불편하다.
            // ref.read(postDetailProvider(posts[index].id));

            // postId를 paramStore에 저장
            ParamStore paramStore = ref.read(paramProvider);
            paramStore.postDetailId = posts[index].id;

            // PostDetailPage는 유동적이라 라우터 주소 설정이 안됨 << PushName을 쓰지 않는다.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailPage(),
              ),
            );
          },
          // itemBuilder의 Index
          child: PostListItem(posts[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
