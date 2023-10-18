import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/ui/widgets/custom_auth_text_form_field.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/provider/session_provider.dart';

class JoinForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  // 사용자가 입력한 값을 받아오기 위한 변수, Controller로 받아옴
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  JoinForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 모든것을 Form으로 감싼다.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomAuthTextFormField(
            text: "Username",
            obscureText: false,
            funValidator: validateUsername(),
            controller: _username,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Email",
            obscureText: false,
            funValidator: validateEmail(),
            controller: _email,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Password",
            obscureText: true,
            funValidator: validatePassword(),
            controller: _password,
          ),
          const SizedBox(height: largeGap),
          // Form태그 안에있는 버튼
          CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              // 유효성 검사 코드
              if (_formKey.currentState!.validate()) {
                JoinReqDTO joinReqDTO = JoinReqDTO(
                  username: _username.text,
                  password: _password.text,
                  email: _email.text,
                );
                // Provider를 호출
                ref.read(sessionProvider).join(joinReqDTO);
              }
            },
          ),
        ],
      ),
    );
  }
}
