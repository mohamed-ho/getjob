//responsive
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getjob/core/constants/list_of_job_types.dart';
import 'package:getjob/config/routes/routes.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';
import 'package:getjob/features/splash/widget/custum_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../core/constants/colors.dart';

filterWidget(context) {
  double maxSalary = 1000000;
  RangeValues currentRangeValues = RangeValues(0, maxSalary);
  String category = '';
  String subCategory = '';
  String address = '';
  String type = '';

  List<String> subCategories = [];
  showModalBottomSheet(
      backgroundColor: MyColors.backgroundcolor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.w), topRight: Radius.circular(40.w))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SizedBox(
            height: 700.h,
            child: ListView(
              children: [
                Align(
                    child: Text(
                  'Set filters',
                  style: TextStyle(
                    fontSize: 22.spMax,
                  ),
                )),
                Text(
                  'Category',
                  style: TextStyle(
                      fontSize: 18.spMax, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<JobBloc, JobState>(
                  builder: (context, state) {
                    if (state is JobGetedState) {
                      final categories =
                          List<String>.from(state.jobs.map((e) => e.category));
                      subCategories = List<String>.from(
                          state.jobs.map((e) => e.subCategory));
                      return SearchField(
                        onSuggestionTap: (value) {
                          category = value.item.toString();
                        },
                        suggestions: categories
                            .map((e) => SearchFieldListItem(e, item: e))
                            .toList(),
                        maxSuggestionsInViewPort: 6,
                        searchStyle: const TextStyle(fontSize: 18),
                        suggestionStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        suggestionsDecoration: SuggestionDecoration(
                            color: MyColors.mainColor,
                            borderRadius: BorderRadius.circular(16)),
                        searchInputDecoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Serach here....',
                            hintStyle: const TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20))),
                      );
                    } else {
                      return TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Serach here....',
                            hintStyle: const TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20))),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Sub Category',
                  style: TextStyle(
                      fontSize: 18.spMax, fontWeight: FontWeight.bold),
                ),
                subCategories.isNotEmpty
                    ? SearchField(
                        onSuggestionTap: (value) {
                          subCategory = value.item.toString();
                        },
                        suggestions: subCategories
                            .map((e) => SearchFieldListItem(e, item: e))
                            .toList(),
                        maxSuggestionsInViewPort: 6,
                        searchStyle: TextStyle(fontSize: 18.spMax),
                        suggestionStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.spMax,
                            color: Colors.white),
                        suggestionsDecoration: SuggestionDecoration(
                            color: MyColors.mainColor,
                            borderRadius: BorderRadius.circular(16.w)),
                        searchInputDecoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Serach here....',
                            hintStyle: TextStyle(fontSize: 16.spMax),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.w),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w))),
                      )
                    : TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Serach here....',
                            hintStyle: TextStyle(fontSize: 16.spMax),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.w),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w))),
                      ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Salary Range',
                  style: TextStyle(
                      fontSize: 18.spMax, fontWeight: FontWeight.bold),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return RangeSlider(
                    activeColor: MyColors.mainColor,
                    values: currentRangeValues,
                    max: maxSalary,
                    divisions: maxSalary.toInt(),
                    labels: RangeLabels(
                      currentRangeValues.start.round().toString(),
                      currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        currentRangeValues = values;
                      });
                    },
                  );
                }),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Locatin',
                  style: TextStyle(
                      fontSize: 18.spMax, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.w),
                        border: Border.all(color: Colors.grey, width: 2.w)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: SelectState(onCountryChanged: (country) {
                        address = '$country/';
                      }, onStateChanged: (state) {
                        address = '$address$state/';
                      }, onCityChanged: (city) {
                        address = address + city;
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Job Tyype',
                  style: TextStyle(
                      fontSize: 18.spMax, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.spMax,
                  ),
                  child: SearchField(
                    onSuggestionTap: (value) {
                      type = value.item.toString();
                    },
                    suggestions: listOFJobTypes
                        .map((e) => SearchFieldListItem(e, item: e))
                        .toList(),
                    maxSuggestionsInViewPort: 6,
                    searchStyle: TextStyle(fontSize: 18.spMax),
                    suggestionStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.spMax,
                        color: Colors.white),
                    suggestionsDecoration: SuggestionDecoration(
                        color: MyColors.mainColor,
                        borderRadius: BorderRadius.circular(16.w)),
                    searchInputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Serach here....',
                        hintStyle: TextStyle(fontSize: 16.w),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.w),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.w))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                  child: CustomElevatedIconButton(
                      onpress: () async {
                        Navigator.pushReplacementNamed(
                            context, Routes.searchScreenWithMoreItem,
                            arguments: FilterJob(
                                category: category != '' ? category : null,
                                subCategory:
                                    subCategory != '' ? subCategory : null,
                                location: address != '' ? address : null,
                                salary: [
                                  currentRangeValues.start,
                                  currentRangeValues.end
                                ],
                                type: type != '' ? type : null));
                      },
                      buttonText: 'Apply Filters'),
                )
              ],
            ),
          ),
        );
      });
}
