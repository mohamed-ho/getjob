import 'dart:ui';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/constants/list_of_job_types.dart';
import 'package:getjob/core/widgets/custom_Error_dialog.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/job/presentation/widgets/add_job_text_form_field.dart';

// ignore: must_be_immutable
class UpdateJobScreen extends StatefulWidget {
  const UpdateJobScreen({super.key, required this.job});
  final Job job;
  @override
  State<UpdateJobScreen> createState() => _UpdateJobScreenState();
}

class _UpdateJobScreenState extends State<UpdateJobScreen> {
  TextEditingController title = TextEditingController();

  TextEditingController salary = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController category = TextEditingController();

  TextEditingController subCategory = TextEditingController();

  TextEditingController qualificationControll = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String? valueOfJobType;

  String? address;
  bool updateAddress = false;
  bool loading = false;
  List<String> qualifications = [];

  @override
  void initState() {
    super.initState();
    title.text = widget.job.title;
    salary.text = widget.job.salary.toString();
    description.text = widget.job.description;
    category.text = widget.job.category;
    subCategory.text = widget.job.subCategory;
    address = widget.job.address;
    qualifications = List<String>.from(
        widget.job.jobQualifications.map((e) => e.toString()));
    valueOfJobType = widget.job.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundcolor,
      appBar: AppBar(
        title: const Text('Update Job'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobErrorState) {
            loading = false;
            setState(() {});
            CustomErrorDialog(context, state.message, 'you have Error');
          } else if (state is JobLoadingState) {
            loading = true;
            setState(() {});
          } else if (state is JobLoadedState) {
            setState(() {
              @override
              void dispose() {
                title.dispose();
                salary.dispose();
                description.dispose();
                category.dispose();
                subCategory.dispose();
                qualifications = [];
                address = '';
              }

              loading = false;
            });
            BlocProvider.of<JobBloc>(context).add(GetJobsWithFilterEvent(
                filterJob: FilterJob(
                    companyId: UserLocalDataSourceImpl().getUser().id)));
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('update job is success '),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 350),
            ));
          }
        },
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                              UserLocalDataSourceImpl().getUser().image),
                        ),
                        AddJobTextFormField(
                          controller: title,
                          label: 'please Enter job title',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the job title';
                            }
                            return null;
                          },
                        ),
                        AddJobTextFormField(
                          controller: category,
                          label: 'please Enter job category',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the job category';
                            }
                            return null;
                          },
                        ),
                        AddJobTextFormField(
                          controller: subCategory,
                          label: 'please Enter job subcategory',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the job subcategory';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return 'plese choose the job type';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                              hint: const Text('please Choose the job type'),
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: MyColors.SenderMessageColor,
                              value: valueOfJobType,
                              items: List<DropdownMenuItem<String>>.from(
                                  listOFJobTypes
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))).toList(),
                              onChanged: (value) {
                                valueOfJobType = value!;
                              }),
                        ),
                        AddJobTextFormField(
                          controller: description,
                          label: 'please Enter job description',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the job description';
                            }
                            return null;
                          },
                        ),
                        Visibility(
                            visible: qualifications.isNotEmpty,
                            child: SizedBox(
                              height: 80,
                              child: ListView.builder(
                                  itemCount: qualifications.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                        '${index + 1} - ${qualifications[index]}');
                                  }),
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: AddJobTextFormField(
                                controller: qualificationControll,
                                label: 'please Enter job Qualifications',
                                validator: (value) {
                                  if (qualifications.isEmpty) {
                                    return 'please enter at last one Qualification';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (qualificationControll
                                          .text.isNotEmpty) {
                                        qualifications
                                            .add(qualificationControll.text);
                                        qualificationControll.clear();
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(Icons.add)),
                                IconButton(
                                    onPressed: () {
                                      qualifications = [];
                                      qualificationControll.clear();
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                          ],
                        ),
                        updateAddress
                            ? SelectState(
                                onCountryChanged: (country) {
                                  address = country;
                                },
                                onStateChanged: (state) {
                                  address = '$address/$state';
                                },
                                onCityChanged: (city) {
                                  address = '$address/$city';
                                },
                                dropdownColor: MyColors.SenderMessageColor,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(address!),
                                  IconButton(
                                      onPressed: () {
                                        updateAddress = true;
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.amber[300]))
                                ],
                              ),
                        AddJobTextFormField(
                          controller: salary,
                          label: 'please Enter job salary',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the job salary';
                            } else if (int.tryParse(value) == null) {
                              return 'please enter valid salary';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (address == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('please add the job address'),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  BlocProvider.of<JobBloc>(context).add(
                                      UpdateJobEvent(
                                          job: Job(
                                              id: widget.job.id,
                                              title: title.text,
                                              salary: int.parse(salary.text),
                                              description: description.text,
                                              address: address!,
                                              type: valueOfJobType!,
                                              category: category.text,
                                              subCategory: subCategory.text,
                                              companyId:
                                                  UserLocalDataSourceImpl()
                                                      .getUser()
                                                      .id,
                                              companyName:
                                                  UserLocalDataSourceImpl()
                                                      .getUser()
                                                      .name,
                                              companyImage:
                                                  UserLocalDataSourceImpl()
                                                      .getUser()
                                                      .image,
                                              numberOfOrders:
                                                  widget.job.numberOfOrders,
                                              readedOrders:
                                                  widget.job.readedOrders,
                                              jobQualifications: qualifications,
                                              sharedAt: widget.job.sharedAt)));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                maximumSize: const Size(200, 60),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.amber[300]),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update Job',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.add,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}



 



  // final String address;




