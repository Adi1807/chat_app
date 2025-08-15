// Small model
class ChatMessage {
  final String id;
  final String userId;
  final String username;
  final String avatarUrl;
  final String text;
  final DateTime time;
  final String? fileName;
  final String? fileSize;

  ChatMessage({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.text,
    required this.time,
    this.fileName,
    this.fileSize,
  });
  bool get isFile => fileName != null && fileSize != null;
}