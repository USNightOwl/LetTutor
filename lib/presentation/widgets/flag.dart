import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/configs/app_config.dart';

class Flag extends StatelessWidget {
  final String flagCode;

  const Flag({super.key, required this.flagCode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getCheckedFlagUrl(flagCode),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Icon(Icons.flag);
        }
        if (snapshot.hasData) {
          return SvgPicture.network(
            snapshot.data!,
            width: 20,
            height: 20,
            placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator(),
            ),
          );
        }
        return const Icon(Icons.error);
      },
    );
  }
}

Future<String?> checkUrl(String url) async {
  try {
    final response = await Dio().head(
      url,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status != null ? status < 500 : false;
        },
      ),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return url;
  } catch (e) {
    return null;
  }
}

Future<String?> getCheckedFlagUrl(String flagCode) async {
  String url = await AppConfig.getFlagUrl(flagCode);
  // log('url: $url');
  return checkUrl(url);
}
