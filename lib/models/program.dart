import 'package:cloud_firestore/cloud_firestore.dart';

class Program {
  final String documentId;
  final String body;
  final List<String> photoURL;
  final String title;
  final DateTime createDate;

  Program({required this.documentId, required this.body, required this.photoURL,required this.title, required this.createDate});


  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      documentId:json['documentId'] ?? '',
      body:json['body'] ?? '',
      photoURL:json['photoURL'] ?? '',
      title:json['title'] ?? '',
      createDate:json['createDate'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['title'] = this.title;
    data['createDate'] = this.createDate;
    return data;
  }
}
