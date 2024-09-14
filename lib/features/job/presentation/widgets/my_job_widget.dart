import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';

class MyJobWidget extends StatelessWidget {
  const MyJobWidget({super.key, required this.job});
  final Job job;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.applicationsOfJobScreen,
              arguments: job);
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(job.address),
                  ListTile(
                      title: const Text('Number Of Orders'),
                      subtitle: Text('${job.numberOfOrders} orders'),
                      trailing: job.readedOrders < job.numberOfOrders
                          ? Badge.count(
                              count: job.numberOfOrders - job.readedOrders,
                              backgroundColor: MyColors.mainColor,
                              textColor: Colors.white,
                              largeSize: 20,
                            )
                          : null),
                  Text(
                    'Salary = ${job.salary} \$',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.updateJobScreen,
                                arguments: job);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.amber[300]),
                          child: const Row(
                            children: [
                              Text('Edit'),
                              Icon(Icons.edit),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<JobBloc>(context)
                                .add(DeleteJobEvent(jobId: job.id));
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 230, 38, 38)),
                          child: const Row(
                            children: [
                              Text('Delete'),
                              Icon(Icons.delete),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
