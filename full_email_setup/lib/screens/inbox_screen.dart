import 'package:flutter/material.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "./emails_list/mail_view_screen.dart" ;
import "../backend/sendMail.dart" ;

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  bool _isLoading = true;
  List<MimeMessage> _messages = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchEmails();
  }

  Future<void> _fetchEmails() async {
    try {
      final messages = await FetchMail();
      setState(() {
        _messages = messages;
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
              : ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final subject = message.decodeSubject() ?? 'No Subject';
                    final snippet = message.decodeTextPlainPart()?.substring(0, 50) ?? 'No Text Body';
                    final from = message.from?.isNotEmpty == true ? message.from!.first.email : 'U';
                    final avatarLetter = from.isNotEmpty ? from[0].toUpperCase() : 'U';

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MailViewScreen(message: message),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}