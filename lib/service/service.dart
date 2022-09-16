import 'package:cloud_firestore/cloud_firestore.dart';

class Service{
  Future<bool> checkUser(String number) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc('$number')
        .get();
    return data.exists;
  }

  Future<void> setUser(String number) async {
    final userData = {'number': number};
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$number')
        .set(userData);
  }
}