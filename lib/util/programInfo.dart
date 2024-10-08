import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:on_u_admin/models/program.dart';

class ProgramInfo{
  final db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  Future<List<Program>> getProgram() async{
    List<Program> programList = [];
    try {
      QuerySnapshot snapshot = await db.collection('program').get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        data['photoURL'] = data['photoURL'].cast<String>();
        data['createDate'] = data['createDate'].toDate();
        print(data['photoURL']);
        programList.add(Program.fromJson(data));
        print(data);
      }
      return programList;
    } catch (e) {
      print('프로그램 가져올때 걸림');
      print(e);
      return [];
    }
  }

  Future<void> addProgram(String title, String body, List<String> photoURL) async {
    try {
      await db.collection('program').add({
        'title': title,
        'body': body,
        'photoURL': photoURL,
        'createDate': DateTime.now(),
      });
    } catch (e) {
      print('프로그램 추가할때 걸림');
      print(e);
    }
  }

  Future<List<String>> addFirebaseStorageURL(List<Uint8List?> image) async {
    List<String> photoURL = [];
    try{
      print(1);
      for(var i in image){
        print(2);
        // 이미지가 null일 경우 처리
        if (i == null) {
          print('No image selected.');
          return [];
        }
        print(3);
        // Firebase Storage에 업로드할 파일 경로 지정 (예: images 폴더에 저장)
        // final Reference ref = _storage.ref().child('images/${DateTime.now().toString() + i.toString()}.png');
        final Reference ref = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');

        print(4);
        // Firebase에 업로드
        UploadTask uploadTask = ref.putData(i);
        print(5);
        // 업로드 완료 후 다운로드 URL을 얻기
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        print(6);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        print('Download URL: $downloadUrl');
        photoURL.add(downloadUrl);
      }
      return photoURL;
    }catch(e){
      print('프로그램 사진 업로드할때 걸림');
      print(e);
      return [];
    }
  }

  Future<void> updateProgram(String documentId, String title, String body, List<String> photoURL) async {
    try {
      await db.collection('program').doc(documentId).update({
        'title': title,
        'body': body,
        'photoURL': photoURL,
      });
    } catch (e) {
      print('프로그램 수정할때 걸림');
      print(e);
    }
  }

  Future<void> deleteProgram(String documentId) async {
    try {
      await db.collection('program').doc(documentId).delete();
    } catch (e) {
      print('프로그램 삭제할때 걸림');
      print(e);
    }
  }
}