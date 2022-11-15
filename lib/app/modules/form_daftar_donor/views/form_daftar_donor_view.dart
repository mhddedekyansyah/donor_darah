import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/form_daftar_donor_controller.dart';

class FormDaftarDonorView extends GetView<FormDaftarDonorController> {
  const FormDaftarDonorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserModel? user = Get.arguments['user'];
    debugPrint(user.toString());
    Widget _inputsection() {
      Widget _noktp() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No.Ktp',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: controller.formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (String noKtp) {
                    controller.setNoKtp(noKtp);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      }

      Widget _name() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // onChanged: (String name) {
                //   controller.setName(name);
                // },
                initialValue: user?.name ?? '',
                readOnly: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ],
          ),
        );
      }

      Widget _address() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // onChanged: (String address) {
                //   controller.setAddress(address);
                // },
                readOnly: true,
                initialValue: user?.address ?? '',
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ],
          ),
        );
      }

      Widget _gender() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Pilih Jenis Kelamin',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: controller.genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih Jenis Kelamin.';
                  }
                },
                onChanged: (value) {
                  // controller.setGender(value.toString());
                  controller.selectedValue?.value = value.toString();
                },
              ),
            ],
          ),
        );
      }

      Widget _noHp() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No.Handphone',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // keyboardType: TextInputType.number,
                // onChanged: (String mobile) {
                //   controller.setMobile(mobile);
                // },
                readOnly: true,
                initialValue: user?.mobile ?? '',
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ],
          ),
        );
      }

      Widget _motherName() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Ibu Kandung',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (String motherName) {
                  controller.setMotherName(motherName);
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
              )
            ],
          ),
        );
      }

      Widget _job() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pekerjaan',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (String job) {
                  controller.setJob(job);
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ],
          ),
        );
      }

      Widget _date() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tempat Tanggal Lahir',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                controller: controller.ttlController,
                decoration: InputDecoration(
                  hintText: '00/00/00',
                  suffixIcon: const Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement
                    controller.ttlController.text = formattedDate.toString();
                  } else {
                    print("Date is not selected");
                  }
                },
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ],
          ),
        );
      }

      Widget _submit() {
        return Container(
            margin:
                const EdgeInsets.only(bottom: 30, right: 24, left: 24, top: 12),
            child: ElevatedButton(
              onPressed: () async {
                Get.back();
                Get.snackbar('Sukses', 'Pendaftaraan Berhasil',
                    backgroundColor: Colors.green);
                await controller.daftarDonor(user);
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFCF0A0A),
                  textStyle: GoogleFonts.poppins(),
                  minimumSize: const Size.fromHeight(45)),
              child: const Text(
                'kirim',
              ),
            ));
      }

      return Column(
        children: [
          _noktp(),
          _name(),
          _address(),
          _gender(),
          _noHp(),
          _motherName(),
          _job(),
          _date(),
          _submit()
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFCF0A0A),
          title: Text(
            'Pendaftaran Donor Darah',
            style: GoogleFonts.poppins(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [_inputsection()],
          ),
        ));
  }
}
