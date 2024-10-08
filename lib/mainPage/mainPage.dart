import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global.dart';
import 'mainController.dart';





class MainPage extends GetView<MainController> {
  const MainPage ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => MainController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:

        Container(
          width: size.width,
          height: size.height,
          child: Row(
            children: [
              Container(
                width: 300,
                height: size.height,
                decoration: const BoxDecoration(
                  color: bgColor,
                ),
                child:  Column(
                  children: [
                    SizedBox(height: 60,),
                    Container(
                      width: 146,
                      height: 75,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.fitWidth
                          )
                      ),
                    ),
                    Text('ON:U 관리자 페이지', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: typoColor),),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 300,
                      height: 400,
                      child:
                        ListView.builder(
                            itemCount: controller.menuItem.length,
                            itemBuilder: (context, index) {
                              return Obx(()=>
                                GestureDetector(
                                  onTap: (){
                                    controller.changeMenu(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: controller.menuIndex.value == index? mainColor : null
                                    ),
                                    child: Text('${controller.menuItem[index]}',style:
                                    TextStyle(
                                        color: controller.menuIndex.value == index ? Colors.white:null,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  ),
                                ),
                              );
                            }),
                      ),

                    TextButton(
                        onPressed: (){
                          // storage.deleteAll();
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         MyHomePage(title: '')), (route) => false);
                        },
                        child: const Text('로그아웃',style: TextStyle(color: Colors.black),)
                    )
                  ],
                ),
              ),
              Obx(() => Expanded(
                  child: controller.menuWidget[controller.menuIndex.value],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
