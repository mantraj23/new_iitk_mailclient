import 'package:flutter/material.dart';
import 'package:enough_mail/enough_mail.dart';

class MailViewScreen extends StatelessWidget {
  final MimeMessage message;

  MailViewScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    final subject = message.decodeSubject() ?? 'No Subject';
    final from = message.from?.map((address) => address.toString()).join(', ') ?? 'Unknown sender';
    final date = message.decodeDate()?.toLocal().toString() ?? 'Unknown date';
    final body = message.decodeTextPlainPart() ?? 'No body';

    // Get the first letter of the sender's email for the avatar
    final avatarLetter = from[0].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        actions: [
          IconButton(
            icon: Icon(Icons.reply),
            onPressed: () {
              // Implement reply functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              // Implement forward functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Implement delete functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  child: Text(avatarLetter),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        from,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            Text(
              subject,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(body),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                // Implement reply functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.forward),
              onPressed: () {
                // Implement forward functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Implement delete functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
