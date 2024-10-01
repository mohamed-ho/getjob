import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/worker_features/presentation/widgets/Search_job_widget.dart';
import 'package:flutter/material.dart';

class SearchScreenWithMoreItem extends StatelessWidget {
  const SearchScreenWithMoreItem({super.key, required this.filterJob});
  final FilterJob filterJob;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundcolor,
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
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          )),
                      const Text(
                        'Jobs',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<JobBloc, JobState>(
                    bloc: BlocProvider.of<JobBloc>(context)
                      ..add(GetJobsWithFilterEvent(filterJob: filterJob)),
                    builder: (context, state) {
                      if (state is JobErrorState) {
                        return const Center(
                          child: Text('you have Error'),
                        );
                      } else if (state is JobGetedState) {
                        return ListView.builder(
                            itemCount: state.jobs.length,
                            itemBuilder: (context, index) {
                              return SearchJobWidget(job: state.jobs[index]);
                            });
                      } else if (state is JobLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        BlocProvider.of<JobBloc>(context)
                            .add(GetJobsWithFilterEvent(filterJob: filterJob));
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
