import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:state_management/utils/helper/tost_helper.dart';

class FirebaseStorageService {
  FirebaseStorageService._privateConstrustor();

  static FirebaseStorageService getInstance =
      FirebaseStorageService._privateConstrustor();

  factory FirebaseStorageService() {
    return getInstance;
  }
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userCollection = 'Users';

  Future<void> storeUserDetails(
      {required User userData, required Map request}) async {
    try {
      await _firestore
          .collection(_userCollection)
          .doc(userData.uid)
          .set({...request});
    } catch (e) {
      showToast(message: e.toString());
    }
  }
}
