import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  // Sử dụng API dummyjson.com để lấy danh sách công thức nấu ăn
  static const String apiUrl = 'https://dummyjson.com/recipes?limit=15';

  // Biến này dùng để giả lập lỗi mạng khi cần test tính năng Retry
  static bool simulateError = false;

  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Giả lập thời gian chờ (delay) để hiển thị Loading UI rõ ràng
      await Future.delayed(const Duration(seconds: 2));

      if (simulateError) {
        throw Exception('Mất kết nối mạng hoặc server không phản hồi! Vui lòng kiểm tra và thử lại.');
      }

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> recipesJson = data['recipes'];
        
        return recipesJson.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Không thể tải dữ liệu từ máy chủ (Lỗi HTTP ${response.statusCode}).');
      }
    } catch (e) {
      // Bắt ngoại lệ try-catch cho mọi lỗi mạng
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
