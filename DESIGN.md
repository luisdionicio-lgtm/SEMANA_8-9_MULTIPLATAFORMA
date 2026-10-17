---
name: Órbita
description: Catálogo móvil oscuro de tecnología en Flutter web.
colors:
  ink: "#F1F4FF"
  forest: "#A8B7FF"
  mint: "#242F4A"
  muted: "#AAB6CF"
  line: "#303B55"
  canvas: "#0D1426"
  surface: "#182238"
  white: "#FFFFFF"
  selection: "#435581"
typography:
  headline-large:
    fontFamily: Manrope
    fontSize: 38px
    fontWeight: 800
    letterSpacing: -1.1px
  headline-medium:
    fontFamily: Manrope
    fontSize: 28px
    fontWeight: 800
    letterSpacing: -0.6px
  title-large:
    fontFamily: Manrope
    fontSize: 21px
    fontWeight: 800
  title-medium:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: 700
  body-large:
    fontFamily: Manrope
    fontSize: 16px
    lineHeight: 1.65
  body-medium:
    fontFamily: Manrope
    fontSize: 13px
    lineHeight: 1.6
  tag:
    fontFamily: Manrope
    fontSize: 11px
    fontWeight: 700
rounded:
  tag: 6px
  control: 10px
  inset: 12px
  card: 16px
  login-photo: 22px
spacing:
  small: 8px
  standard: 16px
  content-mobile: 20px
  form: 28px
  content-desktop: 38px
components:
  button-primary:
    backgroundColor: "{colors.forest}"
    textColor: "{colors.canvas}"
    rounded: "{rounded.control}"
    padding: 16px 24px
  button-outlined:
    textColor: "{colors.forest}"
    rounded: "{rounded.control}"
  input:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.control}"
    padding: 18px 16px
  card:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.card}"
  tag:
    backgroundColor: "{colors.mint}"
    textColor: "{colors.forest}"
    typography: "{typography.tag}"
    rounded: "{rounded.tag}"
    padding: 5px 10px
  navigation-active:
    backgroundColor: "{colors.mint}"
    textColor: "{colors.forest}"
    rounded: "{rounded.control}"
    padding: 3px 13px
---

# Design System: Órbita

## Overview

**Creative North Star: "Catálogo tecnológico nocturno"**

Órbita combina fotografía de tecnología, fondos azul tinta y acentos lavanda en una interfaz siempre de celular. Los carruseles de colecciones y productos, el catálogo en dos columnas y la barra inferior fija organizan la exploración; los formularios mantienen títulos fuertes y texto secundario discreto. En PC, un marco de teléfono se presenta sobre una fotografía de escritorio oscurecida.

**Key Characteristics:**

- Fotografía local de productos y espacios de trabajo.
- Manrope con títulos de peso alto.
- Superficies oscuras, bordes discretos y selección azul desaturada.

## Colors

### Primary

Forest es el nombre heredado del acento lavanda: identifica acciones, precios e iconos. Mint es el nombre heredado del azul desaturado que acompaña etiquetas y selección. Los nombres de código se conservan aunque ya no describen tonos verdes.

### Neutral

Ink sostiene títulos claros; muted corresponde al texto secundario. Canvas es el fondo azul tinta; surface eleva tonalmente campos, tarjetas y navegación inferior; line delimita controles y divisores. Selection resalta texto. El tema es Material 3 oscuro; errores y estados deshabilitados heredan sus valores derivados.

## Typography

Manrope es la familia global, empaquetada en archivos estáticos con pesos 400, 500, 600, 700 y 800. La escala normativa está en el frontmatter; px representa los píxeles lógicos Flutter. Headline-large identifica el acceso, headline-medium los encabezados interiores y title-large las secciones. Body-large usa 16px y cuerpo medio 13px. El logotipo tiene una excepción local de 29px, peso 800 y tracking -1.2px. No se declara fuente variable.

## Layout

La presentación es siempre de celular, incluso en PC. El marco exterior tiene ancho máximo de 430px. Desde 600px del viewport exterior se centra un teléfono con padding de 7px, borde de 1px, radios exterior/interior de 43px/36px y barra de estado simulada de 28px. La altura exterior es el alto disponible menos 40px, limitada a 920px. En móvil ocupa el alto disponible sin marco. MediaQuery interior informa el ancho exterior menos 14px y el alto exterior menos 42px cuando hay marco.

El contenido usa padding de 20px y encabezado de 70px. La NavigationBar inferior mide 72px. El catálogo conserva dos columnas: separación horizontal/vertical de 12px y alto fijo de tarjeta de 260px. Las tarjetas muestran foto de 120px y texto con padding de 13px. Los filtros se distribuyen con Wrap y separaciones de 8px. Los umbrales de escritorio internos siguen presentes en código pero no definen la presentación habitual.

## Elevation & Depth

Las tarjetas tienen elevación cero, fondo surface y borde fino. La jerarquía procede de fondos oscuros escalonados y espacios. Solo el marco exterior del teléfono incorpora sombra negra al 50%, desplazada 20px hacia abajo y desenfoque de 60px. En PC la fotografía de escritorio se cubre con una capa #091020 al 90% de opacidad aproximada. Los overlays Material mantienen el comportamiento del tema oscuro.

## Shapes

Controles y botones comparten esquinas suaves; las tarjetas tienen una curva mayor y las etiquetas una menor. ClipRRect recorta fotografías según su contexto. El avatar mantiene forma circular. El teléfono exterior añade radios propios, independientes de los controles de la aplicación.

## Components

- **ActionButton:** lavanda con texto canvas, peso 700 y altura mínima de 50px. La presión de puntero escala a 0.98 durante 120ms con Cubic(.23,1,.32,1); se libera al soltar o cancelar. Con movimiento reducido mantiene escala 1; el teclado conserva FilledButton sin escala. El delineado usa texto forest y borde line.
- **Campos:** fondo surface, borde line de 1px y foco forest de 2px; etiquetas muted. Los mensajes de validación y errores usan Material 3.
- **Tarjetas:** sin elevación ni margen exterior, borde line y radio card. La tarjeta de producto recorta foto y contenido, muestra categoría de 10px, nombre de 14px/peso 700 hasta dos líneas y precio de 14px/peso 800 en forest; abre un diálogo de detalle al pulsar.
- **Filtros:** ChoiceChip de 12px, sin checkmark, fondo mint y borde forest al seleccionar; borde line en reposo. Tag sigue siendo una etiqueta informativa independiente.
- **Navegación:** NavigationBar fija con cuatro destinos: Menú, Registrar, Productos y Perfil. Fondo surface e indicador mint. El Drawer continúa disponible desde el encabezado, con selección de fondo mint y texto forest.
- **Photo:** FadeInImage con asset local y placeholder en memoria sobre mint; aparición de 220ms, reducida a 1ms cuando MediaQuery desactiva animaciones. Ante error muestra un icono de dispositivos.
- **Feedback:** SnackBar flotante forest con texto canvas para confirmaciones.

- **DiscoveryCarousel:** cuatro colecciones fotográficas (Laptops, Audio, Periféricos y Monitores), alto de 320px y radio de 18px. Títulos de 29px/peso 800, texto de 12px, padding de 24px y degradado oscuro. Flechas e indicadores seleccionan página en 250ms con Cubic(.23,1,.32,1); teclado o movimiento reducido cambian directamente. Los indicadores amplían su ancho de 6px a 22px durante 160ms (duración cero con movimiento reducido), con área de pulsación de 44px.
- **ProductCarousel:** tarjetas horizontales de 260px de alto, viewportFraction de 0.86, sin padding en los extremos y separación derecha de 14px. Fotografías de 160px, contenido con padding de 16px, nombre de una línea y precio lavanda. El desplazamiento por páginas admite ratón y toque; la tarjeta abre el catálogo.
- **Inicio y perfil:** el inicio organiza colecciones, carrusel de productos y acceso compacto al registro. El perfil presenta información editable en formato compacto, sin fotografía de gran tamaño.

## Do's and Don'ts

### Do:

- **Do** reutilizar buildTheme y los componentes compartidos antes de añadir variantes.
- **Do** conservar el formato celular y la navegación inferior también en PC.
- **Do** respetar movimiento reducido en Photo y ActionButton.

### Don't:

- **Don't** añadir sombras a las tarjetas que se definen con elevación cero.
- **Don't** interpretar forest y mint como colores verdes: los tokens actuales son lavanda y azul.
- **Don't** declarar una fuente variable o pesos sin los archivos correspondientes.
