import 'package:flutter/foundation.dart';
import 'dart:convert';

class Video {
  final int id;
  final String url;

  const Video({required this.id,
    required this.url
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        id: json['id'],
        url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
