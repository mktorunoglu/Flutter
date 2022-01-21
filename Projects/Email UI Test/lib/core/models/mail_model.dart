class MailModel {
  final String sender;
  final String subject;
  final String content;
  final String date;
  final bool readStatus;
  final bool favStatus;

  MailModel(
    this.sender,
    this.subject,
    this.content,
    this.date,
    this.readStatus,
    this.favStatus,
  );
}
