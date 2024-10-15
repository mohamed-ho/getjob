import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/core/widgets/custom_error_dialog.dart';
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
  bool valid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        children: [
          const Text(
            'Message',
            style: TextStyle(fontSize: 20),
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
                            radius: 25.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(320),
                              child: CachedNetworkImage(
                                imageUrl: friends[index].imageUrl,
                                width: 50.w,
                                height: 50.w,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/icons/error.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          title: Text(friends[index].name),
                          subtitle: const Text('start you chat'),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return customErrorDialog(context,
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

ImageProvider HandleImageError(String url) {
  try {
    return CachedNetworkImageProvider(url);
  } catch (e) {
    return const AssetImage('assets/icons/error.png');
  }
}
