import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:getjob/features/chat/data/models/friend_model.dart';
import 'package:getjob/features/chat/data/models/message_model.dart';
import 'package:getjob/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';
import 'package:getjob/features/chat/domian/usecases/get_message_usecase.dart';
import 'package:getjob/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:getjob/features/chat/presentation/widgets/message_textfiled_widget.dart';
import 'package:getjob/features/chat/presentation/widgets/message_widget.dart';
import 'package:getjob/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessagePerson extends StatelessWidget {
  MessagePerson({super.key, required this.friend});
  FriendModel friend;
  TextEditingController controller = TextEditingController();
  String newMassage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                  radius: 20, backgroundImage: NetworkImage(friend.imageUrl)),
            ),
            Text(
              friend.name,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('you have Error please check the internet',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Expanded(
                  child: StreamBuilder(
                stream: GetMessageUsecase(
                        chatRepository: ChatRepositoryImpl(
                            chatRemoteDataSource: ChatRemoteDataSourceImpl(
                                firebaseFirestore: FirebaseFirestore.instance)))
                    .call(friend.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text('you don\'t have message'),
                      );
                    }
                    List<MessageModel> messages = List<MessageModel>.from(
                        snapshot.data!.docs
                            .map((e) => MessageModel.fromDocumentSnapshot(e)));
                    return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return MessageWidget(
                              messageContant: messages[index].messageContent,
                              messageTime: DateTime.fromMicrosecondsSinceEpoch(
                                      messages[index].timestamp.seconds)
                                  .toString(),
                              isSender: ls<UserLocalDataSource>()
                                          .getUser()
                                          .id ==
                                      messages[index].senderAndReceiverIds[0]
                                  ? true
                                  : false);
                        });
                  } else {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                },
              )),
            ),
            MessageTextFieldWidget(
              textEditingController: controller,
              onSend: () {
                if (newMassage.isNotEmpty) {
                  print('yes yes');
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<ChatBloc>(context).add(AddMessageEvent(
                      message: Message(
                          messageContent: newMassage,
                          messageId: 'id',
                          senderAndReceiverIds: [
                            UserLocalDataSourceImpl().getUser().id,
                            friend.id
                          ],
                          timestamp: Timestamp.now())));
                  newMassage = '';
                  controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('please enter the message'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              onsubmit: (value) {
                newMassage = value;
                if (newMassage.isNotEmpty) {
                  print('yes yes');
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<ChatBloc>(context).add(AddMessageEvent(
                      message: Message(
                          messageContent: newMassage,
                          messageId: 'id',
                          senderAndReceiverIds: [
                            UserLocalDataSourceImpl().getUser().id,
                            friend.id
                          ],
                          timestamp: Timestamp.now())));
                  newMassage = '';
                  controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('please enter the message'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
