import 'package:flutter/material.dart';
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
  bool saving = false;
  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || saving) return;
    setState(() => saving = true);
    try {
      await widget.store.add(
        Product(
          id: 'NX-${DateTime.now().microsecondsSinceEpoch}',
          name: name.text.trim(),
          description: description.text.trim(),
          cents: parseCents(price.text)!,
          category: category,
          image: categoryImage(category),
        ),
      );
      if (!mounted) return;
      message(context, 'Producto guardado. Ya está en tu catálogo.');
      widget.onSaved();
    } catch (_) {
      if (mounted) {
        setState(() => saving = false);
        message(
          context,
          'No se pudo guardar. Revisa el almacenamiento del navegador e inténtalo otra vez.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const PageHeading(
        'Registrar productos',
        'Dale un lugar a la próxima pieza de tu catálogo.',
      ),
      LayoutBuilder(
        builder: (context, c) {
          final fields = Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información del producto',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    const Text('Los campos con * son obligatorios.'),
                    const SizedBox(height: 28),
                    TextFormField(
                      key: const Key('product-name'),
                      controller: name,
                      maxLength: 80,
                      validator: requiredText,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Nombre del producto *',
                        hintText: 'Ej. Laptop Pro 14',
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      key: const Key('product-description'),
                      controller: description,
                      maxLength: 400,
                      maxLines: 4,
                      validator: requiredText,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Descripción *',
                        alignLabelWithHint: true,
                        hintText: '¿Qué hace especial a este producto?',
                      ),
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: category,
                      decoration: const InputDecoration(labelText: 'Categoría'),
                      items: categories
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: saving
                          ? null
                          : (v) => setState(() => category = v!),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const Key('product-price'),
                      controller: price,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) => parseCents(v ?? '') == null
                          ? 'Ingresa un precio mayor a 0, con hasta 2 decimales.'
                          : null,
                      onChanged: (_) => setState(() {}),
                      onFieldSubmitted: (_) => save(),
                      decoration: const InputDecoration(
                        labelText: 'Precio *',
                        prefixText: 'S/  ',
                        hintText: '0.00',
                        helperText: 'Moneda: soles peruanos (PEN).',
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ActionButton.icon(
                          onPressed: saving ? null : save,
                          icon: const Icon(Icons.check_rounded, size: 19),
                          label: Text(
                            saving ? 'Guardando…' : 'Guardar producto',
                          ),
                        ),
                        TextButton(
                          onPressed: saving
                              ? null
                              : () {
                                  form.currentState!.reset();
                                  name.clear();
                                  description.clear();
                                  price.clear();
                                  setState(() => category = categories.first);
                                },
                          child: const Text('Limpiar campos'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          final preview = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vista previa',
                style: TextStyle(
                  color: ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Así se verá en tu catálogo.'),
              const SizedBox(height: 18),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Photo(
                      categoryImage(category),
                      width: double.infinity,
                      height: 210,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tag(category),
                          const SizedBox(height: 16),
                          Text(
                            name.text.trim().isEmpty
                                ? 'Tu próximo producto'
                                : name.text.trim(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description.text.trim().isEmpty
                                ? 'Una buena descripción marca la diferencia.'
                                : description.text.trim(),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            'S/ ${((parseCents(price.text) ?? 0) / 100).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: forest,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 18, color: muted),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'La fotografía referencial se asigna según la categoría. Los cambios se guardan en este navegador.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          );
          return c.maxWidth >= 850
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: fields),
                    const SizedBox(width: 28),
                    Expanded(flex: 2, child: preview),
                  ],
                )
              : Column(children: [fields, const SizedBox(height: 28), preview]);
        },
      ),
    ],
  );
}
