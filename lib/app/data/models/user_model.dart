// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final String? mobile;
  final String? role;
  final String? photoUrl;

  const UserModel(
      {this.id,
      this.name,
      this.address,
      this.mobile,
      this.role,
      this.photoUrl});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
      id: id,
      name: json['name'],
      address: json['address'],
      mobile: json['mobile'],
      role: json['role'],
      photoUrl: json['photoUrl']);

  @override
  List<Object?> get props => [id, name, address, mobile, role, photoUrl];

  UserModel copyWith({
    String? id,
    String? name,
    String? address,
    String? mobile,
    String? role,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
