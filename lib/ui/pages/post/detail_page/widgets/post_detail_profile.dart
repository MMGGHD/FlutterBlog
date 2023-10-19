import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/model/post.dart';

class PostDetailProfile extends StatelessWidget {
  const PostDetailProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("작성자"),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset('assets/default_profile.png'),
        ),
        subtitle: Row(
          children: [
            Text("이메일"),
            const SizedBox(width: mediumGap),
            const Text("·"),
            const SizedBox(width: mediumGap),
            const Text("Written on "),
            Text("May 25"),
          ],
        ));
  }
}
