import 'package:byteloop/model/user_model.dart';

class QueryModel {
  int? id;
  String? content;
  String? assets;
  String? createdAt;
  int? commentCount;
  int? likeCount;
  String? userId;
  String? type; // <-- add this
  User? user;

  QueryModel({
    this.id,
    this.content,
    this.assets,
    this.createdAt,
    this.commentCount,
    this.likeCount,
    this.userId,
    this.type,
    this.user,
  });

  QueryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    assets = json['assets'];
    createdAt = json['created_at'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    userId = json['user_id'];
    type = json['type']; // <-- parse it
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['assets'] = assets;
    data['created_at'] = createdAt;
    data['comment_count'] = commentCount;
    data['like_count'] = likeCount;
    data['user_id'] = userId;
    data['type'] = type; // <-- include it
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
