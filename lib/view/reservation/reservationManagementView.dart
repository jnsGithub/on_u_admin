import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/view/reservation/reservationManagementController.dart';

class ReservationManagementView extends GetView<ReservationManagementController> {
  const ReservationManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => ReservationManagementController());
    double dateWidth = 150;
    double counselorWidth = 150;
    double userWidth = 150;
    double requestWidth = 100;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: size.width,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide()
                  )
              ),
              child: const Text('상담 예약 현황 관리',style: TextStyle(
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
                          controller.searchReservation();
                        },
                      ),
                    ),
                    onSubmitted: (String value) {
                      controller.searchReservation();
                    },
                  ),
                ),



                IconButton(
                    onPressed: (){
                      controller.init();
                    },
                    icon: const Icon(Icons.replay)
                )
              ],
            ),
            // controller.userInfoTab(size),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  width: dateWidth,
                  child: Text('예약 날짜', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 20),
                Container(
                  width: counselorWidth,
                  child: Text('상담사', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 20),
                Container(
                  width: userWidth,
                  child: Text('예약자', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 20),
                Container(
                  width: requestWidth,
                  child: Text('상담내용', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            Container(
              width: size.width,
              height: 800,
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredReservationList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide()
                          )
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: dateWidth,
                            child: Text('${controller.filteredReservationList[index].createDate.toString().substring(0, 16)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: counselorWidth,
                            child: Text('${controller.filteredReservationList[index].counselorName}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: userWidth,
                            child: Text('${controller.filteredReservationList[index].userName}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: size.width*0.5,
                            child: Text('${controller.filteredReservationList[index].request}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
