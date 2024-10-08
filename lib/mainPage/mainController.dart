import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/view/companyManagement/companyManagementView.dart';
import 'package:on_u_admin/view/program/programManagementView.dart';
import 'package:on_u_admin/view/reservation/reservationManagementView.dart';
import 'package:on_u_admin/view/user/userPage.dart';




class MainController extends GetxController {
  RxList menuItem = ['상담원 관리','회사 관리','프로그램 안내 관리', '간편 심리검사 결과 관리', '상담 예약 현황 관리'].obs;
  RxList menuWidget = [UserPage(),CompanyManagementView(),ProgramManagementView(),UserPage(), ReservationManagementView()].obs;

  //[UserPage(),StorePage(),PaymentPage(),CalculatePage()];
  RxInt menuIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  changeMenu(i) {
    menuIndex.value = i;
    update();
  }
}
