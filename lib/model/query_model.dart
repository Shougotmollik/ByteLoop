import 'package:byteloop/model/likes_model.dart';
import 'package:byteloop/model/user_model.dart';

class QueryModel {
  int? id;
  String? content;
  String? assets;
  String? createdAt;
  int? commentCount;
  int? likeCount;
  String? userId;
  String? type;
  UserModel? user;
  List<LikesModel>? likes;

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
    this.likes,
  });

  QueryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    assets = json['assets'];
    createdAt = json['created_at'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    userId = json['user_id'];
    type = json['type'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json["likes"] != null) {
      likes = <LikesModel>[];
      json["likes"].forEach((v) {
        likes!.add(LikesModel.fromJson(v));
      });
    }
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
    data['type'] = type;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
