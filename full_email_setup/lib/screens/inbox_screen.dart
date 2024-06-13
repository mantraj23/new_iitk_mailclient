import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/email.dart';
import '../objectbox.dart'; // Import ObjectBox initialization
import '../backend/fetchmail.dart'; // Updated fetchAllEmails function
import '../main.dart' ;

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  bool _isLoading = true;
  List<Email> _emails = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchEmails();
  }

  Future<void> _fetchEmails() async {
    try {
      await fetchAllEmails(); // Fetch and store all emails
      setState(() {
        _emails = objectbox.emailBox.getAll(); // Get all emails from ObjectBox
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : _error != null
              ? Center(
                  child: Text(_error!),
                )
              : ListView(
                  children: _emails.reversed.map((email) {
                    final subject = email.subject;
                    final snippet = email.body.length > 20
                        ? email.body.substring(0, 20)
                        : email.body; // Ensure the body length is valid
                    final from = email.from;
                    final number = email.id ;
                    final avatarLetter =
                        from.isNotEmpty ? from[0].toUpperCase() : 'U';

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(avatarLetter),
                      ),
                      title: Text(subject),
                      subtitle: Text(
                        snippet,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text('$number'),
                      
                      onTap: () {
                        // Handle on tap
                      },
                    );
                  }).toList(),
                ),
    );
  }
}
