import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri)) {
    debugPrint('Could not launch $url');
  }
}


Future<void> sendEmail({
  required String to,
  String subject = '',
  String body = '',
}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: to,
    query: _encodeQueryParameters({'subject': subject, 'body': body}),
  );
  final launched = await launchUrl(uri);
  if (!launched) {
    debugPrint('Could not launch mail client');
  }
}

String _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}