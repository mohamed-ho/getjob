import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/chat/domian/entities/friend.dart';

class FriendModel extends Friend {
  FriendModel(
      {required super.name, required super.imageUrl, required super.id});
  factory FriendModel.formFriend(Friend friend) {
    return FriendModel(
        name: friend.name, imageUrl: friend.imageUrl, id: friend.id);
  }

  factory FriendModel.documentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    return FriendModel(
        name: data[FriendStringConst.friendName],
        imageUrl: data[FriendStringConst.friendImageUrl],
        id: data.id);
  }
  factory FriendModel.userDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    return FriendModel(
        name: data[UserStringConst.userName],
        imageUrl: data[UserStringConst.userImage],
        id: data.id);
  }
  Map<String, dynamic> toJson() {
    return {
      FriendStringConst.friendId: id,
      FriendStringConst.friendImageUrl: imageUrl,
      FriendStringConst.friendName: name
    };
  }
}
