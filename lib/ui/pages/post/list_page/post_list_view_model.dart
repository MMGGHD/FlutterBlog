// 화면이랑 1대1로 매칭되는(화면에 뿌려질) 데이터 model

// 1. 창고 데이터
import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/data/repository/post_request.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListModel {
  List<Post> posts;
  PostListModel(this.posts);
}

// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super._state, this.ref);

  final mContext = navigatorKey.currentContext;

  // Ref 토큰을 repository로 넘기기위해 끌고옴
  Ref ref;

  // state값이 변경되면 view에 알려(notify)줌
  Future<void> notifyInit() async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListModel(responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO dto) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO =
        await PostRepository().savePost(sessionUser.jwt!, dto);

    if (responseDTO.code == 1) {
      // responseDTO는 dynamic타입, 실제로는 data가 Post타입 (묵시적 다운캐스팅이 가능)
      // as Post; 뒤에 붙여두면 명시적 다운캐스팅도 가능
      // 묵시적이라도 캐스팅 해야하므로 newPost에 대입하는 코드가 반드시 분리되어야함
      Post newPost = responseDTO.data;
      List<Post> posts = state!.posts;
      // newPost가 가장 앞으로
      // ...posts << posts라는 리스트를 흩뿌린것(전개연산자)
      List<Post> newPosts = [newPost, ...posts];
      // 생성자로 posts에 newPosts를 넣은 PostListModel을 새로 new하고 상태로 준것
      state = PostListModel(newPosts);
      // 이 부분에서 뷰모델 데이터 갱신이 완료 << watch 구독자가 rebuild됨
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
          content: Text("게시물 작성 실패 : ${responseDTO.msg}"),
        ),
      );
    }
  }
}

// 3. 창고 관리자 << read나 watch가 발동할때 생성됨
// read나 watch는 보통 View가 빌드되기 직전에 실행됨

// autoDispose << View가 사라지면 창고와 관리자객체도 제거(가비지 컬렉션으로ㄱ)
final postListProvider =
    StateNotifierProvider.autoDispose<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
