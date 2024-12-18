//responsive
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/data/data_surce/user_remote_data_source.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/worker_features/presentation/widgets/custom_drawer_widget.dart';
import 'package:getjob/features/worker_features/presentation/widgets/filter_widget.dart';
import 'package:getjob/features/worker_features/presentation/widgets/popular_jop_widget.dart';
import 'package:getjob/features/worker_features/presentation/widgets/recent_jop_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String searchItem = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                child: Image.asset('assets/images/Menu.png'),
                onTap: () async {
                  _scaffoldKey.currentState?.openDrawer();
                }),
            CircleAvatar(
                radius: 25,
                backgroundImage:
                    NetworkImage(UserLocalDataSourceImpl().getUser().image))
          ],
        ),
      ),
      drawer: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is LoadingUserState) {
            Navigator.pop(context);
            showDialog(
                barrierColor: Colors.white,
                context: context,
                builder: (context) => const Dialog(
                      backgroundColor: Colors.white,
                      child: Center(child: CircularProgressIndicator()),
                    ));
          } else if (state is UserErrorState) {
            Navigator.pop(context);
            showDialog(
                barrierColor: Colors.white,
                context: context,
                builder: (context) => SimpleDialog(
                      title: const Text('Error message'),
                      children: [
                        const Text('you have Error please try again'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          child: const Text('OK'),
                        )
                      ],
                    ));
          } else if (state is LoadedUserState) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.loginScreen, (route) => false);
          }
        },
        child: Drawer(
          backgroundColor: MyColors.senderMessageColor,
          width: 300.w,
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(UserLocalDataSourceImpl().getUser().image),
                  radius: 60.w,
                ),
                Text(
                  UserLocalDataSourceImpl().getUser().name,
                  style: TextStyle(fontSize: 22.spMax),
                ),
                Text(UserLocalDataSourceImpl().getUser().email),
                SizedBox(
                  height: 20.h,
                ),
                CustomDrawerWidget(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.profileScreen);
                    },
                    path: 'assets/icons/icon-user.png',
                    text: 'Edit Profile'),
                CustomDrawerWidget(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.jobOrederScreen);
                    },
                    path: 'assets/icons/icon-history.png',
                    text: 'Applications'),
                CustomDrawerWidget(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myJobsScreen);
                    },
                    path: 'assets/icons/addJob.png',
                    text: 'job offers'),
                CustomDrawerWidget(
                    onTap: () {
                      ls<UserRemoteDataSource>().logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.loginScreen, (route) => true);
                    },
                    path: 'assets/icons/icon-logout.png',
                    text: 'Logout'),
                const SizedBox(
                  height: 40,
                ),
                const Divider(),
                CustomDrawerWidget(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                title: const Text(
                                  'Warning message',
                                  style: TextStyle(color: Colors.red),
                                ),
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                        'you sure you want to delete you account'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<UserBloc>(context)
                                                .add(DeleteAccountEvent());
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.white),
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white),
                                          child: const Text('No'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ));
                    },
                    path: 'assets/icons/delete.png',
                    text: 'Delete Account'),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pushNamedAndRemoveUntil(context, Routes.controlScreen,
              (Route route) {
            return false;
          });
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocProvider(
                        create: (context) => ls<JobBloc>()..add(GetJobsEvent()),
                        child: BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state is JobGetedState) {
                              final category = List<String>.from(
                                  state.jobs.map((e) => e.category));
                              return SizedBox(
                                  width: .7.sw,
                                  child: SearchField(
                                    onTapOutside: (value) {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    },
                                    onScroll: (p0, p1) {},
                                    maxSuggestionsInViewPort: 6,
                                    searchStyle: TextStyle(fontSize: 18.spMax),
                                    suggestionStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.spMax,
                                        color: Colors.white),
                                    suggestionsDecoration: SuggestionDecoration(
                                        color: MyColors.mainColor,
                                        borderRadius:
                                            BorderRadius.circular(16.w)),
                                    suggestions: category
                                        .map((e) =>
                                            SearchFieldListItem(e, item: e))
                                        .toList(),
                                    autoCorrect: true,
                                    onSuggestionTap: (value) {
                                      searchItem = value.item.toString();
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                      Navigator.pushNamed(
                                          context, Routes.searchScreen,
                                          arguments: searchItem);
                                    },
                                    searchInputDecoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Serach here....',
                                        hintStyle:
                                            TextStyle(fontSize: 16.spMax),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.w),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20.w))),
                                  ));
                            } else {
                              return SizedBox(
                                width: .7.sw,
                                child: TextField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Serach here....',
                                      hintStyle: TextStyle(fontSize: 16.spMax),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20.w))),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      InkWell(
                        child: Image.asset('assets/images/Go BTN.png'),
                        onTap: () {
                          filterWidget(context);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Job',
                        style: TextStyle(fontSize: 20.spMax),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.morePopulareJobScreen);
                          },
                          child: const Text('show All')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) => ls<JobBloc>()
                      ..add(const GetFevoriteJobsEvent(numberOfJobs: 10)),
                    child: BlocBuilder<JobBloc, JobState>(
                      builder: (context, state) {
                        if (state is JobErrorState) {
                          return const Text('error');
                        } else if (state is JobLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is JobGetedState) {
                          if (state.jobs.isEmpty) {
                            return const Center(
                              child: Text('Empty jobs'),
                            );
                          }
                          return ListView.builder(
                              itemCount: state.jobs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return PopularJopWidget(
                                  job: state.jobs[index],
                                );
                              });
                        } else {
                          BlocProvider.of<JobBloc>(context).add(
                              const GetFevoriteJobsEvent(numberOfJobs: 10));
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Post',
                        style: TextStyle(fontSize: 16.spMax),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.moreRecentJobScreen),
                        child: Text(
                          'Show All',
                          style: TextStyle(fontSize: 12.spMax),
                        ),
                      ),
                    ],
                  ),
                ),
                //--------------------------------------------------------
                SizedBox(
                    height: 270.h,
                    child: BlocProvider(
                      create: (context) => ls<JobBloc>()..add(GetJobsEvent()),
                      child: BlocBuilder<JobBloc, JobState>(
                        builder: (context, state) {
                          if (state is JobErrorState) {
                            return const Center(
                              child: Text('you have Error'),
                            );
                          } else if (state is JobLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is JobGetedState) {
                            if (state.jobs.isEmpty) {
                              return const Center(
                                child: Text('jobs is Empty'),
                              );
                            }
                            return ListView.builder(
                                itemCount: state.jobs.length,
                                itemBuilder: (context, index) {
                                  return RecentJopWidget(
                                    job: state.jobs[index],
                                  );
                                });
                          } else {
                            BlocProvider.of<JobBloc>(context)
                                .add(GetJobsEvent());
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
