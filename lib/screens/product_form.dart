import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProductForm extends StatefulWidget {
  final AppStore store;
  final VoidCallback onSaved;
  const ProductForm({super.key, required this.store, required this.onSaved});
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController(),
      description = TextEditingController(),
      price = TextEditingController();
  String category = categories.first;
  String? photo;
  bool saving = false, picking = false;
  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }

  // El selector usa memoria y datos base64 para funcionar también en Flutter web.
  // La imagen se guarda junto al producto; no se envía a servicios externos.
  Future<void> pick() async {
    if (picking) return;
    setState(() => picking = true);
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      if (bytes.length > 2 * 1024 * 1024) {
        message(context, 'La imagen debe pesar menos de 2 MB.');
        return;
      }
      final png =
          bytes.length > 8 &&
          bytes[0] == 137 &&
          bytes[1] == 80 &&
          bytes[2] == 78 &&
          bytes[3] == 71;
      final jpg = bytes.length > 3 && bytes[0] == 255 && bytes[1] == 216;
      if (!png && !jpg) {
        message(context, 'Selecciona una imagen JPG o PNG.');
        return;
      }
      setState(
        () => photo =
            'data:image/${png ? 'png' : 'jpeg'};base64,${base64Encode(bytes)}',
      );
    } catch (_) {
      if (mounted) message(context, 'No se pudo abrir la imagen.');
    } finally {
      if (mounted) setState(() => picking = false);
    }
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || saving) return;
    setState(() => saving = true);
    try {
      await widget.store.add(
        Product(
          id: 'OR-${DateTime.now().microsecondsSinceEpoch}',
          name: name.text.trim(),
          description: description.text.trim(),
          cents: parseCents(price.text)!,
          category: category,
          image: photo ?? categoryImage(category),
        ),
      );
      if (!mounted) return;
      message(context, 'Producto guardado.');
      widget.onSaved();
    } catch (_) {
      if (mounted) {
        setState(() => saving = false);
        message(
          context,
          'No se pudo guardar. Revisa el espacio del navegador.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'REGISTRAR\nPRODUCTOS',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            height: 1,
            color: ink,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 22),
        InkWell(
          onTap: picking ? null : pick,
          child: BoldPanel(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                if (photo != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Photo(photo!, width: 48, height: 48),
                  )
                else
                  const Icon(Icons.add_a_photo_outlined, size: 35),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        picking
                            ? 'Abriendo…'
                            : photo == null
                            ? 'Subir fotografía'
                            : 'Cambiar fotografía',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        'JPG o PNG · máximo 2 MB',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.add_circle_outline),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          key: const Key('product-name'),
          controller: name,
          maxLength: 80,
          validator: requiredText,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Nombre del producto *',
            counterText: '',
            hintText: 'Ej. Laptop Pro 16',
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          key: const Key('product-description'),
          controller: description,
          maxLength: 400,
          maxLines: 3,
          validator: requiredText,
          decoration: const InputDecoration(
            labelText: 'Descripción *',
            counterText: '',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: category,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Categoría'),
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: saving ? null : (c) => setState(() => category = c!),
        ),
        const SizedBox(height: 16),
        TextFormField(
          key: const Key('product-price'),
          controller: price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) => parseCents(v ?? '') == null
              ? 'Ingresa un precio mayor a 0.'
              : null,
          onFieldSubmitted: (_) => save(),
          decoration: const InputDecoration(
            labelText: 'Precio *',
            prefixText: 'S/ ',
            fillColor: mint,
            hintText: '0.00',
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ActionButton.icon(
            onPressed: saving ? null : save,
            icon: const Icon(Icons.check_rounded),
            label: Text(saving ? 'Guardando…' : 'Guardar producto'),
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}
