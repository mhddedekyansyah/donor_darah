import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(30),
                width: Get.width,
                height: Get.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_logo.png',
                        fit: BoxFit.cover,
                        width: 280,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20),
                        child: Text(
                          'Masukkan nomor untuk melanjutkan, Kami akan mengirimkan kode OTP.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 3)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 20,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      spreadRadius: .5,
                                      blurRadius: .5),
                                ],
                                borderRadius: BorderRadius.circular(3),
                                image: const DecorationImage(
                                    image: AssetImage('assets/icons/id.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              '+62',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: controller.phoneNumberC,
                                autofocus: true,
                                showCursor: true,
                                cursorHeight: 18,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                autocorrect: false,
                                maxLength: 12,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  counterText: '',
                                  hintText: '819-5727-9663',
                                  hintStyle: GoogleFonts.poppins(
                                      letterSpacing: 2,
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (_) {
                                  controller.setValid();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        onPressed: () async {
                          await controller.signUp(context);
                          // Get.toNamed(Routes.FORM_REGISTER);
                        },
                        child: Text(
                          'lanjutkan',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 20),
                        ),
                      )
                    ]))));
  }
}
