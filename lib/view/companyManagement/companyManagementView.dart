import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/global.dart';
import 'package:on_u_admin/view/companyManagement/companyManagementController.dart';

class CompanyManagementView extends GetView<CompanyManagementContoller> {
  const CompanyManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => CompanyManagementContoller());
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
              child: const Text('회사 관리',style: TextStyle(
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
                      labelText: '회사 명',
                      labelStyle: const TextStyle(
                          color: Colors.black26
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {
                          controller.searchCompany();
                        },
                      ),
                    ),
                    onSubmitted: (String value) {
                      controller.searchCompany();
                    },
                  ),
                ),
      
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          controller.addCompanyDialog(context);
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: (){
                          // init();
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
              child: Obx(() => ListView.separated(
                    itemCount: controller.filteredCompanyList.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 250,
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(),
                                    )
                                ),
                                child: SelectableText(
                                  controller.filteredCompanyList[index].companyCode,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 200,
                                decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(),
                                    )
                                ),
                                child: Text(
                                  controller.filteredCompanyList[index].documentId,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 200,
                                decoration: const BoxDecoration(
                                    border: Border(
                                    )
                                ),
                                child: Text(
                                  controller.filteredCompanyList[index].ticket.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10, height: 50,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: (){
                                      controller.updateCompanyDialog(context, controller.filteredCompanyList[index].documentId);
                                    },
                                    icon: Icon(Icons.edit)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: (){
                                      controller.deleteCompanyDialog(context, controller.filteredCompanyList[index].documentId);
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
