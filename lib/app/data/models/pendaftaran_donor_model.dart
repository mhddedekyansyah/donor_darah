// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PendaftaranDonor extends Equatable {
  final String? id;
  final String? userId;
  final String? noKtp;
  final String? name;
  final String? address;
  final String? gender;
  final String? mobile;
  final String? motherName;
  final String? job;
  final String? ttl;
  final String? status;

  const PendaftaranDonor(
      {this.id,
      this.userId,
      this.noKtp,
      this.name,
      this.address,
      this.gender,
      this.mobile,
      this.motherName,
      this.job,
      this.ttl,
      this.status = 'PROSES'});
  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        noKtp,
        address,
        gender,
        mobile,
        motherName,
        job,
        ttl,
        status
      ];

  PendaftaranDonor copyWith({
    String? id,
    String? userId,
    String? noKtp,
    String? name,
    String? address,
    String? gender,
    String? mobile,
    String? motherName,
    String? job,
    String? ttl,
    String? status,
  }) {
    return PendaftaranDonor(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      noKtp: noKtp ?? this.noKtp,
      name: name ?? this.name,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      motherName: motherName ?? this.motherName,
      job: job ?? this.job,
      ttl: ttl ?? this.ttl,
      status: status ?? this.status,
    );
  }

  factory PendaftaranDonor.fromJson(String id, Map<String, dynamic> json) =>
      PendaftaranDonor(
          id: id,
          userId: json['userId'],
          noKtp: json['noKtp'],
          name: json['name'],
          address: json['address'],
          gender: json['gender'],
          mobile: json['mobile'],
          motherName: json['motherName'],
          job: json['job'],
          ttl: json['TTL'],
          status: json['status']);
}
