// 화면이랑 1대1로 매칭되는(화면에 뿌려질) 데이터 model

// 1. 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListModel {
  List<Post> posts;

  PostListModel(this.posts);
}

// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super._state, this.ref);

  // Ref 토큰을 repository로 넘기기위해 끌고옴
  Ref ref;

  // state값이 변경되면 view에 알려(notify)줌
  Future<void> notifyInit() async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListModel(responseDTO.data);
  }
}

// 3. 창고 관리자 << read나 watch가 발동할때 생성됨
// read나 watch는 보통 View가 빌드되기 직전에 실행됨

final postListProvider =
    StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
