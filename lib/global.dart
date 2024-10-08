
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color mainColor = Color(0xff19B795);
const Color subColor = Color(0xff91DECD);
const Color typoColor = Color(0xff029D7C);

const Color bgColor = Color(0xffF6F6F9);

const Color gray100 = Color(0xffe5e5ea);
const Color gray200 = Color(0xffd4d4d4);
const Color gray300 = Color(0xffaeaeb2);
const Color gray400 = Color(0xff848487);
const Color gray500 = Color(0xff636366);
const Color gray600 = Color(0xff4a4a4a);
const Color gray700 = Color(0xff303030);
const Color gray800 = Color(0xff1a1a1a);

String uid = '';
// late MyInfo myInfo ;
int cash = 0;
// String formatTimestamp(Timestamp timestamp) {
//   DateTime dateTime = timestamp.toDate();
//   DateFormat dateFormat = DateFormat('MM.dd (EEE)', 'ko_KR');
//   return dateFormat.format(dateTime);
// }
String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.length == 11) {
    return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7, 11)}';
  } else {
    return phoneNumber;
  }
}

String formatNumber(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} 원';
}
String formatPoint(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} P';
}
void saving(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible:false,
      builder: (BuildContext context) {
        return const AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0, // 그림자 효과 없애기
            content: Center(
              child: CircularProgressIndicator(color: Colors.white,),
            )
        );
      });
}
