class Message {
  final String message;
  final String senderId;
  final DateTime timestamp;

  const Message({
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'timeStamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      senderId: map['senderId'],
      timestamp: map['timeStamp'],
    );
  }
}
