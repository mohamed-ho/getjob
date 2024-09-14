import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/core/widgets/custom_Error_dialog.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:getjob/features/chat/data/models/friend_model.dart';
import 'package:getjob/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:getjob/features/chat/domian/usecases/get_friend_usecase.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                isSearch
                    ? Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Search'),
                        ),
                      )
                    : const Text(
                        'Message',
                        style: TextStyle(fontSize: 20),
                      ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: GetFriendUsecase(
                    chatRepository: ChatRepositoryImpl(
                        chatRemoteDataSource: ChatRemoteDataSourceImpl(
                            firebaseFirestore: FirebaseFirestore.instance)))
                .call(UserLocalDataSourceImpl().getUser().id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('you don\'t have friends'),
                  );
                }
                List<FriendModel> friends = List<FriendModel>.from(snapshot
                    .data!.docs
                    .map((e) => FriendModel.documentSnapshot(e)));

                return ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.messagePersonScreen,
                              arguments: friends[index]);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(friends[index].imageUrl)),
                          title: Text(friends[index].name),
                          subtitle: const Text('start you chat'),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return CustomErrorDialog(context,
                    "you have error ${snapshot.error}", "you have Error");
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    ));
  }
}
