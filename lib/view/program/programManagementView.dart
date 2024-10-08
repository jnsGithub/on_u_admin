import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/view/program/programManagementController.dart';

class ProgramManagementView extends GetView<ProgramManagementController> {
  const ProgramManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => ProgramManagementController());
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
              child: const Text('프로그램 안내 관리',style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          controller.addProgramDialog(context);
                        },
                        icon: const Icon(Icons.add)),
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
            Container(
              width: size.width,
              height: 800,
              child:
              Obx(() => ListView.separated(
                    itemCount: controller.programList.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (context, index) {
                      String url = controller.programList[index].photoURL[0];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){

                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(controller.programList[index].photoURL[0]),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        // right: BorderSide(),
                                      )
                                  ),
                                  child: Text(
                                    controller.programList[index].title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 600,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                      )
                                  ),
                                  child: Text(
                                    controller.programList[index].body,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10, height: 50,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: (){
                                      controller.updateProgramDialog(context, index);
                                    },
                                    icon: Icon(Icons.edit)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: (){
                                      controller.deleteProgram(controller.programList[index].documentId);
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                            ],
                          ),
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
