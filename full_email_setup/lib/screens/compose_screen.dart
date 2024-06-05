import 'package:flutter/material.dart';
import '../storage_model/storage.dart';
import '../backend/sendMail.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final SecureStorage _secureStorage = SecureStorage();

  void _showAlertDialog(BuildContext context) {
    // Set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text('The mail was sent succesfully'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(
                    top: 12,
                    left: 12), // Adjust content padding for top left alignment
              ),
              maxLines: 6, // Set the number of lines you want to display
              textInputAction: TextInputAction.newline,
              // Set content padding to adjust the height
              // You can adjust the values to fit your design
              style: const TextStyle(height: 1.5),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try{
                await sendMail(
                    to: _toController.text,
                    subject: _subjectController.text,
                    body: _bodyController.text);
                print(await _secureStorage.getUserName());
                _showAlertDialog(context);
                _toController.clear();
                _subjectController.clear();
                _bodyController.clear();
                }
                catch(e){
                   
                }
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
