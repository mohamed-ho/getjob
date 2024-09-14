import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class GetFriendUsecase {
  final ChatRepository chatRepository;
  GetFriendUsecase({required this.chatRepository});
  Stream<QuerySnapshot<Map<String, dynamic>>> call(String userId) async* {
    try {
      yield* chatRepository.getFriend(userId);
    } catch (e) {
      rethrow;
    }
  }
}
