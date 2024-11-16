import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_chip.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';

class TutorInformationCard extends StatelessWidget {
  final Tutor tutor;
  final List<LearnTopic> listLearnTopics;
  final List<TestPreparation> listTestPreparations;

  const TutorInformationCard({
    super.key,
    required this.tutor,
    required this.listLearnTopics,
    required this.listTestPreparations,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            _tutorInformation(tutor),
          ],
        ),
      ),
    );
  }

  Padding _tutorInformation(Tutor tutor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TutorAvatar(imageUrl: tutor.avatar!, tutorName: tutor.name!),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    tutor.name ?? '',
                    style: CustomTextStyle.headlineLarge,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // flag
                      Flag(flagCode: tutor.country ?? ''),
                      const SizedBox(width: 10),
                      Text(
                        _getNameCountry(tutor.country ?? ''),
                        style: CustomTextStyle.bodyRegular,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // row
                  StarRating(rating: tutor.rating ?? 0, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'specialities'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          buildSpecialtiesChips(tutor.specialties),
          const SizedBox(
            height: 10,
          ),
          Text(tutor.bio ?? ''),
          const SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }

  Widget buildSpecialtiesChips(String? specialties) {
    if (specialties == null || specialties.isEmpty) {
      return Container();
    }

    List<String> specialtiesListCode = specialties.split(',');
    List<String> specialtiesList = getTutorSpecialties(specialtiesListCode);

    return Wrap(
      spacing: 5,
      runSpacing: 2,
      children: specialtiesList.map((specialty) {
        return CustomChip(label: specialty.trim());
      }).toList(),
    );
  }

  List<String> getTutorSpecialties(List<String> specialties) {
    List<String> specialtiesNames = [];

    for (String specialty in specialties) {
      for (LearnTopic topic in listLearnTopics) {
        if (topic.key == specialty) {
          specialtiesNames.add(topic.name ?? '');
          break;
        }
      }

      for (TestPreparation test in listTestPreparations) {
        if (test.key == specialty) {
          specialtiesNames.add(test.name ?? '');
          break;
        }
      }
    }

    return specialtiesNames;
  }
}

String _getNameCountry(String codeOrName) {
  final country = AppConfig.countries.firstWhere(
      (country) => country.code == codeOrName || country.name == codeOrName,
      orElse: () => Country(name: '', code: ''));
  return country.name;
}
