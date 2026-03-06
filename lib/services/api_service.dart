import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  // URL API công khai để lấy công thức nấu ăn
  static const String apiUrl = 'https://dummyjson.com/recipes?limit=15';

  // Biến này dùng để giả lập lỗi mạng khi cần test tính năng Retry
  static bool simulateError = false;

  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Giả lập thời gian chờ để hiển thị Loading UI rõ ràng
      await Future.delayed(const Duration(seconds: 2));

      if (simulateError) {
        throw Exception(
            'Mất kết nối mạng hoặc server không phản hồi! Vui lòng kiểm tra và thử lại.');
      }

      // Gọi API thực từ dummyjson.com
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> recipesJson = data['recipes'];
        return recipesJson.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception(
            'Không thể tải dữ liệu từ máy chủ (Lỗi HTTP ${response.statusCode}).');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
