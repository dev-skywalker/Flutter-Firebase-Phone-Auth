import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:imei_plugin/imei_plugin.dart';

class UserRepository {

  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollectionReference = Firestore.instance.collection("users");

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<AuthResult> verifyAndLogin(String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future createUser(String uid,String fullName) async {
    String imei = await ImeiPlugin.getImei();
    try {
      await _usersCollectionReference.add({
        "uid": uid,
        "fullName": fullName,
        "imei" : imei,
        "startDate" : DateTime.now().toString(),
        "limitDate": 1
      });
    } catch (e) {
      return e.message;
    }
  }

  Future<DocumentSnapshot> getUserById() async {
    DocumentSnapshot userSnapshot;
    final userId = (await _firebaseAuth.currentUser()).uid;
    await _usersCollectionReference.where('uid',isEqualTo: userId).getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.forEach((DocumentSnapshot documentSnapshot){
        userSnapshot = documentSnapshot;
      });
    });
    return userSnapshot;
  }
}
