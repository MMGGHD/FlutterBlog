import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
// 글을 클릭하는 순간 글 ID가 postDetailId에 담긴다.
class RequestParam {
  // 화면 이름 + ID
  int? postDetailId;
  // int? commentId;

  RequestParam({this.postDetailId});
}

// 2. 창고 (창고 데이터를 상속)
class ParamStore extends RequestParam {
  // Store에 기본적으로 navigatorKey가 있으면 이동을 구현하기 좋다.
  final mContext = navigatorKey.currentContext;

  void addPostDetailId(int postId) {
    this.postDetailId = postId;
  }

  void reset() {
    postDetailId = null;
    // commentId = null;
  }
}

// 3. 창고 관리자
final paramProvider = Provider<ParamStore>((ref) {
  return ParamStore();
});
