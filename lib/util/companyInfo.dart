import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_admin/models/company.dart';

class CompanyInfo {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Company>> getCompanyList() async{
    List<Company> companyList = [];
    try {
      QuerySnapshot snapshot = await db.collection('company').get();
      for (DocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        companyList.add(Company.fromJson(data));
      }
      return companyList;
    } catch (e) {
      print('회사 정보 가져올때 걸림');
      print(e);
      return companyList;
    }
  }

  addCompany(String companyName, int ticket) async {
    try {
      String code = generateRandomCode(8);
      QuerySnapshot snapshot = await db.collection('company').where('companyCode', isEqualTo: code).get();
      bool isExist = true;

      checkCode(code, snapshot, isExist);

      await db.collection('company').doc(companyName).set({
        'companyCode': generateRandomCode(8),
        'ticket': ticket,
      });
    } catch (e) {
      print('회사 정보 추가할때 걸림');
      print(e);
    }
  }

  checkCode(String code, QuerySnapshot snapshot, bool isExist) async {
    if(snapshot.docs.isEmpty){
      isExist = false;
    }
    else{
      code = generateRandomCode(8);
      checkCode(code, snapshot, isExist);
    }
  }

  updateCompany( String companyName, int ticket) async {
    try {
      await db.collection('company').doc(companyName).update({
        'ticket': FieldValue.increment(ticket),
      });
    } catch (e) {
      print('회사 정보 수정할때 걸림');
      print(e);
    }
  }

  deleteCompany(String documentId) async {
    try {
      await db.collection('company').doc(documentId).delete();
    } catch (e) {
      print('회사 정보 삭제할때 걸림');
      print(e);
    }
  }

  String generateRandomCode(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

}