import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔴 CHANGE THIS LATER TO RENDER URL
  static const String baseUrl = 'http://127.0.0.1:8000';

  // ---------------- LOGIN ----------------
  static Future<Map<String, dynamic>> login(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    return jsonDecode(response.body);
  }

  // ---------------- GET PROJECTS ----------------
  static Future<List<dynamic>> getProjects() async {
    final response =
        await http.get(Uri.parse('$baseUrl/projects'));

    return jsonDecode(response.body);
  }
}
