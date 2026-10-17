# Órbita · Laboratorio 08 / 09

Aplicación Flutter web + Dart para una tienda tecnológica: login, menú, registro de productos, listado y perfil editable. En PC se presenta un teléfono estilizado de hasta 376 × 812 px sobre un fondo tecnológico.

Repositorio: https://github.com/luisdionicio-lgtm/SEMANA_8-9_MULTIPLATAFORMA

## Ejecutar desde Visual Studio Code

Abrir esta carpeta y ejecutar en su terminal:

```powershell
& "D:/flutter/flutter/bin/flutter.bat" pub get
& "D:/flutter/flutter/bin/flutter.bat" run -d chrome --web-port 8082
```

Abrir http://localhost:8082. Si Flutter está en PATH, basta con `flutter run -d chrome --web-port 8082`.

También se incluye la tarea **Órbita: ejecutar Flutter Web**: `Ctrl + Shift + B` abre la terminal integrada y ejecuta el proyecto. `.vscode/settings.json` apunta al SDK instalado en esta PC; ajustar esa ruta si se clona en otro equipo. La configuración de depuración con F5 usa Chrome en el puerto 8081.

Acceso de demostración: **demo@orbita.pe** / **Demo2026!**. El botón «Completar datos de prueba» completa el formulario. Para detener Flutter, `Ctrl + C` en su terminal.

## Pantallas y funciones

- Login con validación y contraseña visible/oculta.
- Menú de cuatro bloques: registrar, listar, perfil y logout. Valor total calculado a partir del catálogo real y dos carruseles interactivos.
- Registro de nombre, descripción, categoría y precio en soles. Carga opcional de fotografía JPG/PNG de hasta 2 MB; se guarda localmente con el producto.
- Listado en filas compactas, búsqueda por nombre, descripción o código, filtro de categoría, orden de precios y detalle.
- Perfil con fotografía referencial, nombre, correo y teléfono editables.

Datos iniciales: Laptop S/ 2500, Mouse S/ 80, Teclado S/ 120 y Monitor S/ 900. Los datos se mantienen al recargar mediante SharedPreferences. Cambiar de pantalla reinicia el desplazamiento sin perder productos ni perfil guardados.

## Diseño y estructura

Estilo basado en las últimas referencias proporcionadas: violeta, lima y coral; bordes negros y sombras de bloque. Formularios claros, controles Material, foto de perfil, teléfono delgado y textos breves. Botones con respuesta de presión de 120 ms, carruseles con transición de 250 ms y respeto por movimiento reducido.

```text
lib/
  main.dart                 # Arranque y marco de celular
  models/product.dart       # Productos y precios en céntimos
  services/app_store.dart    # Estado y persistencia local
  theme/app_theme.dart      # Tema global
  widgets/common.dart       # Marca, fotos, paneles y validadores
  widgets/carousels.dart    # Carruseles de colecciones y productos
  screens/                  # Las cinco pantallas del laboratorio
assets/images/              # Fotografías locales, incluida la de perfil
assets/fonts/               # Manrope estática y licencia OFL
.vscode/                    # SDK, depuración y tarea de terminal
test/widget_test.dart       # Pruebas del dominio y flujo completo
```

Se conserva la estructura original Flutter con carpetas android, macos y web. Se aplican tema global, Card, imágenes y FadeInImage de la enseñanza; las ampliaciones están comentadas en código.

## Seguridad y alcance

El login es de demostración y no reemplaza autenticación de servidor. No se guarda contraseña, token ni sesión. Productos, fotografías seleccionadas y perfil ficticio se guardan sin cifrado en este navegador: usar datos de prueba.

`.gitignore` excluye variables de entorno, claves privadas, certificados, credenciales y artefactos de compilación; no cifra archivos. El proyecto no necesita secretos. Para producción hacen falta backend, autenticación, autorización y HTTPS.

## Verificación

```powershell
flutter analyze
flutter test
flutter build web --release --pwa-strategy=none
```

Pruebas de precios, recuperación de almacenamiento corrupto, persistencia y flujo de login, carrusel, filtro, registro, búsqueda, edición de perfil y logout.

Fuentes y licencias: [docs/FUENTES.md](docs/FUENTES.md). Documentación: [formularios Flutter](https://docs.flutter.dev/cookbook/forms/validation), [FadeInImage](https://docs.flutter.dev/cookbook/images/fading-in-images), [image_picker](https://pub.dev/packages/image_picker), [clases Dart](https://dart.dev/language/classes).
