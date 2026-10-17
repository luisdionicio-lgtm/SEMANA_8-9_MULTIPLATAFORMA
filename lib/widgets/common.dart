import 'dart:convert';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Brand extends StatelessWidget {
  final bool light;
  const Brand({super.key, this.light = false});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: light ? Colors.white : forest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.radar_rounded,
          color: light ? forest : Colors.white,
          size: 24,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'órbita',
        style: TextStyle(
          fontSize: 29,
          letterSpacing: -1.1,
          fontWeight: FontWeight.w800,
          color: light ? Colors.white : ink,
        ),
      ),
    ],
  );
}

class Photo extends StatelessWidget {
  final String file;
  final double? width, height;
  final BoxFit fit;
  const Photo(
    this.file, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: mint,
    // FadeInImage del laboratorio con placeholder en memoria y foto local:
    // no depende de peticiones externas ni de CORS durante la presentación.
    child: FadeInImage(
      placeholder: MemoryImage(
        base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==',
        ),
      ),
      image: AssetImage('assets/images/$file'),
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: MediaQuery.disableAnimationsOf(context)
          ? const Duration(milliseconds: 1)
          : const Duration(milliseconds: 220),
      imageErrorBuilder: (_, _, _) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(Icons.devices_outlined, color: forest, size: 36),
        ),
      ),
    ),
  );
}

class Tag extends StatelessWidget {
  final String text;
  const Tag(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: mint,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: forest,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class PageHeading extends StatelessWidget {
  final String title, subtitle;
  final Widget? action;
  const PageHeading(this.title, this.subtitle, {super.key, this.action});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 28),
    child: LayoutBuilder(
      builder: (context, c) {
        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(subtitle),
          ],
        );
        return c.maxWidth < 650
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  if (action != null) ...[const SizedBox(height: 16), action!],
                ],
              )
            : Row(
                children: [
                  Expanded(child: heading),
                  if (action != null) action!,
                ],
              );
      },
    ),
  );
}

String? requiredText(String? value) =>
    value == null || value.trim().isEmpty ? 'Completa este campo.' : null;
String? emailValidator(String? value) =>
    value == null ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())
    ? 'Ingresa un correo válido.'
    : null;
void message(BuildContext context, String text) => ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(text)));

// Feedback táctil de Emil: presión breve e interrumpible, sin animación al
// activar con teclado. Se conserva FilledButton para foco y accesibilidad.
class ActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget child;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });
  ActionButton.icon({
    super.key,
    required this.onPressed,
    required Widget icon,
    required Widget label,
    this.style,
  }) : child = Row(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           icon,
           const SizedBox(width: 8),
           Flexible(child: label),
         ],
       );
  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: widget.onPressed == null
        ? null
        : (_) => setState(() => pressed = true),
    onPointerUp: (_) => setState(() => pressed = false),
    onPointerCancel: (_) => setState(() => pressed = false),
    child: AnimatedScale(
      scale: pressed && !MediaQuery.disableAnimationsOf(context) ? .98 : 1,
      duration: const Duration(milliseconds: 120),
      curve: const Cubic(.23, 1, .32, 1),
      child: FilledButton(
        onPressed: widget.onPressed,
        style: widget.style,
        child: widget.child,
      ),
    ),
  );
}
