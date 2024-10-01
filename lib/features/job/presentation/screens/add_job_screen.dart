import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getjob/core/constants/colors.dart';
import 'package:getjob/core/constants/list_of_job_types.dart';
import 'package:getjob/core/widgets/custom_error_dialog.dart';

import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/job/presentation/widgets/add_job_text_form_field.dart';

// ignore: must_be_immutable
class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  TextEditingController title = TextEditingController();

  TextEditingController salary = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController category = TextEditingController();

  TextEditingController subCategory = TextEditingController();

  TextEditingController qualificationControll = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String? valueOfJobType;

  String? address;

  bool loading = false;
  List<String> qualifications = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundcolor,
      appBar: AppBar(
        title: const Text('Add Job'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobErrorState) {
            loading = false;
            setState(() {});
            customErrorDialog(context, state.message, 'you have Error');
          } else if (state is JobLoadingState) {
            loading = true;
            setState(() {});
          } else if (state is JobLoadedState) {
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('adding job is success'),
              backgroundColor: Colors.green,
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
                              dropdownColor: MyColors.senderMessageColor,
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
                        SelectState(
                          onCountryChanged: (country) {
                            address = country;
                          },
                          onStateChanged: (state) {
                            address = '$address/$state';
                          },
                          onCityChanged: (city) {
                            address = '$address/$city';
                          },
                          dropdownColor: MyColors.senderMessageColor,
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
                                      AddJobEvent(
                                          job: Job(
                                              id: 'default',
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
                                              numberOfOrders: 0,
                                              jobQualifications: qualifications,
                                              readedOrders: 0,
                                              sharedAt: Timestamp.now())));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                maximumSize: const Size(200, 60),
                                foregroundColor: Colors.white,
                                backgroundColor: MyColors.mainColor),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Job',
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

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    salary.dispose();
    description.dispose();
    category.dispose();
    subCategory.dispose();
    qualifications = [];
    address = '';
  }
}



 



  // final String address;




