import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation{
  final String documentId;
  final String name;
  final String hp;
  final String request;
  final String counselorId;
  final String userId;
  final String userName;
  final String counselorName;
  final DateTime createDate;

  Reservation({
    required this.documentId,
    required this.name,
    required this.hp,
    required this.request,
    required this.counselorId,
    required this.userId,
    required this.userName,
    required this.counselorName,
    required this.createDate,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      documentId:json['documentId'] ?? '',
      name:json['name'] ?? '',
      hp:json['hp'] ?? '',
      request:json['request'] ?? '',
      counselorId:json['counselorId'] ?? '',
      userId:json['userId'] ?? '',
      userName:json['userName'] ?? '',
      counselorName:json['counselorName'] ?? '',
      createDate:json['createDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['hp'] = this.hp;
    data['request'] = this.request;
    data['counselorId'] = this.counselorId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['counselorName'] = this.counselorName;
    data['createDate'] = this.createDate;
    return data;
  }
}