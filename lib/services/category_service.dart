import '../models/category.dart';

class CategoryService {
  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Electronics',
      imageUrl: 'https://img.icons8.com/color/100/electronics.png',
    ),
    Category(
      id: '2',
      name: 'Wearables',
      imageUrl: 'https://img.icons8.com/color/100/smartwatch.png',
    ),
    Category(
      id: '3',
      name: 'Home & Kitchen',
      imageUrl: 'https://img.icons8.com/color/100/kitchen-room.png',
    ),
    Category(
      id: '4',
      name: 'Fitness',
      imageUrl: 'https://img.icons8.com/color/100/dumbbell.png',
    ),
    Category(
      id: '5',
      name: 'Fashion',
      imageUrl: 'https://img.icons8.com/color/100/clothes.png',
    ),
    Category(
      id: '6',
      name: 'Beauty & Personal Care',
      imageUrl: 'https://img.icons8.com/color/100/cosmetics.png',
    ),
    Category(
      id: '7',
      name: 'Toys & Games',
      imageUrl: 'https://img.icons8.com/color/100/teddy-bear.png',
    ),
    Category(
      id: '8',
      name: 'Sports & Outdoors',
      imageUrl: 'https://img.icons8.com/color/100/soccer-ball.png',
    ),
    Category(
      id: '9',
      name: 'Books',
      imageUrl: 'https://img.icons8.com/color/100/books.png',
    ),
    Category(
      id: '10',
      name: 'Automotive',
      imageUrl: 'https://img.icons8.com/color/100/car.png',
    ),
    Category(
      id: '11',
      name: 'Grocery',
      imageUrl: 'https://img.icons8.com/color/100/grocery-bag.png',
    ),
    Category(
      id: '12',
      name: 'Pet Supplies',
      imageUrl: 'https://img.icons8.com/color/100/dog.png',
    ),
    Category(
      id: '13',
      name: 'Office Supplies',
      imageUrl: 'https://img.icons8.com/color/100/office.png',
    ),
    Category(
      id: '14',
      name: 'Baby & Kids',
      imageUrl: 'https://img.icons8.com/color/100/baby-bottle.png',
    ),
    Category(
      id: '15',
      name: 'Jewelry',
      imageUrl: 'https://img.icons8.com/color/100/diamond.png',
    ),
    Category(
      id: '16',
      name: 'Health & Wellness',
      imageUrl: 'https://img.icons8.com/color/100/heart-health.png',
    ),
    Category(
      id: '17',
      name: 'Shoes',
      imageUrl: 'https://img.icons8.com/color/100/shoes.png',
    ),
    Category(
      id: '18',
      name: 'Music & Instruments',
      imageUrl: 'https://img.icons8.com/color/100/guitar.png',
    ),
    Category(
      id: '19',
      name: 'Garden & Outdoor',
      imageUrl: 'https://img.icons8.com/color/100/garden.png',
    ),
    Category(
      id: '20',
      name: 'Art & Craft',
      imageUrl: 'https://img.icons8.com/color/100/paint-palette.png',
    ),
  ];

  Future<List<Category>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _categories;
  }
}
