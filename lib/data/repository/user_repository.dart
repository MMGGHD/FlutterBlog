// View는 Provider(ViewModel)에게
// Provider는 Repository에 요청해서 통신데이터 받음
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/model/user.dart';

class UserRepository {
  Future<ResponseDTO> fetchJoin(JoinReqDTO requestDTO) async {
    // 통신은 무조건 try-catch
    try {
      final response = await dio.post("/join", data: requestDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // 파싱한 user객체를 responseDTO.data에 다시 담아줌
      // responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    }
    // 200이 아니면 catch로 감
    catch (e) {
      return ResponseDTO(-1, "중복되는 유저명입니다.", null);
    }
  }

  Future<ResponseDTO> fetchLogin(LoginReqDTO requestDTO) async {
    // 통신은 무조건 try-catch
    try {
      // response에는 헤더(hearders)와 바디(data)가 둘다 들어있다.
      final response = await dio.post("/login", data: requestDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 헤더에 있는 토큰을 꺼내서 다른곳에 전달하기 위한 로직
      final jwt = response.headers["Authorization"];

      // final로 적힌 헤더의 원래 타입은 Map<String, List<String>?> 타입 (쿠키값 때문)
      // List<String>?를 반환 받아서 first로 첫 값을 꺼내어 저장
      if (jwt != null) {
        responseDTO.token = jwt.first;
      }

      return responseDTO;
    }
    // 200이 아니면 catch로 감
    catch (e) {
      return ResponseDTO(-1, "유저네임 또는 비밀번호가 틀렸습니다.", null);
    }
  }
}
