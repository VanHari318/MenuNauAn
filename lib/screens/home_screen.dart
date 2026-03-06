import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../widgets/recipe_card.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _futureRecipes;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _futureRecipes = _apiService.fetchRecipes();
    });
  }

  /// Nút bật/tắt giả lập lỗi mạng để test yêu cầu (Trạng thái Lỗi & Retry)
  void _toggleErrorSimulation() {
    setState(() {
      ApiService.simulateError = !ApiService.simulateError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Giả lập lỗi mạng: ${ApiService.simulateError ? "BẬT" : "TẮT"}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: ApiService.simulateError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Định danh bắt buộc: TH3 - [Họ tên Sinh viên] - [Mã SV]
        title: const Text('TH3 - Nguyễn Văn Hải - 2351060441'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(ApiService.simulateError ? Icons.wifi_off : Icons.wifi),
            tooltip: 'Bật/Tắt giả lập lỗi',
            onPressed: _toggleErrorSimulation,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
            onPressed: () async {
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.signOut();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.orange[100],
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ?? 
                    'https://ui-avatars.com/api/?name=${FirebaseAuth.instance.currentUser?.displayName ?? "User"}'
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName ?? 'Khách',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _futureRecipes,
        builder: (context, snapshot) {
          // 1. Trạng thái Đang tải (Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.orange),
                  SizedBox(height: 16),
                  Text(
                    'Đang tải thực đơn...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          // 2. Trạng thái Lỗi (Error UI & Retry)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _fetchData, // Nút Thử lại gọi _fetchData()
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Thử lại (Retry)', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Trạng thái Thành công (Success)
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final recipes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: recipes[index]);
              },
            );
          }

          // Trường hợp API trả về rỗng
          return const Center(
            child: Text(
              'Không có dữ liệu món ăn.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
