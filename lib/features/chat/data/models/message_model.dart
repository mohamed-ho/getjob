import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.messageId,
    required super.senderAndReceiverIds,
    required super.messageContent,
    required super.timestamp,
  });
  factory MessageModel.fromMessage(Message message) {
    return MessageModel(
      messageId: message.messageId,
      senderAndReceiverIds: message.senderAndReceiverIds,
      messageContent: message.messageContent,
      timestamp: message.timestamp,
    );
  }

  factory MessageModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> message) {
    return MessageModel(
      messageId: message.id,
      senderAndReceiverIds: message[MessagesStringConst.senderAndReceiver],
      messageContent: message[MessagesStringConst.messageContent],
      timestamp: message[MessagesStringConst.messageSendTime],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      MessagesStringConst.messageContent: messageContent,
      MessagesStringConst.senderAndReceiver: senderAndReceiverIds,
      MessagesStringConst.messageSendTime: timestamp,
    };
  }
}
