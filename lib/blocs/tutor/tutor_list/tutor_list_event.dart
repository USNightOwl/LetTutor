import 'package:equatable/equatable.dart';

abstract class TutorListEvent extends Equatable {}

class TutorListRequested extends TutorListEvent {
  final int page;

  TutorListRequested({required this.page});

  @override
  List<Object> get props => [page];
}
