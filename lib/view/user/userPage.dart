import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_u_admin/component/userInfo/column.dart';
import 'package:on_u_admin/global.dart';
import 'package:on_u_admin/models/user.dart';
import 'package:on_u_admin/view/user/userController.dart';





class UserPage extends GetView<UserController> {
  const UserPage ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => UserController());
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: size.width,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide()
                  )
              ),
              child: const Text('상담원 관리',style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      labelText: '상담원 명',
                      labelStyle: const TextStyle(
                          color: Colors.black26
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {
                          controller.searchUser();
                        },
                      ),
                    ),
                    onSubmitted: (String value) {
                      controller.searchUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          controller.addCounselorDialog(context);
                        },
                        icon: Icon(Icons.add)),
                    IconButton(
                        onPressed: (){
                          controller.init();
                        },
                        icon: const Icon(Icons.replay)
                    ),
                  ],
                )
              ],
            ),
            // controller.userInfoTab(size),
            SizedBox(height: 20,),
            Container(
              width: size.width,
              height: 800,
              child: Obx(() => ListView.separated(
                  itemCount: controller.filteredCounselorList.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    // DateTime dateTime = controller.item[index].creatDate.toDate();
                    // DateFormat dateFormat = DateFormat('yyyy.MM.dd', 'ko');
                    // String formattedDate = dateFormat.format(dateTime);
                    // User userInfo = controller.item[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(controller.filteredCounselorList[index].photoURL),
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 200,
                              height: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Columns(context, '이메일', 'asd@asd.asd'),
                                  Columns(context, '이름 ', controller.filteredCounselorList[index].name),
                                  Columns(context, '상담분야', controller.filteredCounselorList[index].title),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('상담사 소개',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 600,
                                  child: Text(
                                    controller.filteredCounselorList[index].body,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                    maxLines: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // 유저 삭제 및 수정 버튼
                        // const SizedBox(width: 10),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width:50,
                        //       child: IconButton(
                        //           onPressed: (){
                        //             controller.updateCounselorDialog(context,controller.filteredCounselorList[index].documentId);
                        //           },
                        //           icon: const Icon(Icons.edit,color: mainColor,)
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width:50,
                        //       child: IconButton(
                        //           onPressed: (){
                        //             controller.deleteCounselor(controller.filteredCounselorList[index].documentId);
                        //           },
                        //           icon: const Icon(Icons.delete,color: mainColor,)
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    );
                  }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
