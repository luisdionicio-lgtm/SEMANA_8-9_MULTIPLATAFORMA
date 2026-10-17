import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/app_store.dart';

void main() {
  test('Precios en céntimos: coma, precisión y entradas inválidas', () {
    expect(parseCents('80,50'), 8050);
    expect(parseCents('2500'), 250000);
    for (final input in ['0', '-2', 'NaN', '1.234', 'Infinity', 'abc']) {
      expect(parseCents(input), isNull);
    }
  });
  test('Producto y perfil sobreviven a recargar el almacén', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final store = AppStore(prefs);
    await store.add(
      const Product(
        id: 'test',
        name: 'Audio Test',
        description: 'Descripción',
        cents: 12345,
        category: 'Audio',
        image: 'headphones.jpg',
      ),
    );
    await store.updateProfile('Ana Test', 'ana@example.com', '999 111 222');
    final restored = AppStore(prefs);
    expect(restored.products.last.price, 'S/ 123.45');
    expect(restored.name, 'Ana Test');
    expect(prefs.getKeys().any((key) => key.contains('password')), isFalse);
  });
  test('Datos corruptos recuperan catálogo de ejemplo con aviso', () async {
    SharedPreferences.setMockInitialValues({'orbita.products.v1': 'malformed'});
    final store = AppStore(await SharedPreferences.getInstance());
    expect(store.storageWarning, isTrue);
    expect(store.products.length, 4);
  });
  testWidgets('Login, registro, búsqueda, perfil y logout', (tester) async {
    tester.view.physicalSize = const Size(1440, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});
    final store = AppStore(await SharedPreferences.getInstance());
    await tester.pumpWidget(MyApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(find.text('Completa este campo.'), findsOneWidget);
    await tester.ensureVisible(find.text('Completar datos de prueba'));
    await tester.tap(find.text('Completar datos de prueba'));
    await tester.ensureVisible(find.text('Ingresar'));
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'Login / menú');
    expect(find.text('Tu próxima órbita.'), findsOneWidget);
    await tester.tap(find.byTooltip('Siguiente colección'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 4'), findsOneWidget);
    await tester.tap(find.text('Explorar audio'));
    await tester.pumpAndSettle();
    expect(find.text('No encontramos productos'), findsOneWidget);

    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Registrar productos').first);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('product-name')),
      'Auriculares Test',
    );
    await tester.enterText(
      find.byKey(const Key('product-description')),
      'Producto de prueba',
    );
    await tester.enterText(find.byKey(const Key('product-price')), '199,90');
    await tester.ensureVisible(find.text('Guardar producto'));
    await tester.tap(find.text('Guardar producto'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'Registro / lista');
    expect(store.products.last.cents, 19990);
    await tester.enterText(
      find.byKey(const Key('product-search')),
      'sin coincidencia',
    );
    await tester.pumpAndSettle();
    expect(find.text('No encontramos productos'), findsOneWidget);
    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tester.tap(
      find
          .descendant(of: find.byType(Drawer), matching: find.text('Perfil'))
          .first,
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Editar perfil'));
    await tester.tap(find.text('Editar perfil'));
    await tester.enterText(find.byType(TextFormField).first, 'Ana Prueba');
    await tester.ensureVisible(find.text('Guardar cambios'));
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'Perfil');
    expect(store.name, 'Ana Prueba');
    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('Ingresar'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
