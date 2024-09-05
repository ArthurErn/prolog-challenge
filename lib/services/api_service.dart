import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String apiToken = dotenv.env['API_TOKEN'] ?? '';

  ApiService({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<T>> getRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    String? rootKey,
  }) async {
    try {
      final url = '$baseUrl/$endpoint';
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          'x-prolog-api-token': apiToken,
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        final data = rootKey != null
            ? (decodedData[rootKey] as List<dynamic>)
            : (decodedData is List<dynamic> ? decodedData : [decodedData]);

        return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
