import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  String customerId;
  String serviceType;
  bool expressService;
  bool specialFragrance;
  String pickupAddress;
  String city; // Tambahkan city
  String postalCode; // Tambahkan postalCode
  String orderStatus;
  String userId;
  DateTime createdAt;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.serviceType,
    required this.expressService,
    required this.specialFragrance,
    required this.pickupAddress,
    required this.city, // Tambahkan city
    required this.postalCode, // Tambahkan postalCode
    required this.orderStatus,
    required this.userId,
    required this.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      id: data['id'],
      customerId: data['customerId'],
      serviceType: data['serviceType'],
      expressService: data['expressService'] ?? false,
      specialFragrance: data['specialFragrance'] ?? false,
      pickupAddress: data['pickupAddress'],
      city: data['city'], // Tambahkan city
      postalCode: data['postalCode'], // Tambahkan postalCode
      orderStatus: data['orderStatus'],
      userId: data['userId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'serviceType': serviceType,
      'expressService': expressService,
      'specialFragrance': specialFragrance,
      'pickupAddress': pickupAddress,
      'city': city, // Tambahkan city
      'postalCode': postalCode, // Tambahkan postalCode
      'orderStatus': orderStatus,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
