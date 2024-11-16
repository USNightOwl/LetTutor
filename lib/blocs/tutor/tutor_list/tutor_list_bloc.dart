import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;
  // final UserRepository userRepository;
  final tutorPerPage = 12;
  final page = 1;
  String? tutorName;
  bool isReset = false;
  String selectedNationality = '';

  TutorListBloc({
    required this.tutorRepository,
  }) : super(TutorListInitial()) {
    on<TutorListRequested>(_onTutorListRequested);
  }

  FutureOr<void> _onTutorListRequested(
      TutorListRequested event, Emitter<TutorListState> emit) async {
    final currentState = state;

    emit(TutorListLoading());
    try {
      // Initialize with no filters
      Map<String, dynamic> filters = {};
      if (currentState is TutorListSuccess) {
        filters = Map<String, dynamic>.from(currentState.filters);
      }

      final filteredTutors = await tutorRepository.searchTutor(
          filters, event.page, tutorPerPage, tutorName);

      int totalPage = (filteredTutors.count / tutorPerPage).ceil();

      // List<LearnTopic> learnTopics = await tutorRepository.getLearnTopic();
      // List<TestPreparation> testPreparations =
      //     await tutorRepository.getTestPreparation();

      // List<BookedSchedule> bookedSchedules =
      //     await scheduleRepository.getBookedSchedule();

      // Get the current timestamp
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

      // int totalCall = await userRepository.getTotalCall();

      emit(TutorListSuccess(
          filteredTutors.rows,
          filters,
          // learnTopics,
          // testPreparations,
          isReset,
          selectedNationality,
          // upcomingSchedule,
          // totalCall,
          totalPage,
          event.page));
    } catch (e) {
      log('error from tutor list bloc: $e');
      emit(TutorListFailure(e.toString()));
    }
  }
}
