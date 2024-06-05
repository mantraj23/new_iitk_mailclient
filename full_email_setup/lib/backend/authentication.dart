import 'package:enough_mail/enough_mail.dart';

Future<bool> authenticateUser({
  required String email,
  required String password,
})async {
  
  // SMTP server details
  print("Username ${email} PAssword :  password dekhaga saale");
  const smtpServer = 'mmtp.iitk.ac.in';
  const smtpPort = 25; // Use 465 if your server requires SSL from the start
  final username = email;
  // Create an SMTP client
  var client = SmtpClient('enough.de',isLogEnabled: true);

  try {
    // Connect to the server
    await client.connectToServer(smtpServer, smtpPort, isSecure: false);
    await client.ehlo();

   
    await client.authenticate(username, password);

    print('Logged in successfully!');
    return true;
  } catch (e) {
    print('Failed: $e');
    return false;
  } finally {
    await client.quit();
  }
}