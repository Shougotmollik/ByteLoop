class ReplyModel {
  final int id;
  final int postId;
  final String userId;
  final String reply;
  final String? userAvatarUrl;
  final String? username;
  final DateTime createdAt;

  ReplyModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.reply,
    this.userAvatarUrl,
    this.username,
    required this.createdAt,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    final userData = json['users'] ?? {};
    final metadata = userData['metadata'] ?? {};

    return ReplyModel(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      reply: json['reply'],
      userAvatarUrl: metadata['image'] ?? '',
      username: metadata['name'] ?? 'Unknown',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
