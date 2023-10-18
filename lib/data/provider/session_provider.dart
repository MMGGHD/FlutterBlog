import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../_core/constants/move.dart';
import '../model/user.dart';

// 1. 창고 데이터
class SessionUser {
  // mContext << 화면 context에 접근하기 위한 변수
  final mContext = navigatorKey.currentContext;
  User? user;
  String? jwt;
  bool isLogin;

  SessionUser({this.user, this.jwt, this.isLogin = false});

  // 2. 창고없는대신 창고의 비즈니스 로직을 여기서 처리
  // 화면으로 응답을 하지 않기 때문에 return값이 void
  Future<void> join(JoinReqDTO joinReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);

    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text(responseDTO.msg)),
      );
    }
  }

  // 화면으로 응답을 하지 않기 때문에 return값이 void
  Future<void> login(LoginReqDTO loginReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);

    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      // 로그인 성공하면
      // 1. 세션값을 갱신해줘야함
      this.user = User.fromJson(responseDTO.data);
      this.jwt = responseDTO.token;
      this.isLogin = true;

      // 2. 디바이스에 jwt저장 << 나중에 자동 로그인 되기 위함
      // 토큰이 유효한지 검증하는 주소-컨트롤러가 존재하는 앱도있다.
      // 저장은 오래걸리는 일 << await 없으면 저장되기 전에 페이지로 이동해버림
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 3. 페이지 이동
      Navigator.pushNamed(mContext!, Move.postListPage);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text(responseDTO.msg)),
      );
    }
  }

  // 로그아웃 << 토큰방식은 서버에 상태가 없기 때문에 할수 있는 일이 없다.
  // 토큰을 기기에서 없애 버리면 그게 로그아웃
  Future<void> logout() async {
    this.jwt = null;
    this.isLogin = false;
    this.user = null;

    // secureStorage(내부 저장 토큰) 삭제 << IO가 발생하기 때문에 await걸어줌
    await secureStorage.delete(key: "jwt");

    // Navigator의 종류 공부해야함
    Navigator.pushNamedAndRemoveUntil(mContext!, "/login", (route) => false);
  }
}

// 3. 창고 관리자
final sessionProvider = Provider<SessionUser>((ref) {
  return SessionUser();
});
