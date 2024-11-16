import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/network/apis/tutor_api_client.dart';

class TutorRepository {
  final tutorApiClient = TutorApiClient();

  // get learn topic
  Future<List<LearnTopic>> getLearnTopic() async {
    List<LearnTopic> learnTopics = await tutorApiClient.getLearnTopic();
    return learnTopics;
  }

  // search tutor
  Future<TutorSearchResult> searchTutor(
      Map<String, dynamic> filters, int page, int perPage, String? name) async {
    TutorSearchResult result =
        await tutorApiClient.searchTutor(filters, page, perPage, name);
    return result;
  }

  // get test preparation
  Future<List<TestPreparation>> getTestPreparation() async {
    List<TestPreparation> testPreparations =
        await tutorApiClient.getTestPreparation();
    return testPreparations;
  }
}
