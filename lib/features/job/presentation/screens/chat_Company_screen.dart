// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:getjob/core/constants/string.dart';
// import 'package:getjob/core/routes.dart';
// import 'package:getjob/features/chat/domian/entities/friend.dart';
// import 'package:getjob/features/company_features/data/Data_source/job_data_source.dart';

// import 'package:getjob/features/company_features/data/models/messagModel.dart';
// import 'package:getjob/features/company_features/data/models/personModal.dart';
// import 'package:getjob/main.dart';
// import 'package:flutter/material.dart';

// class ChatCompanyScreen extends StatefulWidget {
//   const ChatCompanyScreen({super.key});

//   @override
//   State<ChatCompanyScreen> createState() => _ChatCompanyScreenState();
// }

// class _ChatCompanyScreenState extends State<ChatCompanyScreen> {
//   bool isSearch = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 40,
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back_ios)),
//                 isSearch
//                     ? Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               hintText: 'Search'),
//                         ),
//                       )
//                     : const Text(
//                         'Message',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         isSearch = !isSearch;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.search,
//                       size: 30,
//                     )),
//               ],
//             ),
//           ),
//           Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//             stream: JobDataSource()
//                 .getFriend(company_id: sharedpref.getString(companyIdKey)),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<Friend> friends = [];

//                 for (var acc in snapshot.data!.docs) {
//                   var data = acc.data() as Map<String, dynamic>;
//                   friends.add(Friend.formJson(json: data));
//                 }
//                 return ListView.builder(
//                     itemCount: friends.length,
//                     itemBuilder: (context, index) {
//                       return FutureBuilder(
//                           future: JobDataSource().getWorkerDetails(
//                               workerId: friends[index].worker_Id!),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               Map<String, dynamic> data =
//                                   snapshot.data as Map<String, dynamic>;

//                               PersonModel person = PersonModel.fromJson(data);

//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                       context, Routes.messagePersonScreen,
//                                       arguments: friends[index]);
//                                 },
//                                 child: ListTile(
//                                   leading: const CircleAvatar(
//                                     backgroundImage: AssetImage(
//                                         'assets/images/workerDefaultImage.jpg'),
//                                   ),
//                                   title: Text(person.name!),
//                                   subtitle: StreamBuilder<QuerySnapshot>(
//                                     stream: JobDataSource().getLastMessage(
//                                         friends[index].worker_Id,
//                                         friends[index].company_Id),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.hasData) {
//                                         var data = snapshot.data
//                                             as Map<String, dynamic>;
//                                         MessageModal lastMessage =
//                                             MessageModal.fromJson(data);
//                                         return Text(lastMessage.coutent!);
//                                       } else {
//                                         return const Text('start you chat');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text(snapshot.error.toString());
//                             } else {
//                               return const Center(child: Text('loading....'));
//                             }
//                           });
//                     });
//               } else {
//                 return const Center(child: Text('loading....'));
//               }
//             },
//           ))
//         ],
//       ),
//     ));
//   }
// }
