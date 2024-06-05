import '../storage_model/storage.dart';
import 'package:enough_mail/enough_mail.dart';

Future<bool> sendMail({
  required String to,
  required String subject,
  required String body,
}) async {
  // SMTP server details
  final SecureStorage _secureStorage = SecureStorage();
  final username = await _secureStorage.getUserName();
  final password = await _secureStorage.getPassWord();

  const smtpServer = 'mmtp.iitk.ac.in';
  const smtpPort = 25; 
  // Create an SMTP client
  var client = SmtpClient('enough.de', isLogEnabled: true);

  try {
    // Connect to the server
    await client.connectToServer(smtpServer, smtpPort, isSecure: false);
    await client.ehlo();

    await client.authenticate(username!, password!);

    // Build the email message
    final builder = MessageBuilder()
      ..from = [MailAddress(username.split('@')[0], username)]
      ..to = [MailAddress('Recipient Name', to)]
      ..subject = subject
      ..text = body;

    final mimeMessage = builder.buildMimeMessage();

    // Send the email
    await client.sendMessage(mimeMessage);

    print('Email sent successfully!');
    return true;
  } catch (e) {
    print('Failed to send email: $e');
    return false;
  } finally {
    await client.quit();
  }
}

Future<List<MimeMessage>> FetchMail() async {
  final SecureStorage _secureStorage = SecureStorage();
  final userName = await _secureStorage.getUserName();
  final password = await _secureStorage.getPassWord();

  print('Fetching Mail');
  String imapServerHost = 'qasid.iitk.ac.in';
  int imapServerPort = 143;
  bool isImapServerSecure = false;
  final client = ImapClient(isLogEnabled: true);
  print("connected to client");
  try {
    await client.connectToServer(imapServerHost, imapServerPort,
        isSecure: isImapServerSecure);
    print("connected to server");
    await client.login(userName!.split('@')[0], password!);

    print("logged in");
    final mailboxes = await client.listMailboxes();
    print('mailboxes: $mailboxes');
    await client.selectInbox();
    final fetchResult = await client.fetchRecentMessages(
        messageCount: 15, criteria: 'BODY.PEEK[]');

    await client.logout();
    // print(MailList);
    return fetchResult.messages;
  } on ImapException catch (e) {
    print('IMAP failed with $e');
    return [];
  }
}
