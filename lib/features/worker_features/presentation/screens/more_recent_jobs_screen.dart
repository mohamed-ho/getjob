import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';

import 'package:getjob/features/worker_features/presentation/widgets/recent_jop_widget.dart';

class MoreRecentJobsScreen extends StatelessWidget {
  const MoreRecentJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Jobs'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) =>
            ls<JobBloc>()..add(const GetFevoriteJobsEvent(numberOfJobs: 30)),
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state is JobErrorState) {
              return Center(
                child: Column(
                  children: [
                    const Text('you have error please try again'),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<JobBloc>(context).add(GetJobsEvent());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.red),
                      child: const Text('ok'),
                    ),
                  ],
                ),
              );
            }
            if (state is JobLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is JobGetedState) {
              if (state.jobs.isEmpty) {
                return const Center(
                  child: Text('there are no jobs'),
                );
              }
              return ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    return RecentJopWidget(job: state.jobs[index]);
                  });
            } else {
              BlocProvider.of<JobBloc>(context).add(GetJobsEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
