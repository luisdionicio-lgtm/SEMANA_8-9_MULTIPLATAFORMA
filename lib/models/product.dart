class Product {
  final String id, name, description, category, image;
  // Se usan céntimos enteros para evitar errores de redondeo de double.
  final int cents;
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.cents,
    required this.category,
    required this.image,
  });
  String get price => 'S/ ${(cents / 100).toStringAsFixed(2)}';
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'cents': cents,
    'category': category,
    'image': image,
  };
  factory Product.fromJson(Map<String, dynamic> j) {
    if (j['id'] is! String ||
        j['name'] is! String ||
        j['description'] is! String ||
        j['cents'] is! int ||
        (j['cents'] as int) <= 0 ||
        j['category'] is! String ||
        j['image'] is! String) {
      throw const FormatException('Producto inválido');
    }
    return Product(
      id: j['id'],
      name: j['name'],
      description: j['description'],
      cents: j['cents'],
      category: j['category'],
      image: j['image'],
    );
  }
}

const categories = ['Laptops', 'Periféricos', 'Monitores', 'Audio'];
String categoryImage(String category) => switch (category) {
  'Laptops' => 'laptop.jpg',
  'Monitores' => 'monitor.jpg',
  'Audio' => 'headphones.jpg',
  _ => 'keyboard.jpg',
};
const seedProducts = [
  Product(
    id: 'NX-001',
    name: 'Laptop Pro 14',
    description:
        'Potencia para crear. Pantalla de 14 pulgadas, 16 GB de RAM y SSD de 512 GB.',
    cents: 250000,
    category: 'Laptops',
    image: 'laptop.jpg',
  ),
  Product(
    id: 'NX-002',
    name: 'Mouse inalámbrico',
    description:
        'Diseño ergonómico y conexión inalámbrica para tu espacio de trabajo.',
    cents: 8000,
    category: 'Periféricos',
    image: 'mouse.jpg',
  ),
  Product(
    id: 'NX-003',
    name: 'Teclado mecánico',
    description:
        'Formato compacto, respuesta táctil y una experiencia de escritura precisa.',
    cents: 12000,
    category: 'Periféricos',
    image: 'keyboard.jpg',
  ),
  Product(
    id: 'NX-004',
    name: 'Monitor Studio 27',
    description:
        'Pantalla de 27 pulgadas para trabajar con más espacio y claridad.',
    cents: 90000,
    category: 'Monitores',
    image: 'monitor.jpg',
  ),
];

int? parseCents(String value) {
  final normalized = value.trim().replaceAll(',', '.');
  if (!RegExp(r'^\d{1,7}(\.\d{1,2})?$').hasMatch(normalized)) return null;
  final parts = normalized.split('.');
  final result =
      int.parse(parts[0]) * 100 +
      (parts.length == 2 ? int.parse(parts[1].padRight(2, '0')) : 0);
  return result > 0 ? result : null;
}
