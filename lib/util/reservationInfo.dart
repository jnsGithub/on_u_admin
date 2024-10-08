import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_admin/models/reservation.dart';

class ReservationInfo {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Reservation>> getReservationList() async {
    List<Reservation> reservationList = [];
    try {
      QuerySnapshot snapshot = await db.collection('reservation').orderBy('createDate', descending: true).get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        print('1');
        data['createDate'] = data['createDate'].toDate();
        print('2');
        data['userName'] = await FirebaseFirestore.instance.collection('users').doc(data['userId']).get().then((value) => value.data()?['name'].toString() ?? '탈퇴회원입니다.');
        print('3');
        print(data['userName'].runtimeType);
        data['counselorName'] = await FirebaseFirestore.instance.collection('counselor').doc(data['counselorId']).get().then((value) => value.data()?['name'].toString() ?? '탈퇴회원입니다.');
        print('4');
        reservationList.add(Reservation.fromJson(data));
        print('5');
      }
      print(reservationList.length);
      return reservationList;
    } catch (e) {
      print('예약 리스트 가져올때 걸림');
      print(e);
      return [];
    }
  }
}