import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/global.dart';
import 'loginController.dart';





class Login extends GetView<LoginController> {
  const Login ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 123,
              decoration: const BoxDecoration(
                color: mainColor,
                  // image: DecorationImage(
                      // image: AssetImage('images/logo.png'),
                  //     fit: BoxFit.fitWidth
                  // )
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text('아이디', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: mainColor
                ),),
                const SizedBox(
                  height: 9,
                ),
                Container(
                  width: 358,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xfff6f6fa)),
                  child: TextField(
                    controller: controller.idController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffAEAEB2)),
                      border: InputBorder.none,
                      // 밑줄 없애기
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      // TextField 내부의 패딩 적용
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: mainColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text('비밀번호', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: mainColor
                ),),
                const SizedBox(
                  height: 9,
                ),
                Container(
                  width: 358,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xfff6f6fa)),
                  child: TextFormField(
                    obscureText: true,
                    onFieldSubmitted: (e) {
                      // login(context);
                    },
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // 밑줄 없애기
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      // TextField 내부의 패딩 적용
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: mainColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/mainPage');
                // login(context);
              },
              child: Container(
                width: 358,
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 80),
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.white)
                ),
                child: const Text('로그인', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white
                ),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
