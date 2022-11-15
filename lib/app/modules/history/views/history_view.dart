import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';
import 'package:donor_darah/app/modules/home/controllers/home_controller.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({Key? key}) : super(key: key);
  HistoryController controller = Get.put(HistoryController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'History Pendaftaran Donor',
            style: GoogleFonts.poppins(),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFFCF0A0A),
        ),
        body: StreamBuilder<List<PendaftaranDonor>>(
          stream: controller.fetchDaftarDonor(),
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
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 14),
                        width: Get.width,
                        height: 150,
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
                            Text(
                              data[index].name.toString(),
                              style: GoogleFonts.poppins(),
                            ),
                            Text(data[index].address.toString(),
                                style: GoogleFonts.poppins()),
                            Text(data[index].mobile.toString(),
                                style: GoogleFonts.poppins()),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: data[index].status == 'PROSES'
                                          ? Colors.amber
                                          : data[index].status == 'KONFIR'
                                              ? Colors.green
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        data[index].status == 'PROSES'
                                            ? Icons.history
                                            : data[index].status == 'KONFIR'
                                                ? Icons.verified
                                                : Icons.cancel,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${data[index].status == 'PROSES' ? 'menunggu konfirmasi' : data[index].status == 'KONFIR' ? 'diterima' : 'ditolak'}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'history donor darah masih kosong silahkan',
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade500),
                          ),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.FORM_DAFTAR_DONOR,
                                arguments: {'user': homeController.user}),
                            child: Text(
                              'klik disini.',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFFCF0A0A),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Atau klik tombol tambah di bawah untuk daftar.',
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade500),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ));
            }

            return const Center(
              child: Text('no data'),
            );
          },
        ));
  }
}
