import 'package:flutter/material.dart';
import 'email_model.dart';
import 'email_detail_screen.dart';

class EmailListView extends StatelessWidget {
 
  final List<Email> emails;

  const EmailListView({required this.emails, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emails.length,
      itemBuilder: (context, index) {
        final email = emails[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(email.sender[0].toUpperCase()),
          ),
          title: Text(email.subject),
          subtitle: Text(email.sender),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmailDetailScreen(email: email),
              ),
            );
          },
        );
      },
    );
  }
}
