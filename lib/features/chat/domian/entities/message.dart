import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final List senderAndReceiverIds;
  final String messageContent;
  final Timestamp timestamp;

  Message({
    required this.messageId,
    required this.senderAndReceiverIds,
    required this.messageContent,
    required this.timestamp,
  });
}
