import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';

class HomeChatScreen extends StatelessWidget {
  const HomeChatScreen({super.key});
  static const String id = 'HomeChatScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('chat'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FireBaseStringConst.userCollectionName)
              .doc(UserLocalDataSourceImpl().getUser().id)
              .collection(FireBaseStringConst.friendsCollectionName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('snapshot entered');
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: Text('title = ${snapshot.data!.docs}',
                      style:
                          const TextStyle(fontSize: 30, color: Colors.black)),
                );
              });
            } else if (snapshot.hasData) {
              return Center(
                child: Text('you have Error ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
