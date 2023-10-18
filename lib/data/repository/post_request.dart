// final가 default로 들어가고 바꿀것에 final 키워드를 제거한다.
class PostSaveReqDTO {
  final String title;
  final String content;

  PostSaveReqDTO({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}

class PostUpdateReqDTO {
  final String title;
  final String content;

  PostUpdateReqDTO({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
