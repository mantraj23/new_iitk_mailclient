import 'package:flutter/material.dart';
import 'email_model.dart';

class EmailDetailScreen extends StatelessWidget {
  final Email email;

  const EmailDetailScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
        actions: [
          IconButton(
            icon:  const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${email.sender}',
              style: const  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Subject: ${email.subject}',
              style: const  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(email.body),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class  BottomDrawer extends StatelessWidget {
  const BottomDrawer({super.key}) ;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 250,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Flag'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.mark_email_unread),
            title: const Text('Mark as Unread'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.snooze),
            title: const Text('Snooze'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report as Spam'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
