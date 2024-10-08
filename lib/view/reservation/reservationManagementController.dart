import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/models/reservation.dart';
import 'package:on_u_admin/util/reservationInfo.dart';

class ReservationManagementController extends GetxController{
  RxInt a = 0.obs;
  RxList<Reservation> reservationList = <Reservation>[].obs;
  RxList<Reservation> filteredReservationList = <Reservation>[].obs;
  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    reservationList.value = await ReservationInfo().getReservationList();
    filteredReservationList.value = reservationList;
  }
  
  searchReservation() {
    filteredReservationList.value = reservationList.where((element) => element.userName.contains(searchController.text) || element.counselorName.contains(searchController.text)).toList();
  }
}