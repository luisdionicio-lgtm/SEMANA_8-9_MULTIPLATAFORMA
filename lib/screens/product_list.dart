import 'package:flutter/material.dart';
import '../services/app_store.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProductList extends StatefulWidget {
  final AppStore store;
  final VoidCallback onRegister;
  final String initialCategory;
  const ProductList({
    super.key,
    required this.store,
    required this.onRegister,
    this.initialCategory = 'Todos',
  });
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final search = TextEditingController();
  String category = 'Todos', sort = 'Recientes';
  @override
  void initState() {
    super.initState();
    category = widget.initialCategory;
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = search.text.trim().toLowerCase();
    final products = widget.store.products
        .where(
          (p) =>
              (category == 'Todos' || p.category == category) &&
              (p.name.toLowerCase().contains(query) ||
                  p.description.toLowerCase().contains(query)),
        )
        .toList();
    if (sort == 'Menor precio') {
      products.sort((a, b) => a.cents.compareTo(b.cents));
    } else if (sort == 'Mayor precio') {
      products.sort((a, b) => b.cents.compareTo(a.cents));
    } else {
      final reversed = products.reversed.toList();
      products
        ..clear()
        ..addAll(reversed);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeading('Listar productos', 'Tecnología para lo que viene.'),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('product-search'),
                controller: search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Buscar productos…',
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: search.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Limpiar búsqueda',
                          onPressed: () {
                            search.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close, size: 18),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              tooltip: 'Ordenar productos',
              initialValue: sort,
              onSelected: (s) => setState(() => sort = s),
              icon: const Icon(Icons.tune_rounded),
              itemBuilder: (context) => [
                'Recientes',
                'Menor precio',
                'Mayor precio',
              ].map((s) => PopupMenuItem(value: s, child: Text(s))).toList(),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Todos', ...categories]
              .map(
                (cat) => ChoiceChip(
                  label: Text(cat, style: const TextStyle(fontSize: 12)),
                  selected: cat == category,
                  onSelected: (_) => setState(() => category = cat),
                  selectedColor: mint,
                  showCheckmark: false,
                  side: BorderSide(color: cat == category ? forest : line),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 18,
          runSpacing: 8,
          children: [
            Text(
              '${products.length} productos',
              style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
            ),
            const Text(
              'Precios en soles · PEN',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (products.isEmpty)
          Card(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 44,
                      color: muted,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No encontramos productos',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text('Prueba con otro nombre o cambia la categoría.'),
                    const SizedBox(height: 18),
                    OutlinedButton(
                      onPressed: () {
                        search.clear();
                        setState(() => category = 'Todos');
                      },
                      child: const Text('Restablecer filtros'),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 260,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) => productTile(context, products[i]),
          ),
        const SizedBox(height: 14),
        const Text(
          'Catálogo de demostración · Las fotografías son referenciales.',
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Widget productTile(BuildContext context, Product p) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(p.name),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Photo(p.image, width: 280, height: 170),
                ),
                const SizedBox(height: 18),
                Tag(p.category),
                const SizedBox(height: 14),
                Text(p.description),
                const SizedBox(height: 18),
                Text(p.price, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Photo(p.image, width: double.infinity, height: 120),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.category,
                    style: const TextStyle(color: muted, fontSize: 10),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.price,
                          style: const TextStyle(
                            color: forest,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_outward_rounded,
                        size: 17,
                        color: muted,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
