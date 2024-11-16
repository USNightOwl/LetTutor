import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/widgets/tutor_information_card.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:number_paginator/number_paginator.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  bool isShowFilter = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const UpcomingLesson(),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildHeaderRow(context),
                    const SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: isShowFilter,
                      child: _inputFilter(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<TutorListBloc, TutorListState>(
                      builder: (context, state) {
                        if (state is TutorListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TutorListSuccess) {
                          if (state.tutors.isEmpty) {
                            return _noTutorsFoundMessage();
                          }
                          return _listTutorInformationCard(
                              state.tutors,
                              state.learnTopics,
                              state.testPreparations,
                              state.totalPage,
                              state.page);
                        } else if (state is TutorListFailure) {
                          return Text('error_message'.tr(args: [state.error]),
                              style: CustomTextStyle.bodyRegular
                                  .copyWith(color: Colors.redAccent));
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _listTutorInformationCard(
      List<Tutor> tutors,
      List<LearnTopic> listLearnTopics,
      List<TestPreparation> listTestPreparations,
      int totalPage,
      int page) {
    // Sort tutors by favorite status, favorite tutor status and rating
    tutors.sort((a, b) {
      if (b.isFavorite != a.isFavorite) {
        return (b.isFavorite ?? false) ? 1 : -1;
      }
      if (b.isFavoriteTutor != a.isFavoriteTutor) {
        return (b.isFavoriteTutor ?? false) ? 1 : -1;
      }
      return (b.rating ?? 0).compareTo(a.rating ?? 0);
    });

    return SizedBox(
      child: ListView.builder(
        // Tự động điều chỉnh chiều cao của ListView sao cho vừa đủ để hiển thị tất cả các mục con bên trong.
        shrinkWrap: true,
        // Tắt chức năng cuộn của ListView.
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tutors.length + 1,
        itemBuilder: (context, index) {
          if (index < tutors.length) {
            return Column(
              children: [
                TutorInformationCard(
                  tutor: tutors[index],
                  listLearnTopics: listLearnTopics,
                  listTestPreparations: listTestPreparations,
                ),
                const SizedBox(height: 16),
              ],
            );
          }
          return NumberPaginator(
            numberPages: totalPage,
            initialPage: page - 1,
            onPageChange: (index) {
              context
                  .read<TutorListBloc>()
                  .add(TutorListRequested(page: index + 1));
            },
          );
        },
      ),
    );
  }

  Center _noTutorsFoundMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_outlined, size: 64),
          Text('no_tutor_found'.tr(),
              style: CustomTextStyle.bodyRegular
                  .copyWith(color: Colors.grey[400])),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Row _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('recommended_tutors:'.tr(), style: CustomTextStyle.headlineLarge),
        IconButton(
          onPressed: () {
            setState(() {
              isShowFilter = !isShowFilter;
            });
          },
          icon: const Icon(
            Icons.filter_list_outlined,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _searchByName() {
    TextEditingController controller = TextEditingController();
    return BlocListener<TutorListBloc, TutorListState>(
      listener: (context, state) {},
      child: TextField(
        controller: controller,
        onChanged: (value) {
          //context.read<TutorListBloc>().add(FilterTutorsByName(value));
        },
        decoration: InputDecoration(
          hintText: 'enter_tutor_name'.tr(),
          prefixIcon: const Icon(Icons.type_specimen_outlined),
          hintStyle: const TextStyle(
            color: Color(0xFFB0B0B0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }

  // Widget _selectNationality() {
  //   return BlocBuilder<TutorListBloc, TutorListState>(builder: (context, state){},);
  // }

  Column _inputFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'find_a_tutor'.tr(),
            style: CustomTextStyle.headlineMedium,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _searchByName(),
            ),
            const SizedBox(width: 10),
            // Expanded(
            //   flex: 2,
            //   child: _selectNationality(),
            // ),
          ],
        ),
        const SizedBox(height: 16),
        Text('select_speciality'.tr(), style: CustomTextStyle.headlineMedium),
        const SizedBox(height: 8),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8),
        //   child: _specialitiesChips(),
        // ),
      ],
    );
  }
}
