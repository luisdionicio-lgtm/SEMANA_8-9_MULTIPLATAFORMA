---
name: Órbita
description: Tienda tecnológica móvil con diseño de alto contraste.
colors:
  ink: "#10110C"
  violet: "#4930F4"
  lime: "#D8FF22"
  coral: "#FF593D"
  cyan: "#25D9E8"
  surface: "#F8F8EF"
  muted: "#55564D"
typography:
  headline-large:
    fontFamily: Manrope
    fontSize: 42px
    fontWeight: 900
  headline-medium:
    fontFamily: Manrope
    fontSize: 30px
    fontWeight: 900
rounded:
  panel: 8px
  field: 6px
spacing:
  page: 16px
  panel: 20px
---

## Overview

La última referencia del usuario gobierna el diseño: colores intensos, bordes negros, sombras de bloque y menos texto. La marca permanece Órbita.

## Colors

`forest` es el nombre heredado del violeta y `mint` corresponde al lima. El login y el listado usan violeta; el menú usa verde oscuro con bloques lima, coral, violeta y amarillo; registro coral y perfil lima. Formularios y tarjetas del catálogo usan surface con texto negro.

## Typography

Manrope local, archivos estáticos 400–800. Los títulos de pantalla usan tamaños de 30–44px y peso fuerte; Flutter usa el peso disponible más próximo cuando se solicita 900. Los detalles secundarios se reducen al mínimo.

## Layout

Teléfono en PC con alto máximo812px, ancho máximo376px y proporción alto/ancho2.16, adaptado al espacio disponible. Padding del marco5px, borde1px, radios exterior36/interior30 y barra de estado26px. En móvil el contenido ocupa el viewport, hasta390px. Navegación inferior fija y páginas desplazables con clave independiente.

## Elevation & Depth

BoldPanel usa borde negro2px y sombra negra desplazada4px/5px sin blur: rasgo pedido en las referencias. El marco del teléfono usa sombra suave40px con desplazamiento vertical14px.

## Shapes

Paneles de8px y campos de6px. Foto de perfil circular local y marca de radar. No se añaden adornos que sustituyan datos o acciones.

## Components

Login sobre panel claro; menú con valor real del catálogo y cuatro accesos; listado con filas fotográficas y etiquetas de precio en colores; registro con selector de imagen JPG/PNG2MB; perfil con foto, tres campos y acción de edición. Se mantienen carruseles de colecciones y productos debajo del menú. Presión120ms/escala.98 y curvaCubic(.23,1,.32,1); carrusel250ms, controles accesibles y movimiento reducido.

## Do's and Don'ts

Preservar las cinco pantallas y sus flujos. Mantener texto conciso y contraste. No mostrar indicadores verificados, precios promocionales, gráficos ni estados inventados. El acceso y la fotografía de perfil son de demostración.
