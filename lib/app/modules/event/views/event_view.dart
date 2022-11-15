import 'package:donor_darah/app/data/models/event_model.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  EventView({Key? key}) : super(key: key);
  EventController controller = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFCF0A0A),
          title: const Text('Acara Donor Darah'),
          centerTitle: true,
        ),
        body: StreamBuilder<List<EventModel>>(
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
                        margin: const EdgeInsets.all(24),
                        child: ListView(
                            children: snapshot.data
                                ?.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(15),
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
                                                'assets/images/waiting.jpg',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      tileColor: Colors.white,
                                      subtitle: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.name.toString()),
                                            Text(
                                              e.address.toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e.start.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Text('~'),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    e.over.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                Get.toNamed(Routes.EDIT_EVENT,
                                                    arguments: {"event": e});
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              )),
                                          IconButton(
                                              onPressed: () async {
                                                await controller
                                                    .deleteEvent(e.id)
                                                    .then((_) => Get.snackbar(
                                                        'Suksess',
                                                        'Berhasil hapus acara',
                                                        backgroundColor:
                                                            Colors.green));
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList() as List<Widget>)))
                : const Center(child: Text('events kosong'));
          },
        ));
  }
}
