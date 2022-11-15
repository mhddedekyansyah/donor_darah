import 'package:donor_darah/app/data/models/event_model.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        width: Get.width,
        height: 90,
        color: Colors.white,
        child: StreamBuilder<UserModel>(
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
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          children: [
            Text(
              'Acara Donor Darah',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            StreamBuilder<List<EventModel>>(
              stream: controller.fetchEvent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.data!.isNotEmpty
                    ? SafeArea(
                        child: Container(
                            // margin: const EdgeInsets.all(24),
                            child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data
                                    ?.map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          onTap: () => MapsLauncher.launchQuery(
                                              e.address.toString()),
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          leading: e.imgUrl != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    '${e.imgUrl}',
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    'assets/images/bonbon.png',
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                          tileColor: Colors.white,
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(e.name.toString()),
                                              Text(e.address.toString()),
                                              Row(
                                                children: [
                                                  Text(
                                                    e.start.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text('~'),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(e.over.toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    )
                                    .toList() as List<Widget>)))
                    : const Center(child: Text('events kosong'));
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
