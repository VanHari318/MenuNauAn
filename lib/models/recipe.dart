class Recipe {
  final int id;
  final String name;
  final String image;
  final List<String> instructions;
  final int price; 

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.price,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Tạo giá tiền giả lập dựa trên lượng calories để minh họa
    final int calories = (json['caloriesPerServing'] ?? 300) as int;
    final int generatedPrice = calories * 150; // VD: 300 * 150 = 45,000 VNĐ

    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      instructions: List<String>.from(json['instructions'] ?? []),
      price: generatedPrice,
    );
  }
}
