// 1. 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PostDetailModel {
  Post post;
  int? id;

  PostDetailModel(this.post);
}

// 2. 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  PostDetailViewModel(super._state, this.ref);

// Ref 토큰을 repository로 넘기기위해 끌고옴
  Ref ref;

  // <2번 방식> 여기 init의 목적은 통신이 아닌 post를 전달 받아서 state를 변화시키는것
  void init(Post post) {
    state = PostDetailModel(post);
  }

  Future<void> notifyInit(int id) async {
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailModel(responseDTO.data);
  }
}

// 3. 창고 관리자
// family << 창고 관리자에게 바로 데이터값을 전달해주는 기법
// family는 값을 notifyInit안에 바로 넘기기 위해 사용 << 패턴을 유지할수 있다.
// 창고 관리자 내부 ref변수를 이용해서 다른 창고에있는 값에 접근가능. << 창고의 결합
// 창고의 결합은 생성자를 넘기지 않지만, 코드가 복잡해지고 아키텍쳐를 해칠 가능성이 있다.
final postDetailProvider =
    StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>(
        (ref) {
  int postId = ref.read(paramProvider).postDetailId!;
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
