// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:getjob/core/constants/colors.dart';
// import 'package:getjob/features/job/presentation/widgets/order_widget.dart';
// import 'package:getjob/features/job/data/Data_source/job_data_source.dart';
// import 'package:getjob/features/job/data/models/jobModels.dart';
// import 'package:getjob/features/job/data/models/order_model.dart';
// import 'package:flutter/material.dart';

// class JobDetails extends StatelessWidget {
//   const JobDetails({super.key});
//   static String id = 'jobDetails';
//   @override
//   Widget build(BuildContext context) {
//     JobModels job = ModalRoute.of(context)!.settings.arguments as JobModels;
//     return Scaffold(
//       backgroundColor: MyColors.backgroundcolor,
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(
//                     Icons.arrow_back_ios_new_outlined,
//                     color: MyColors.mainColor,
//                     size: 30,
//                   )),
//               const Text(
//                 'Facebook',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const CircleAvatar(
//                 radius: 30,
//                 backgroundImage: ExactAssetImage('assets/images/Facebook.png'),
//               ),
//             ],
//           ),
//           Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//             stream: JobDataSource().getOrders(job.jobId!),
//             builder: (context, snapshot) {
//               print(job.jobId);
//               if (snapshot.hasData) {
//                 List<OrderModel> orders = [];
//                 for (var element in snapshot.data!.docs) {
//                   var data = element.data() as Map<String, dynamic>;
//                   orders.add(OrderModel.formJson(data));
//                 }
//                 return ListView.builder(
//                     itemCount: orders.length,
//                     itemBuilder: (context, index) {
//                       return OrderWidget(
//                         order: orders[index],
//                       );
//                     });
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('you have error${snapshot.error}'),
//                 );
//               } else {
//                 return const Center(
//                   child: Text('loading....'),
//                 );
//               }
//             },
//           ))
//         ]),
//       ),
//     );
//   }
// }
