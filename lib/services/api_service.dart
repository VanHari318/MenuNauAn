import '../models/recipe.dart';

class ApiService {
  // Biến này dùng để giả lập lỗi mạng khi cần test tính năng Retry
  static bool simulateError = false;

  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Giả lập thời gian tải để hiển thị Loading UI rõ ràng
      await Future.delayed(const Duration(seconds: 2));

      if (simulateError) {
        throw Exception('Mất kết nối mạng hoặc server không phản hồi! Vui lòng kiểm tra và thử lại.');
      }

      // Dữ liệu tĩnh - Bạn có thể tự sửa tên, giá, mô tả theo ý muốn
      return _staticRecipes;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}

// ============================================================
//  DANH SÁCH MÓN ĂN - Tự sửa tên, ảnh, mô tả, giá bên dưới
// ============================================================
final List<Recipe> _staticRecipes = [
  Recipe(
    id: 1,
    name: 'Phở Bò',
    image: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=600',
    instructions: [
      'Hầm xương bò với gừng, hành tây nướng trong 4-6 tiếng.',
      'Cho thêm quế, hoa hồi, thảo quả vào nồi nước dùng.',
      'Trụng bánh phở qua nước sôi, cho vào tô.',
      'Xếp thịt bò tái, chín lên trên, chan nước dùng nóng.',
      'Ăn kèm giá, húng quế, chanh, ớt.',
    ],
    price: 55000,
  ),
  Recipe(
    id: 2,
    name: 'Bún Bò Huế',
    image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600',
    instructions: [
      'Hầm xương bò và chân giò heo 2-3 tiếng.',
      'Cho mắm ruốc Huế, sả đập dập, ớt vào nước dùng.',
      'Nêm nếm với muối, đường, hạt nêm cho vừa ăn.',
      'Trụng bún, cho vào tô với thịt bò sliced.',
      'Chan nước dùng, thêm huyết heo, chả cua nếu thích.',
    ],
    price: 50000,
  ),
  Recipe(
    id: 3,
    name: 'Bánh Mì Thịt',
    image: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
    instructions: [
      'Nướng bánh mì giòn trong lò 180°C khoảng 5 phút.',
      'Phết pa-tê, bơ vào mặt trong bánh mì.',
      'Xếp thịt nguội (chả lụa, thịt xá xíu) vào bánh.',
      'Thêm dưa leo thái lát, đồ chua cà rốt củ cải.',
      'Rắc hành lá, tương ớt, nước tương, tiêu và ngò rí.',
    ],
    price: 30000,
  ),
  Recipe(
    id: 4,
    name: 'Cơm Tấm Sườn Bì Chả',
    image: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600',
    instructions: [
      'Ướp sườn với sả, tỏi, nước mắm, dầu hào 30 phút.',
      'Nướng sườn trên than hoặc lò ở 200°C cho vàng đều.',
      'Hấp chả trứng (trứng, thịt xay, nấm mèo) trong 30 phút.',
      'Nấu cơm tấm chín dẻo vừa.',
      'Dọn cơm ra đĩa với sườn, bì, chả trứng và đồ chua.',
    ],
    price: 60000,
  ),
  Recipe(
    id: 5,
    name: 'Bún Chả Hà Nội',
    image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600',
    instructions: [
      'Ướp thịt ba chỉ thái lát và viên thịt với nước mắm, mật ong, tỏi.',
      'Nướng thịt trên than hoa cho đến khi vàng thơm.',
      'Pha nước chấm: nước mắm, đường, chanh, tỏi, ớt.',
      'Cho thịt nướng vào bát nước chấm.',
      'Ăn với bún tươi, rau sống (kinh giới, tía tô, xà lách).',
    ],
    price: 65000,
  ),
  Recipe(
    id: 6,
    name: 'Gỏi Cuốn Tôm Thịt',
    image: 'https://images.unsplash.com/photo-1562802378-063ec186a863?w=600',
    instructions: [
      'Luộc tôm và thịt heo luộc chín, thái mỏng.',
      'Ngâm bánh tráng vào nước ấm cho mềm.',
      'Đặt bánh tráng lên thớt, xếp rau, bún, tôm, thịt.',
      'Cuộn chặt tay, gấp 2 đầu vào.',
      'Ăn kèm nước chấm tương đậu phộng pha hoisin sauce.',
    ],
    price: 45000,
  ),
  Recipe(
    id: 7,
    name: 'Canh Chua Cá Lóc',
    image: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=600',
    instructions: [
      'Phi tỏi với dầu ăn cho thơm.',
      'Cho cà chua, dứa (thơm) cắt miếng vào xào.',
      'Đổ nước vào, nêm me, đường, muối, nước mắm.',
      'Cho cá lóc vào nấu chín khoảng 5-7 phút.',
      'Thêm giá, bạc hà, ngò gai, ớt trước khi tắt bếp.',
    ],
    price: 70000,
  ),
  Recipe(
    id: 8,
    name: 'Bánh Xèo Miền Nam',
    image: 'https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?w=600',
    instructions: [
      'Pha bột bánh xèo với bột gạo, nghệ, nước cốt dừa, muối.',
      'Tôm và thịt heo ướp chút muối tiêu.',
      'Đun chảo nóng với ít dầu, đổ bột vào tráng mỏng đều.',
      'Cho nhân (tôm, thịt, giá, hành lá) lên một nửa bánh.',
      'Gập bánh lại, ăn kèm rau sống và nước chấm chua ngọt.',
    ],
    price: 35000,
  ),
  Recipe(
    id: 9,
    name: 'Chè Ba Màu',
    image: 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=600',
    instructions: [
      'Nấu đậu xanh và đậu đỏ chín nhừ, nêm với đường.',
      'Nấu thạch pandan (lá dứa) xanh, để nguội cắt miếng.',
      'Pha nước cốt dừa với muối và đường.',
      'Xếp lần lượt: đậu đỏ, đậu xanh, thạch vào ly.',
      'Chan nước cốt dừa lên trên, thêm đá bào cho mát.',
    ],
    price: 25000,
  ),
  Recipe(
    id: 10,
    name: 'Hủ Tiếu Nam Vang',
    image: 'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=600',
    instructions: [
      'Hầm xương heo với củ cải, hành tây ít nhất 2 tiếng.',
      'Nêm nước dùng với nước mắm, đường phèn, muối.',
      'Trụng hủ tiếu gạo qua nước sôi cho mềm.',
      'Xếp vào tô: tôm luộc, thịt heo luộc, gan heo.',
      'Chan nước dùng nóng, thêm hành lá và ngò rí.',
    ],
    price: 55000,
  ),
];
