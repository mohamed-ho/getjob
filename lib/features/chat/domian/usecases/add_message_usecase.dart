import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class AddMessageUsecase implements Usecase<void, Message> {
  final ChatRepository chatRepository;

  AddMessageUsecase({required this.chatRepository});
  @override
  Future<Either<Failure, void>> call(Message params) async {
    return await chatRepository.addMessage(params);
  }
}
