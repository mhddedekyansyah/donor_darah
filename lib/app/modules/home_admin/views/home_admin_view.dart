import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  HomeAdminView({Key? key}) : super(key: key);
  HomeAdminController controller = Get.put(HomeAdminController());
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        width: Get.width,
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<UserModel>(
                stream: controller.fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    controller.user = snapshot.data;
                    return Row(
                      children: [
                        controller.user!.photoUrl != null
                            ? Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${controller.user!.photoUrl}'),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/user_photo_null.png'),
                                        fit: BoxFit.cover)),
                              ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('${controller.user!.name}')
                      ],
                    );
                  }
                  return const Text('no data');
                }),
            IconButton(
                onPressed: () async {
                  await controller.logout().then((_) {
                    Get.offAllNamed(Routes.REGISTER);
                  });
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pendaftar Donor Darah',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            StreamBuilder<List<PendaftaranDonor>>(
              stream: controller.fetchPendaftarDonor(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  List<PendaftaranDonor> data = snapshot.data!;
                  if (data != null && data.isNotEmpty) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 14),
                            width: Get.width,
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      color: Colors.grey.shade200)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].name.toString(),
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                        Text(data[index].address.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                        Text(data[index].gender.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                        Text(data[index].ttl.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].noKtp.toString(),
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                        Text(data[index].job.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                        Text(data[index].mobile.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                        Text(data[index].motherName.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12)),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      data[index].status == 'PROSES'
                                          ? Row(
                                              children: [
                                                ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: const Color(
                                                                0xFFCF0A0A)),
                                                    onPressed: () async {
                                                      controller
                                                          .tolak(data[index])
                                                          .then((_) {
                                                        Get.snackbar('Sukses',
                                                            'Berhasil menolak pendaftaran',
                                                            backgroundColor:
                                                                Colors.green);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel),
                                                    label: const Text('tolak')),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green),
                                                    onPressed: () async {
                                                      controller
                                                          .terima(data[index])
                                                          .then((_) {
                                                        Get.snackbar('Sukses',
                                                            'Berhasil menerima pendaftaran',
                                                            backgroundColor:
                                                                Colors.green);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.verified),
                                                    label:
                                                        const Text('terima')),
                                              ],
                                            )
                                          : data[index].status == 'KONFIR'
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Pendaftaran Diterima',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFCF0A0A),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Pendaftaran Ditolak',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                )
                                    ])
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, _) => const SizedBox(
                              height: 15,
                            ),
                        itemCount: data.length);
                  }

                  return Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pendaftaran donor darah masih kosong',
                        style: GoogleFonts.poppins(color: Colors.grey.shade500),
                      ),
                    ],
                  ));
                }

                return const Center(
                  child: Text('no data'),
                );
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      child: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(), content()],
        ),
      )),
    ));
  }
}
