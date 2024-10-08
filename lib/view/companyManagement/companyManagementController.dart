import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/models/company.dart';
import 'package:on_u_admin/util/companyInfo.dart';

class CompanyManagementContoller extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxInt a = 0.obs;
  
  RxList<Company> companyList = <Company>[].obs;
  RxList<Company> filteredCompanyList = <Company>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async{
    companyList.value = await CompanyInfo().getCompanyList();
    filteredCompanyList.value = companyList;
  }

  searchCompany() {
    filteredCompanyList.value = companyList.where((element) => element.documentId.contains(searchController.text)).toList();
  }

  addCompany(String companyName, int ticket) async {
    await CompanyInfo().addCompany(companyName, ticket);
    companyList.value = await CompanyInfo().getCompanyList();
  }

  updateCompany(String companyName, int ticket) async {
    await CompanyInfo().updateCompany(companyName, ticket);
    companyList.value = await CompanyInfo().getCompanyList();
  }

  deleteCompany(String companyName) async {
    await CompanyInfo().deleteCompany(companyName);
    companyList.value = await CompanyInfo().getCompanyList();
  }

  addCompanyDialog(BuildContext context){
    TextEditingController companyNameController = TextEditingController();
    TextEditingController ticketController = TextEditingController();

    RxBool isNumeric = true.obs;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회사 추가'),
          content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: companyNameController,
                  decoration: InputDecoration(
                    hintText: '회사명',
                  ),
                ),
                TextField(
                  controller: ticketController,
                  decoration: InputDecoration(
                    hintText: '티켓 수',
                  ),
                  onSubmitted: (String value) {
                    if(ticketController.text.isNumericOnly == false){
                      isNumeric.value = false;
                      return;
                    }
                    addCompany(companyNameController.text, ticketController.text == '' ? 0 : int.parse(ticketController.text));
                    Navigator.pop(context);
                  },
                ),
                isNumeric.value == false ? Text('숫자만 입력해주세요.', style: TextStyle(color: Colors.red, fontSize: 10),) : Container(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                if(ticketController.text.isNumericOnly == false){
                  isNumeric.value = false;
                  return;
                }
                addCompany(companyNameController.text, ticketController.text == '' ? 0 : int.parse(ticketController.text));
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  updateCompanyDialog(BuildContext context, String companyName){
    TextEditingController ticketController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회사 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ticketController,
                decoration: InputDecoration(
                  hintText: '티켓 수',
                ),
                onSubmitted: (String value) {
                  updateCompany(companyName, ticketController.text == '' ? 0 : int.parse(ticketController.text));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                updateCompany(companyName, ticketController.text == '' ? 0 : int.parse(ticketController.text));
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  deleteCompanyDialog(BuildContext context, String companyName){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회사 삭제'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('정말 ${companyName}을 삭제하시겠습니까?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                deleteCompany(companyName);
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}