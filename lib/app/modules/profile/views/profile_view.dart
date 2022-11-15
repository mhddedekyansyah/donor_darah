import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          StreamBuilder<UserModel>(
            stream: controller.fetchUser(),
            builder: (context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                UserModel? data = snapshot.data;

                if (data != null) {
                  return Container(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: data.photoUrl != null &&
                                    data.photoUrl!.isNotEmpty
                                ? Image.network(
                                    data.photoUrl!,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/icons/user_photo_null.png',
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  )),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${data.name}',
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          onTap: () {
                            Get.toNamed(Routes.EDIT_PROFILE,
                                arguments: {'user': data});
                          },
                          leading: Image.asset(
                            'assets/icons/account.png',
                            width: 24,
                            height: 24,
                            color: const Color(0xFFCF0A0A),
                          ),
                          shape: Border.all(color: Colors.grey.shade300),
                          title: Text('Edit Profile',
                              style: GoogleFonts.poppins(color: Colors.black)),
                          trailing: Image.asset(
                              'assets/icons/chevron_right.png',
                              width: 12,
                              height: 12,
                              color: Colors.grey.shade300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // ListTile(
                        //   onTap: () {
                        //     showDialog(
                        //         context: context,
                        //         builder: (context) {
                        //           return AlertDialog(
                        //             content: Text(
                        //               'Are you sure to remove your account?',
                        //               style: GoogleFonts.poppins(
                        //                   color: Colors.black),
                        //             ),
                        //             contentPadding: const EdgeInsets.all(20),
                        //             actions: [
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   ElevatedButton(
                        //                       style: ElevatedButton.styleFrom(
                        //                           elevation: 0.0,
                        //                           primary: Colors.red),
                        //                       onPressed: () {
                        //                         Navigator.pop(context);
                        //                       },
                        //                       child: Text(
                        //                         'cancel',
                        //                         style: GoogleFonts.poppins(),
                        //                       )),
                        //                   const SizedBox(
                        //                     width: 20,
                        //                   ),
                        //                   ElevatedButton(
                        //                       style: ElevatedButton.styleFrom(
                        //                           elevation: 0.0,
                        //                           primary:
                        //                               const Color(0xFFCF0A0A)),
                        //                       onPressed: () {},
                        //                       child: Text(
                        //                         'ok',
                        //                         style: GoogleFonts.poppins(),
                        //                       )),
                        //                 ],
                        //               )
                        //             ],
                        //           );
                        //         });
                        //   },
                        //   leading: const Icon(Icons.remove_circle,
                        //       color: Colors.red),
                        //   shape: Border.all(color: Colors.grey.shade300),
                        //   title: Text('Remove Account',
                        //       style: GoogleFonts.poppins(color: Colors.black)),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.logout().then(
                                    (_) => Get.offAllNamed(Routes.REGISTER));
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(45),
                                  primary: const Color(0xFFCF0A0A)),
                              child: const Text('Logout'),
                            ))
                      ],
                    ),
                  );
                }
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('something went wrong'),
                );
              }
              return const Text('no data');
            },
          ),
        ],
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [header(), content()],
          ),
        )),
      ),
    );
  }
}
