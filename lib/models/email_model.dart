class EmailModel {
  String senderEmail;
  String subject;
  String name;
  String appName;
  String message;

  EmailModel({
    required this.senderEmail,
    required this.subject,
    required this.name,
    required this.appName,
    required this.message,
  });

  toJson() {
    return {
      'sender_email': senderEmail,
      'subject': subject,
      'name': name,
      'app_name': appName,
      'message': message
    };
  }
}
