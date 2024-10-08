
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_u_admin/global.dart';
import 'package:on_u_admin/models/counselor.dart';
import 'package:on_u_admin/models/user.dart';
import 'package:on_u_admin/util/counselorInfo.dart';




class UserController extends GetxController with GetTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();
  RxList<User> item = <User>[].obs;
  RxList<User> user = <User>[].obs;
  RxList<User> store = <User>[].obs;
  RxList<User> approval = <User>[].obs;

  RxList<Counselor> counselorList = <Counselor>[].obs;
  RxList<Counselor> filteredCounselorList = <Counselor>[].obs;

  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose(){

    super.onClose();
  }

  init() async{
    counselorList.value = await CounselorInfo().getCounselorList();
    filteredCounselorList.value = counselorList;
  }

  searchUser() {
    filteredCounselorList.value = counselorList.where((element) => element.name.contains(searchController.text)).toList();
  }
  
  deleteCounselor(String documentId) async {
    await CounselorInfo().deleteCounselor(documentId);
    counselorList.value = await CounselorInfo().getCounselorList();
    filteredCounselorList.value = counselorList;
  }
  
  updateCounselor(String documentId, {String? name, String? body, String? info, String? title}) async {
    await CounselorInfo().updateCounselor(documentId, name: name, body: body, info: info, title: title);
    counselorList.value = await CounselorInfo().getCounselorList();
    filteredCounselorList.value = counselorList;
  }

  addCounselor(String email, String password, String name, String title) async {
    await CounselorInfo().addCounselor(email, password, name, title);
    counselorList.value = await CounselorInfo().getCounselorList();
    filteredCounselorList.value = counselorList;
  }
  
  updateCounselorDialog(BuildContext context, String documentId) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    TextEditingController infoController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('상담사 정보 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: '이름',
                ),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: '상담사 소개',
                ),
              ),
              TextField(
                controller: infoController,
                decoration: const InputDecoration(
                  hintText: '상담사 정보',
                ),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: '상담사 전문 분야',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                updateCounselor(documentId, name: nameController.text, body: bodyController.text, info: infoController.text, title: titleController.text);
                Get.back();
              },
              child: const Text('수정'),
            ),
          ],
        );
      },
    );
  }

  addCounselorDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();

    Rx<bool> isEmail = false.obs;
    Rx<bool> isPassword = false.obs;
    Rx<bool> isName = false.obs;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('상담사 추가'),
          content: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('존재하지 않는 이메일 입력 시 비밀번호 찾기가 불가능합니다.', style: const TextStyle(color: Colors.red, fontSize: 10),),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: '이메일',
                  ),
                ),
                isEmail.value ?  Container(): const Text('이메일 양식을 확인해주세요.', style: const TextStyle(color: Colors.red, fontSize: 10),),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: '비밀번호',
                  ),
                ),
                isPassword.value ? Container() : const Text('비밀번호는 6자리 이상 입력해주세요.', style: const TextStyle(color: Colors.red, fontSize: 10),),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: '이름',
                  ),
                ),
                isName.value ? Container() : const Text('이름을 입력해주세요.', style: const TextStyle(color: Colors.red, fontSize: 10),),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: '전문상담분야',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                bool isValidEmail(String email) {
                  // 정규식 패턴
                  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(pattern);

                  // 이메일이 정규식에 맞는지 확인
                  return regex.hasMatch(email);
                }
                if(isValidEmail(emailController.text)) {
                  isEmail.value = true;
                }
                if(passwordController.text.length > 5) {
                  isPassword.value = true;
                }
                if(nameController.text.isNotEmpty) {
                  isName.value = true;
                }
                if(isEmail.value && isPassword.value && isName.value) {
                  addCounselor(emailController.text, passwordController.text, nameController.text, titleController.text);
                  Get.back();
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }


  Widget userInfoTab (size){
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: size.width,
      height: 40,
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          )
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 250,
            child: const Text(
                '프로필 사진'
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 200,
            child: const Text(
                '이메일'
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 400,
            child: const Text(
                '상담원 소개'
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            child: const Text(
                '가입일'
            ),
          ),
        ],
      ),
    );
  }
}
