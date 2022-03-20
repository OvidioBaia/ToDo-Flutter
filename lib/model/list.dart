import 'package:flutter/foundation.dart';
import 'dart:convert';

class Task {
  final int id;
  final String nome;

  const Task({required this.id,
    required this.nome,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      nome: json['nome']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;

    return data;
  }
}
