import 'package:flutter/material.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';

class TutorInformationCard extends StatelessWidget {
  final Tutor tutor;
  const TutorInformationCard({
    super.key,
    required this.tutor,
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
        ],
      ),
    );
  }
}

String _getNameCountry(String codeOrName) {
  final country = AppConfig.countries.firstWhere(
      (country) => country.code == codeOrName || country.name == codeOrName,
      orElse: () => Country(name: '', code: ''));
  return country.name;
}
