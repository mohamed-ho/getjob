import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/widgets/custom_Error_dialog.dart';
import 'package:getjob/features/applications/presentation/bloc/application_bloc.dart';
import 'package:getjob/features/applications/presentation/widgets/application_of_job_widget.dart';
import 'package:getjob/features/job/domain/entities/job.dart';

class ApplicationsOfJobScreen extends StatelessWidget {
  const ApplicationsOfJobScreen({super.key, required this.job});
  final Job job;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(job.title),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        bloc: BlocProvider.of<ApplicationBloc>(context)
          ..add(GetJobApplicationsEvent(jobId: job.id)),
        builder: (context, state) {
          if (state is ApplicationErrorState) {
            return CustomErrorDialog(
                context, 'you have Error ${state.message}', 'you have error');
          } else if (state is ApplicationGetedState) {
            return ListView.builder(
              itemCount: state.applications.length,
              itemBuilder: (context, index) {
                return ApplicationOfJobWidget(
                    application: state.applications[index]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
