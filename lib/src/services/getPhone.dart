import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/src/config.dart';

class GetPhoneController extends GetxController {
  final codeSent = false.obs;

  final smsCode = '123456'.obs;
  final verificationId = ''.obs;

  final isoCode = 'BO'.obs;
  final phoneNumber = ''.obs;
  final international = ''.obs;

  Future verifyPhone() async {
    final failed = (FirebaseAuthException e) => print(e.message);
    final autoTimeout = (String verId) => verificationId.value = verId;

    final verified = (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    };

    final smsSent = (String verId, [int resend]) {
      this.codeSent.value = true;
      this.verificationId.value = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      codeSent: smsSent,
      verificationFailed: failed,
      verificationCompleted: verified,
      phoneNumber: international.value,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  Future signWithSMS() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          smsCode: smsCode.value,
          verificationId: verificationId.value,
        ),
      );

      final firebaseToken = await userCredential.user.getIdToken();
      await box.write('firebaseToken', firebaseToken);
    } catch (e) {
      print(e);
    }
  }
}