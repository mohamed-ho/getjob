import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class GetMessageUsecase {
  final ChatRepository chatRepository;
  GetMessageUsecase({required this.chatRepository});

  Stream<QuerySnapshot<Map<String, dynamic>>> call(String friendId) async* {
    try {
      yield* chatRepository.getMessage(friendId);
    } catch (e) {
      rethrow;
    }
  }
}
