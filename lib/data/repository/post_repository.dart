// View는 Provider(ViewModel)에게
// Provider는 Repository에 요청해서 통신데이터 받음
import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/repository/post_request.dart';

class PostRepository {
  Future<ResponseDTO> fetchPostList(String jwt) async {
    // 통신은 무조건 try-catch
    try {
      // 1. 통신
      // Request에 Body없음, 헤더에 토큰값을 가지고 가야함
      final response = await dio.get("/post",
          options: Options(headers: {"Authorization": "${jwt}"}));

      // 2. 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 3. ResponseDTO의 data파싱
      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();

      // 4. 파싱된 데이터를 다시 공통 DTO로 덮어 씌우기
      responseDTO.data = postList;

      return responseDTO;
    }
    // 200이 아니면 catch로 감
    catch (e) {
      return ResponseDTO(-1, "중복되는 유저명입니다.", null);
    }
  }

  // 글 작성 요청하는 DTO
  Future<ResponseDTO> fetchPost(String jwt, PostSaveReqDTO dto) async {
    // 통신은 무조건 try-catch
    try {
      // 1. 통신
      // Request에 Body 데이터와 헤더 토큰값을 가지고 가야함
      // response안에 서버 측 응답으로 받은 http헤더와 body있음
      final response = await dio.post("/post",
          // data에 Map넣으면 자동으로 JSON으로 변환됨
          data: dto.toJson(),
          options: Options(headers: {"Authorization": "${jwt}"}));

      // 2. 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 3. ResponseDTO의 data파싱
      Post post = Post.fromJson(responseDTO.data);

      // 4. 파싱된 데이터를 다시 공통 DTO로 덮어 씌우기
      responseDTO.data = post;

      return responseDTO;
    }
    // 200이 아니면 catch로 감
    catch (e) {
      return ResponseDTO(-1, "게시글 작성 실패.", null);
    }
  }
}
