import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_u_admin/models/counselor.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class CounselorInfo {
 FirebaseFirestore db = FirebaseFirestore.instance;

 Future<List<Counselor>> getCounselorList() async {
    List<Counselor> counselorList = [];
    try {
      QuerySnapshot snapshot = await db.collection('counselor').get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        counselorList.add(Counselor.fromJson(data));
      }
      print(counselorList.length);
      return counselorList;
    } catch (e) {
      print('상담사 리스트 가져올때 걸림');
      print(e);
      return [];
    }
 }

 Future<void> addCounselor(String email, String password, String name, String title) async {
   try{
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );

     await db.collection('counselor').doc(userCredential.user!.uid).set({
       'email': userCredential.user!.email,
       'name': name,
       'profileURL': '',
       'info': '상담사의 간단 소개 정보 수정이 필요합니다.',
       'title': title,
       'photoURL': '',
       'body': '상담사의 소개 정보 수정이 필요합니다.',
       'date': DateTime.now(),
       'possibleTime': {
         'afternoon': [],
         'morning': [],
       },
       'holyDate': [],
     });
     QuerySnapshot snapshot = await db.collection('users').get();
     for(var i in snapshot.docs){
       addChatRoom(i.id, userCredential.user!.uid, i['name'], i['companyName']);
     }

   }
   catch(e){
     print(e);
   }
 }

 deleteCounselor(String documentId) async {
   try{
     await db.collection('counselor').doc(documentId).delete();
   }catch(e){
     print(e);
   }
 }

 updateCounselor(String documentId, {String? name, String? title, String? info, String? body}) async {
   try{
     await db.collection('counselor').doc(documentId).update({
       'name': name ?? FieldValue,
       'title': title ?? FieldValue,
       'info': info ?? FieldValue,
       'body': body ?? FieldValue,
     });
   }catch(e){
     print(e);
   }
 }

 addChatRoom(String userId, String counselorId, String userName, String companyName,) async {
    try{
      await db.collection('chatRoom').doc().set({
        'userId': userId,
        'counselorId': counselorId,
        'lastSenderId': '',
        'isReadUser': false,
        'isReadCounselor': false,
        'lastChat': '',
        'lastChatDate': DateTime.now(),
        'userName': userName,
        'companyName': companyName,
      });
    }catch(e){
      print(e);
    }
 }
}