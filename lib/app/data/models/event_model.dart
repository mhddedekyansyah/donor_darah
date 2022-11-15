// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final String? imgUrl;
  final String? start;
  final String? over;

  const EventModel({
    this.id,
    this.name,
    this.address,
    this.imgUrl,
    this.start,
    this.over,
  });

  EventModel copyWith({
    String? id,
    String? name,
    String? address,
    String? imgUrl,
    String? start,
    String? over,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imgUrl: imgUrl ?? this.imgUrl,
      start: start ?? this.start,
      over: over ?? this.over,
    );
  }

  factory EventModel.fromJson(String id, Map<String, dynamic> json) =>
      EventModel(
          id: id,
          name: json['name'],
          address: json['address'],
          imgUrl: json['imgUrl'],
          start: json['start'],
          over: json['over']);
  @override
  List<Object?> get props => [id, name, address, imgUrl, start, over];
}
