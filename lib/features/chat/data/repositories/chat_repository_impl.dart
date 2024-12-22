import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:getjob/features/chat/data/models/message_model.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});
  @override
  Future<Either<Failure, void>> addFriend(String friendId) async {
    try {
      final result = await chatRemoteDataSource.addFriend(friendId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> addMessage(Message message) async {
    try {
      final result = await chatRemoteDataSource
          .addMessage(MessageModel.fromMessage(message));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFriend(String friendId) async {
    try {
      final result = await chatRemoteDataSource.deleteFriend(friendId);
      // ignore: void_checks
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      final result = await chatRemoteDataSource.deleteMessage(messageId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getMessage(String friendId) async* {
    try {
      yield* chatRemoteDataSource.getMessages(friendId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFriend(String userId) async* {
    try {
      yield* chatRemoteDataSource.getFriend(userId);
    } catch (e) {
      rethrow;
    }
  }
}
