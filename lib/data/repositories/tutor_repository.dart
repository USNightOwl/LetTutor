import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/network/apis/tutor_api_client.dart';

class TutorRepository {
  final tutorApiClient = TutorApiClient();

  // search tutor
  Future<TutorSearchResult> searchTutor(
      Map<String, dynamic> filters, int page, int perPage, String? name) async {
    TutorSearchResult result =
        await tutorApiClient.searchTutor(filters, page, perPage, name);
    return result;
  }
}
