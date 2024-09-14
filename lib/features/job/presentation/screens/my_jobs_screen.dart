import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';

import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/job/presentation/widgets/my_job_widget.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 28,
                backgroundImage:
                    NetworkImage(UserLocalDataSourceImpl().getUser().image),
              ),
            ),
            const Text(
              'My Jobs',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
      body: BlocBuilder<JobBloc, JobState>(
        bloc: BlocProvider.of(context)
          ..add(GetJobsWithFilterEvent(
              filterJob: FilterJob(
                  companyId: UserLocalDataSourceImpl().getUser().id))),
        builder: (context, state) {
          if (state is JobErrorState) {
            return Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('you have Error ${state.message}'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Icon(
                        Icons.error_outline,
                        size: 70,
                        color: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<JobBloc>(context).add(
                            GetJobsWithFilterEvent(
                                filterJob: FilterJob(
                                    companyId: UserLocalDataSourceImpl()
                                        .getUser()
                                        .id)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.mainColor),
                      child: const Text('Try Again'),
                    )
                  ],
                ),
              ),
            );
          } else if (state is JobGetedState) {
            return state.jobs.isEmpty
                ? const Center(
                    child: Text('No Jobs'),
                  )
                : ListView.builder(
                    itemCount: state.jobs.length,
                    itemBuilder: (context, index) {
                      return MyJobWidget(job: state.jobs[index]);
                    });
          } else if (state is JobLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            BlocProvider.of<JobBloc>(context).add(GetJobsWithFilterEvent(
                filterJob: FilterJob(
                    companyId: UserLocalDataSourceImpl().getUser().id)));
            return const Center(
              child: Text('there are diffirent state '),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addJobScreen);
          },
          foregroundColor: Colors.white,
          backgroundColor: MyColors.mainColor,
          child: const Icon(Icons.add)),
    );
  }
}
