class ChatModel {
  final String name;
  final String id;
  final String message;
  final String time;
  final int unread;

  ChatModel({
    required this.name,
    required this.id,
    required this.message,
    required this.time,
    required this.unread,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final unreadCount = json['id'] % 3; // fake unread logic

    return ChatModel(
      id: json['id'].toString(),
      name: json['name'],
      message: json['body'],
      time: unreadCount > 0 ? '2 min ago' : 'Yesterday',
      unread: unreadCount,
    );
  }
}
