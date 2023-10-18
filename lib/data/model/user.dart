// model << 서버쪽에서 전달해주는 Entity, 필수적인것은 아님

import 'package:intl/intl.dart';

class User {
  int id;
  String username;
  String email;
  DateTime created;
  DateTime updated;

  // (PDF) - 31P
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.created,
      required this.updated});

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "created": created,
        "updated": updated,
      };
  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 필드가 초기화 되기 전에 변수를 받아야 하므로 이니셜라이져 키워드 써야함
  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        email = json["email"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]), // 3
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}
