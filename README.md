# Órbita · Laboratorio 08 / 09

Aplicación **Flutter web + Dart, siempre en formato celular (máximo 430 px)** para una tienda de tecnología. Implementa las cinco pantallas de la referencia: login, menú, registrar productos, listar productos y perfil editable.

Repositorio: https://github.com/luisdionicio-lgtm/SEMANA_8-9_MULTIPLATAFORMA

## Ejecutar

```powershell
flutter pub get
flutter run -d chrome --web-port 8080
```

Si Flutter no está en PATH en esta PC:

```powershell
& D:/flutter/flutter/bin/flutter.bat run -d chrome --web-port 8080
```

También puede servirse la compilación con cualquier servidor estático:

```powershell
flutter build web --release
python -m http.server 8080 --bind 127.0.0.1 --directory build/web
```

Abrir http://127.0.0.1:8080. Ingreso de prueba: **demo@orbita.pe** / **Demo2026!**. El botón «Completar datos de prueba» prepara el formulario.

## Pantallas para las capturas

1. **Login:** correo, contraseña, visibilidad y validación.
2. **Menú:** accesos a registrar, listar, perfil y cerrar sesión.
3. **Registrar productos:** nombre, descripción, categoría y precio en S/. Vista previa en vivo. «Guardar producto» abre el listado.
4. **Listar productos:** Laptop S/ 2500, Mouse S/ 80, Teclado S/ 120 y Monitor S/ 900; cuadrícula de dos columnas, búsqueda, filtros, orden de precios y detalle al pulsar una tarjeta.
5. **Perfil:** Juan Pérez, juan@email.com y 987 654 321. «Editar perfil» habilita los campos y permite guardar o cancelar.

Para reproducir las capturas iniciales usa una ventana privada o elimina solo las claves `orbita.products.v1` y `orbita.profile.v1` del almacenamiento local del sitio. No se requiere registrar datos personales reales.

## Estructura

Se conserva el proyecto Flutter original y sus carpetas de plataformas.

```text
lib/
  main.dart                    # Arranque y estado del acceso demo
  models/product.dart          # Producto, datos de ejemplo y precios en céntimos
  services/app_store.dart      # Persistencia local y notificación del estado
  theme/app_theme.dart         # Tema global Material 3
  widgets/common.dart          # Marca, imágenes y validadores
  widgets/carousels.dart       # Carruseles de colecciones y productos
  screens/
    login_screen.dart
    workspace_screen.dart      # Menú y composición responsive
    product_form.dart
    product_list.dart
    profile_screen.dart
assets/images/                 # Fotografías locales
assets/fonts/                  # Manrope y licencia OFL
test/widget_test.dart          # Pruebas del dominio y flujo completo
```

## Correspondencia con la enseñanza

- `ThemeData`: tema global para reducir duplicación.
- `Card`: superficies consistentes para formularios, perfil y catálogo.
- `ImageProvider` / `AssetImage`: imágenes incluidas en el bundle.
- `FadeInImage`: placeholder en memoria y aparición gradual, respetando la preferencia de movimiento reducido.
- `ListView.separated`: listado construido a partir de objetos `Product`.
- `Form` / `TextFormField`: validación y controladores que se liberan con `dispose`.

Las ampliaciones están comentadas en código: `ChangeNotifier` y `ListenableBuilder` comparten el estado; `SharedPreferences` conserva productos/perfil; `LayoutBuilder` mantiene un viewport celular en PC y móvil; céntimos enteros evitan errores monetarios; manejo de errores de almacenamiento evita anunciar guardados fallidos.

## Seguridad y alcance

Este es un laboratorio **sin backend**. El login es una puerta de demostración, no autenticación de producción: las credenciales públicas de prueba se incluyen intencionalmente y no protegen los datos. No se guardan contraseña, token ni sesión. Al recargar se vuelve al login. Productos y perfil ficticio se guardan sin cifrado en el almacenamiento del navegador; otras personas con acceso a ese navegador pueden leerlos.

`.gitignore` **no cifra**: excluye `.env`, claves privadas, certificados, keystores, credenciales y artefactos de compilación. El proyecto no requiere secretos y no incluye claves de servicios. Para producción se necesita autenticación del servidor, autorización por usuario, HTTPS y almacenamiento protegido. Nunca colocar secretos en Dart web: el bundle es público.

## Verificación

```powershell
flutter analyze
flutter test
flutter build web --release
```

Pruebas: validación de importes, recuperación ante datos corruptos, persistencia, login, registro, búsqueda vacía, edición de perfil y logout.

Fuentes y licencias de imágenes: [docs/FUENTES.md](docs/FUENTES.md).
Documentación oficial utilizada: [formularios](https://docs.flutter.dev/cookbook/forms/validation), [imágenes progresivas](https://docs.flutter.dev/cookbook/images/fading-in-images), [navegación](https://docs.flutter.dev/ui/navigation), [clases Dart](https://dart.dev/language/classes).

## Diseño móvil en navegador

En PC se presenta un teléfono funcional centrado sobre un fondo fotográfico de escritorio tecnológico. La interfaz usa azul tinta, lavanda y tipografía Manrope; el catálogo tiene dos columnas y navegación inferior fija. Los botones reaccionan a la presión durante120ms y respetan movimiento reducido, siguiendo la skill local emil-design-eng y https://github.com/emilkowalski/skills.

El inicio incluye dos carruseles: colecciones y productos en tu radar. Ambos admiten gestos táctiles y arrastre con mouse; las colecciones tienen flechas y selección de página. Explorar una colección aplica el filtro real del catálogo.
