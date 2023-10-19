import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_buttons.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_content.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_profile.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailBody extends ConsumerWidget {
  const PostDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // // <2번 방식> read, watch는 창고의 상태값에 바로 접근이 가능함
    // PostDetailModel? pdm = ref.read(postDetialProvider);
    // PostDetailModel? pdm2 = ref.watch(postDetialProvider);
    // // <2번 방식> read(창고관리자)의 notifier는 '창고에' 접근 하는것
    // ref.read(postDetialProvider.notifier);
    //
    // // <2번 방식> 일단 한번만 접근할것이기 때문에 read.로 상태값에 바로 접근
    // Post post = pdm!.post;

    PostDetailModel? model = ref.watch(postDetailProvider);

    Post post;

    if (model == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    } else {
      post = model!.post;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          PostDetailTitle("${post.title}"),
          const SizedBox(height: largeGap),
          PostDetailProfile(),
          PostDetailButtons(),
          const Divider(),
          const SizedBox(height: largeGap),
          PostDetailContent("${post.content}"),
        ],
      ),
    );
  }
}
