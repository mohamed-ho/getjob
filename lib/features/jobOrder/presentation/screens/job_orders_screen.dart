import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/jobOrder/presentation/bloc/joborder_bloc.dart';
import 'package:getjob/features/jobOrder/presentation/widgets/job_order_widget.dart';

class JobOrdersScreen extends StatelessWidget {
  const JobOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Orders'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<JoborderBloc, JoborderState>(
        bloc: BlocProvider.of(context)
          ..add(
              GetJobOrderEvent(userId: ls<UserLocalDataSource>().getUser().id)),
        builder: (context, state) {
          if (state is JobOrderErrorState) {
            return const Center(
              child: Text('you have Error'),
            );
          } else if (state is JobOrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobOrderGetedState) {
            if (state.jobOrders.isEmpty) {
              return const Center(
                child: Text('you don\'t have job orders'),
              );
            }
            return ListView.builder(
                itemCount: state.jobOrders.length,
                itemBuilder: (context, index) {
                  return JobOrderWidget(jobOrder: state.jobOrders[index]);
                });
          } else {
            BlocProvider.of<JoborderBloc>(context).add(GetJobOrderEvent(
                userId: ls<UserLocalDataSource>().getUser().id));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
