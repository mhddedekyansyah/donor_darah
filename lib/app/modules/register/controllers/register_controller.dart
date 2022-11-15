import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class RegisterController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final TextEditingController phoneNumberC = TextEditingController(text: '');
  String? documentId;
  String validPhoneNumber = '';

  void setValid() {
    validPhoneNumber = '+62${phoneNumberC.text}';
  }

  Future<void> signUp(BuildContext context) async {
    print(validPhoneNumber);
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: validPhoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            CollectionReference userRef =
                FirebaseFirestore.instance.collection('users');
            UserCredential user = await _auth.signInWithCredential(credential);

            DocumentSnapshot data =
                await userRef.doc(user.user?.phoneNumber).get();
            if (data.data() != null) {
              Map<String, dynamic> role = data.data() as Map<String, dynamic>;

              if (role['role'] == 'ADMIN') {
                Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
              } else {
                Get.offAllNamed(Routes.MAIN_HOME_USER);
              }
            } else {
              Get.offAllNamed(Routes.FORM_REGISTER,
                  arguments: {'noHp': validPhoneNumber});
            }
          },
          verificationFailed: (FirebaseAuthException e) async {
            print(e.code);
            if (e.code == 'invalid-phone-number') {
              Get.snackbar('Failed', 'invalid phone number',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3));
            } else if (e.code == 'too-many-requests') {
              Get.defaultDialog(
                  title: 'Oops!',
                  textConfirm: 'Ok',
                  onConfirm: () => Get.back(),
                  titlePadding: const EdgeInsets.all(15.0),
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/waiting.jpg',
                          width: 150,
                          height: 150,
                        ),
                        const Text(
                          'request otp terlalu sering coba beberapa saat lagi',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ));
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            Get.snackbar(
              'sukses',
              'Kode OTP telah dikirim',
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP,
            );
            showModalBottomSheet(
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                context: context,
                builder: (context) {
                  const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
                  const fillColor = Color.fromRGBO(243, 246, 249, 0);
                  const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
                  final defaultPinTheme = PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 22,
                      color: const Color.fromRGBO(30, 60, 87, 1),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: borderColor),
                    ),
                  );
                  return Container(
                    padding: const EdgeInsets.all(30),
                    height: Get.height * 0.25,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Directionality(
                            // Specify direction if desired
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              length: 6,
                              controller: pinController,
                              focusNode: focusNode,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsRetrieverApi,
                              listenForMultipleSmsOnAndroid: true,
                              defaultPinTheme: defaultPinTheme,
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: focusedBorderColor,
                                  ),
                                ],
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyBorderWith(
                                border: Border.all(color: Colors.redAccent),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await verify(verificationId);
                            },
                            child: const Text('verifikasi'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          timeout: const Duration(seconds: 30),
          codeAutoRetrievalTimeout: (String verificationId) {
            // Auto-resolution timed out...
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verify(
    String verificationId,
  ) async {
    print('verificationId => $verificationId');
    try {
      UserCredential user = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: pinController.text));

      if (user.credential != null) {}
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot data = await userRef.doc(user.user?.phoneNumber).get();

      if (data.data() != null) {
        Map<String, dynamic> role = data.data() as Map<String, dynamic>;
        if (role['role'] == 'ADMIN') {
          Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
        } else {
          Get.offAllNamed(Routes.MAIN_HOME_USER);
        }
      } else {
        Get.offAllNamed(Routes.FORM_REGISTER,
            arguments: {'noHp': validPhoneNumber});
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        Get.snackbar('Failed', 'kode otp salah',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      } else if (e.code == 'session-expired') {
        Get.snackbar('Failed', 'kode otp telah expired',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      }
    }
  }
}
