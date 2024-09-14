import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/features/applications/data/data_source/application_remote_data_source.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/chat/presentation/bloc/chat_bloc.dart';

class ApplicationOfJobWidget extends StatelessWidget {
  ApplicationOfJobWidget({
    super.key,
    required this.application,
  });
  final Application application;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatLoadingState)
          isLoading = true;
        else if (state is ChatLoadedState) {
          isLoading = false;
          Navigator.pushNamed(context, Routes.chatScreen);
        }
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              application.applicationOwnerImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${application.firstName} ${application.lastName}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  application.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  application.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              Navigator.pushNamed(context, Routes.cvScreen,
                                  arguments: application.filePath);
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('there are error please try again'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.mainColor,
                              foregroundColor: Colors.white),
                          child: const Row(
                            children: [
                              Text(
                                'CV',
                              ),
                              Icon(Icons.book_rounded)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ChatBloc>(context).add(
                                AddFriendEvent(
                                    friendId: application.applicationOwnerId));
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: MyColors.mainColor),
                          child: const Row(
                            children: [
                              Text('Chat'),
                              Icon(Icons.message),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
