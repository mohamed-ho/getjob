import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/chat/data/models/friend_model.dart';
import 'package:getjob/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> addMessage(MessageModel message);
  Future<void> deleteMessage(String messageId);
  Stream<List<Map<String, dynamic>>> getMessages(String friendId);
  Future<void> addFriend(String friendId);
  deleteFriend(String friendId);
  Future<FriendModel> getFriendData(String friendId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getFriend(String userid);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ChatRemoteDataSourceImpl({required this.firebaseFirestore});
  @override
  addFriend(String friendId) async {
    try {
      WriteBatch batch = firebaseFirestore.batch();

      final friendData = await getFriendData(friendId);
      final userData =
          await getFriendData(UserLocalDataSourceImpl().getUser().id);
      final addFriendToUser = firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(UserLocalDataSourceImpl().getUser().id)
          .collection(FireBaseStringConst.friendsCollectionName)
          .doc(friendId);

      final addUserToFriend = firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(friendId)
          .collection(FireBaseStringConst.friendsCollectionName)
          .doc(UserLocalDataSourceImpl().getUser().id);
      batch.set(addFriendToUser, friendData.toJson());
      batch.set(addUserToFriend, userData.toJson());
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  @override
  addMessage(MessageModel message) async {
    try {
      await firebaseFirestore
          .collection(FireBaseStringConst.messagesCollectionName)
          .add(message.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  deleteFriend(String friendId) async {
    try {
      final batch = firebaseFirestore.batch();

      final firstUser = firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(UserLocalDataSourceImpl().getUser().id)
          .collection(FireBaseStringConst.friendsCollectionName)
          .doc(friendId);
      final secondUser = firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(friendId)
          .collection(FireBaseStringConst.friendsCollectionName)
          .doc(UserLocalDataSourceImpl().getUser().id);

      batch.delete(firstUser);
      batch.delete(secondUser);
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  @override
  deleteMessage(String messageId) async {
    await firebaseFirestore
        .collection(FireBaseStringConst.messagesCollectionName)
        .doc(messageId)
        .delete();
  }

  @override
  Stream<List<Map<String, dynamic>>> getMessages(String friendId) async* {
    final userId = ls<UserLocalDataSource>().getUser().id;

    // Query Firestore to get messages where the senderAndReceiver array contains the current user ID
    final messageStream = firebaseFirestore
        .collection(FireBaseStringConst.messagesCollectionName)
        .orderBy(MessagesStringConst.messageSendTime, descending: true)
        .where(
          MessagesStringConst.senderAndReceiver,
          arrayContains: userId,
        )
        .snapshots();

    // Filter the results to ensure they include both the userId and friendId
    yield* messageStream.map((snapshot) {
      return snapshot.docs
          .where((doc) {
            final data = doc.data();
            final senderAndReceiver =
                List<String>.from(data[MessagesStringConst.senderAndReceiver]);

            // Check if the array contains both userId and friendId
            return senderAndReceiver.contains(friendId) &&
                senderAndReceiver.contains(userId);
          })
          .map((doc) => doc.data())
          .toList();
    });
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFriend(String userid) async* {
    try {
      yield* firebaseFirestore
          .collection(FireBaseStringConst.userCollectionName)
          .doc(userid)
          .collection(FireBaseStringConst.friendsCollectionName)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FriendModel> getFriendData(String friendId) async {
    final response = await firebaseFirestore
        .collection(FireBaseStringConst.userCollectionName)
        .doc(friendId)
        .get();
    return FriendModel.userDocumentSnapshot(response);
  }
}
