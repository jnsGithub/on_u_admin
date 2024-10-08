import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String documentId;
  final String companyCode;
  int ticket;

  Company({
    required this.documentId,
    required this.companyCode,
    required this.ticket,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      documentId:json['documentId'] ?? '',
      companyCode:json['companyCode'] ?? '',
      ticket:json['ticket'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['companyCode'] = this.companyCode;
    data['ticket'] = this.ticket;
    return data;
  }
}