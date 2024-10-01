import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/worker_features/presentation/widgets/Search_job_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.searchItem});
  TextEditingController searchController = TextEditingController();
  final String searchItem;
  @override
  Widget build(BuildContext context) {
    searchController.text = searchItem;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<JobBloc>(context).add(GetJobsEvent());
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: Text(searchItem),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
        child: Column(
          children: [
            Expanded(
                child: BlocBuilder<JobBloc, JobState>(
              bloc: BlocProvider.of(context)
                ..add(GetJobsWithFilterEvent(
                    filterJob: FilterJob(category: searchItem))),
              builder: (context, state) {
                if (state is JobErrorState) {
                  return const Text('you have Error');
                } else if (state is JobLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is JobGetedState) {
                  return Column(
                    children: [
                      Text(
                        '${state.jobs.length} Job Opportunity',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.jobs.length,
                            itemBuilder: (context, index) {
                              return SearchJobWidget(
                                job: state.jobs[index],
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  BlocProvider.of<JobBloc>(context).add(GetJobsWithFilterEvent(
                      filterJob: FilterJob(category: searchItem)));
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
