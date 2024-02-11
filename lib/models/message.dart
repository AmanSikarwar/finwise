class Message {
  final String id;
  final String content;
  final MessageType type;

  Message({
    required this.id,
    required this.content,
    required this.type,
  });

  Message copyWith({
    String? id,
    String? content,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'messageType': type.name,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      content: map['content'],
      type: MessageTypeExtension.fromName(map['type']),
    );
  }
}

enum MessageType {
  user,
  bot,
}

extension MessageTypeExtension on MessageType {
  String get name {
    switch (this) {
      case MessageType.user:
        return 'user';
      case MessageType.bot:
        return 'bot';
    }
  }

  static MessageType fromName(String name) {
    switch (name) {
      case 'user':
        return MessageType.user;
      case 'bot':
        return MessageType.bot;
      default:
        throw Exception('Invalid message type name: $name');
    }
  }
}
