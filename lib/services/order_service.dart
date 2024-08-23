import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundry_app/models/order.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createOrder(OrderModel order) async {
    await _db.collection('orders').add(order.toMap());
  }

  Stream<List<OrderModel>> getOrdersByCustomerId(String customerId) {
    return _db
        .collection('orders')
        .where('customerId', isEqualTo: customerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
