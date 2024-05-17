import 'package:flutter/material.dart';
import 'emails_list/email_list_view.dart' ;
import 'emails_list/email_model.dart' ;
import 'emails_list/email_service.dart' ;

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key}) ;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late Future<List<Email>> emails;

  @override
  void initState() {
    super.initState();
    emails = EmailService().loadEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: FutureBuilder<List<Email>>(
        future: emails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No emails found.'));
          } else {
            return EmailListView(emails: snapshot.data!);
          }
        },
      ),
    );
  }
}
