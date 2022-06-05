import 'package:flutter/material.dart';

class Transcation {
  Transcation({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
  String id;
  String title;
  double amount;
  DateTime date;
}
