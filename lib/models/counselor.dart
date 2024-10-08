import 'package:cloud_firestore/cloud_firestore.dart';

class Counselor {
  final String documentId;
  final String name;
  final String body;
  final String photoURL;
  final String profileURL;
  final String info;
  final String title;
  final DateTime date;



  Counselor({
    required this.documentId,
    required this.name,
    required this.body,
    required this.photoURL,
    required this.info,
    required this.title,
    required this.date,
    required this.profileURL,
  });


  factory Counselor.fromJson(Map<String, dynamic> json) {
    return Counselor(
      documentId:json['documentId'] ?? '',
      name:json['name'] ?? '',
      body:json['body'] ?? '',
      photoURL:json['photoURL'] ?? '',
      profileURL:json['profileURL'] ?? '',
      info: json['info'] ?? '',
      title:json['title'] ?? '',
      date:json['date'].toDate(),
    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['profileURL'] = this.profileURL;
    data['info'] = this.info;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
