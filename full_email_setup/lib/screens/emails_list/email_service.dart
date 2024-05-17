import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'email_model.dart';

class EmailService {
  Future<List<Email>> loadEmails() async {
    final String response = await rootBundle.loadString('assets/emails.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Email.fromJson(json)).toList();
  }
}
