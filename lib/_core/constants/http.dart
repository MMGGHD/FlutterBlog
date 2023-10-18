import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// http 통신
final dio = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.51:8080", // 내 IP 입력
    contentType: "application/json; charset=utf-8",
  ),
);

// 휴대폰 로컬에 파일로 저장 << jwt등이 저장될 공간임
const secureStorage = FlutterSecureStorage();
