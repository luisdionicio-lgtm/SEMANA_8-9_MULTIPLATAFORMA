import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

// Persistencia local solo para datos del laboratorio. Nunca se almacena la clave
// ni una sesión autenticada; una aplicación real requiere backend y HTTPS.
class AppStore extends ChangeNotifier {
  final SharedPreferences preferences;
  List<Product> products = List.of(seedProducts);
  String name = 'Juan Pérez', email = 'juan@email.com', phone = '987 654 321';
  bool storageWarning = false;
  AppStore(this.preferences) {
    try {
      final saved = preferences.getString('orbita.products.v1');
      if (saved != null) {
        products = (jsonDecode(saved) as List)
            .map((j) => Product.fromJson(Map<String, dynamic>.from(j)))
            .toList();
      }
      final profile = preferences.getString('orbita.profile.v1');
      if (profile != null) {
        final p = jsonDecode(profile) as Map;
        name = p['name'] as String;
        email = p['email'] as String;
        phone = p['phone'] as String;
      }
    } catch (_) {
      storageWarning = true;
    }
  }
  Future<void> add(Product product) async {
    final next = [...products, product];
    final saved = await preferences.setString(
      'orbita.products.v1',
      jsonEncode(next.map((p) => p.toJson()).toList()),
    );
    if (!saved) throw StateError('No se pudo guardar en este navegador.');
    products = next;
    notifyListeners();
  }

  Future<void> updateProfile(String n, String e, String p) async {
    final saved = await preferences.setString(
      'orbita.profile.v1',
      jsonEncode({'name': n, 'email': e, 'phone': p}),
    );
    if (!saved) throw StateError('No se pudo guardar el perfil.');
    name = n;
    email = e;
    phone = p;
    notifyListeners();
  }
}
