class Email {
  final int id;
  final String subject;
  final String sender;
  final String body;

  Email({
    required this.id,
    required this.subject,
    required this.sender,
    required this.body,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      subject: json['subject'],
      sender: json['sender'],
      body: json['body'],
    );
  }
}
