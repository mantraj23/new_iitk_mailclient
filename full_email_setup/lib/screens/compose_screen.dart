import 'package:flutter/material.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 12, left: 12), // Adjust content padding for top left alignment
              ),
              maxLines: 10, // Set the number of lines you want to display
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              // Set content padding to adjust the height
              // You can adjust the values to fit your design
              style: const TextStyle(height: 1.5),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality to send the email
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
