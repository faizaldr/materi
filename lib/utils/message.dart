import 'package:flutter/material.dart';

class Message {
  static void successMessage(context, message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
