import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> addFriend(String friendId);
  Future<Either<Failure, void>> deleteFriend(String friendId);
  Future<Either<Failure, void>> addMessage(Message message);
  Future<Either<Failure, void>> deleteMessage(String messageId);
  Stream<List<Map<String, dynamic>>> getMessage(String friendId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getFriend(String userId);
}
