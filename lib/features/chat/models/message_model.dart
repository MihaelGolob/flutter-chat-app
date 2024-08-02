class Message {
  final String message;
  final String senderId;
  final DateTime timeStamp;

  const Message({
    required this.message,
    required this.senderId,
    required this.timeStamp,
  });
}
