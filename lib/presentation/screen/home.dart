import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/assets/assets_manager.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_screen.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    const TutorListScreen(),
    // const ScheduleScreen(),
    // const CoursesScreen(),
    // const AccountScreen(),
  ];
  List<String> get screenTitle =>
      ['tutors'.tr(), 'schedule'.tr(), 'courses'.tr(), 'account'.tr()];
  int selectedScreenIndex = 0;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          screenTitle[selectedScreenIndex],
          style: CustomTextStyle.topHeadline,
        ),
        actions: [_displayLanguageIcon(context), const SizedBox(width: 16)],
      ),
      body: screens[selectedScreenIndex],
    );
  }

  Widget _displayLanguageIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 223, 228, 249),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SvgPicture.asset(
          context.locale.languageCode == 'vi'
              ? AssetsManager.vietnameseFlag
              : AssetsManager.englishFlag,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
