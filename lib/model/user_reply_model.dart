import 'package:byteloop/model/user_model.dart';

class UserReplyModel {
  int? id;
  String? reply;
  String? createdAt;
  String? userId;
  UserModel? user;
  int? postId;

  UserReplyModel({this.id, this.reply, this.createdAt, this.userId, this.user});

  UserReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    postId = json['post_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['post_id'] = postId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
