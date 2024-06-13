import 'package:enough_mail/enough_mail.dart';
import 'package:objectbox/objectbox.dart';
import '../storage_model/storage.dart';
import '../objectbox.dart'; // Import ObjectBox initialization
import '../models/email.dart'; // Email model
import "../objectbox.g.dart" ;
import "../main.dart" ;


Future<void> fetchAllEmails() async {
  final SecureStorage _secureStorage = SecureStorage();
  final userName = await _secureStorage.getUserName();
  final password = await _secureStorage.getPassWord();

  String imapServerHost = 'qasid.iitk.ac.in';
  int imapServerPort = 143;
  bool isImapServerSecure = false;
  final client = ImapClient(isLogEnabled: true);

  try {
    await client.connectToServer(imapServerHost, imapServerPort,
        isSecure: isImapServerSecure);
    await client.login(userName!.split('@')[0], password!);
    await client.selectInbox();

    // Fetch all messages
    final fetchResult = await client.fetchRecentMessages(
      messageCount: 10,
      criteria: 'BODY.PEEK[]'
    );

    await saveEmailsToDatabase(fetchResult.messages);

    await client.logout();
  } on ImapException catch (e) {
    print('IMAP failed with $e');
  }
}

Future<void> saveEmailsToDatabase(List<dynamic> messages) async {


  for (final message in messages) {
    final email = Email(
      from: message.from?.isNotEmpty == true
          ? message.from!.first.email
          : 'Unknown',
      to: message.to?.isNotEmpty == true ? message.to!.first.email : 'Unknown',
      subject: message.decodeSubject() ?? 'No Subject',
      body: message.decodeTextPlainPart() ?? 'No Text Body',
      receivedDate: message.decodeDate() ?? DateTime.now(),
      
    );
    print("ready to put");
    objectbox.emailBox.put(email);
    print('saving done') ;
  }
}
