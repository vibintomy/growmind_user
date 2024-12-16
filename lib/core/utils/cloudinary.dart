import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Cloudinary {
  final String cloudName = 'dj01ka9ga';
  final String apiKey = '642889674424333';
  final String apiSecret = 'EB9XFjTTm5kNygU6hxJMls79Tj8';

  Future<String> uploadImage(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'document_preset'
      ..fields['api_key'] = apiKey
      ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      return data['secure_url'];
    } else {
      throw Exception('Failed to upload image to cloudinary ');
    }
  }
}
