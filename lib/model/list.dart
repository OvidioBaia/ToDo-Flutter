import 'package:flutter/foundation.dart';
import 'dart:convert';

class Task {
  final int id;
  final String titulo;
  final String description;
  final String date;

  const Task({required this.id,
    required this.titulo,
    required this.description,
    required this.date
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      titulo: json['titulo'],
      description: json['description'],
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['description'] = this.description;
    data['date'] = this.date;
    return data;
  }
}
