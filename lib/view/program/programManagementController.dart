import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_admin/models/program.dart';
import 'package:on_u_admin/util/programInfo.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

import 'dart:html' as html;


class ProgramManagementController extends GetxController{
  TextEditingController searchController = TextEditingController();

  RxList<Program> programList = <Program>[].obs;
  RxList<Program> filteredProgramList = <Program>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose(){
    super.onClose();
  }

  Future<Uint8List?> pickImage() async {
    final completer = Completer<Uint8List?>();
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files?.isNotEmpty ?? false) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files![0]);
        reader.onLoadEnd.listen((e) {
          completer.complete(reader.result as Uint8List?);
        });
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }


  init() async{
    programList.value = await ProgramInfo().getProgram();
    filteredProgramList.value = programList;
  }

  searchProgram() {
    filteredProgramList.value = programList.where((element) => element.title.contains(searchController.text)).toList();
  }

  addProgram(String title, String body, List<String> photoURL) async {
    await ProgramInfo().addProgram(title, body, photoURL);
    init();
  }

  updateProgram(String documentId, String title, String body, List<String> photoURL) async {
    await ProgramInfo().updateProgram(documentId, title, body, photoURL);
    init();
  }

  deleteProgram(String documentId) async {
    await ProgramInfo().deleteProgram(documentId);
    init();
  }

  addProgramDialog(BuildContext context){
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        RxList<Uint8List?> image = <Uint8List?>[].obs;
        return AlertDialog(
          title: Text('프로그램 추가'),
          content: SingleChildScrollView(
            child: Container(
              width: 1200,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Obx(() => Container(
                    width: 1000,
                    height: 300,
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: image.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,

                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(image[index]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Uint8List? imageData = await pickImage();
                      if (imageData != null) {
                        image.add(imageData);
                      } else {
                        print("이미지 선택이 취소되었습니다.");
                      }
                    },
                    child: Text('이미지 추가'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('제목', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: '제목을 입력해주세요.',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('내용', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      Container(
                        child: TextField(
                          controller: bodyController,
                          decoration: InputDecoration(
                            hintText: '내용을 입력해주세요.',
                          ),
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                addProgram(titleController.text, bodyController.text, await ProgramInfo().addFirebaseStorageURL(image));
                Navigator.pop(context);
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  updateProgramDialog(BuildContext context, int realIndex){
    TextEditingController titleController = TextEditingController.fromValue(TextEditingValue(text: filteredProgramList[realIndex].title));
    TextEditingController bodyController = TextEditingController.fromValue(TextEditingValue(text: filteredProgramList[realIndex].body));
    RxList<String> tempPhotoURL = filteredProgramList[realIndex].photoURL.obs;
    print('포토 유알엘 : ${tempPhotoURL.length}');
    return showDialog(
        context: context,
        builder: (context) {
          RxList<Uint8List?> image = <Uint8List?>[].obs;
          return AlertDialog(
              title: Text('프로그램 수정'),
              content: SingleChildScrollView(
                child: Container(
                  width: 1200,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Obx(() =>
                          Container(
                            width: 1000,
                            height: 300,
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: tempPhotoURL.length + image.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,

                                ),
                                itemBuilder: (context, index) {
                                  if(!tempPhotoURL[index].contains('firebase')){

                                  }
                                  return Stack(

                                    children: [

                                      Container(
                                        width: 300,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                            image: NetworkImage(tempPhotoURL[index]),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.cancel),
                                            onPressed: () {
                                              tempPhotoURL.removeAt(index);
                                              print('클릭 : ${index}');
                                            },
                                          )),
                                    ],
                                  );
                                }),
                          ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Uint8List? imageData = await pickImage();
                          if (imageData != null) {
                            // image.add(imageData);
                            Uint8List? imageData = await pickImage();
                            if (imageData != null) {
                              image.add(imageData);
                            } else {
                              print("이미지 선택이 취소되었습니다.");
                            }
                          } else {
                            print("이미지 선택이 취소되었습니다.");
                          }
                        },
                        child: Text('이미지 추가'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('제목', style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: '제목을 입력해주세요.',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('내용', style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Container(
                            child: TextField(
                              controller: bodyController,
                              decoration: InputDecoration(
                                hintText: '내용을 입력해주세요.',
                              ),
                              maxLines: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    // addProgram(titleController.text
                  },
                  child: Text('수정'),
                )
              ]
          );
        }
    );
  }
}