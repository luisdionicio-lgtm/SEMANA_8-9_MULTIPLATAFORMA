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
  late String category;
  String sort = 'Catálogo';
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
    final q = search.text.trim().toLowerCase();
    final products = widget.store.products
        .where(
          (p) =>
              (category == 'Todos' || category == p.category) &&
              (p.name.toLowerCase().contains(q) ||
                  p.description.toLowerCase().contains(q) ||
                  p.id.toLowerCase().contains(q)),
        )
        .toList();
    if (sort == 'Menor precio') {
      products.sort((a, b) => a.cents.compareTo(b.cents));
    }
    if (sort == 'Mayor precio') {
      products.sort((a, b) => b.cents.compareTo(a.cents));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LISTAR\nPRODUCTOS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 31,
            height: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('product-search'),
                controller: search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Buscar producto…',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: q.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Limpiar búsqueda',
                          onPressed: () {
                            search.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Ordenar productos',
              icon: const Icon(Icons.tune, color: Colors.white),
              onSelected: (s) => setState(() => sort = s),
              itemBuilder: (_) => [
                'Catálogo',
                'Menor precio',
                'Mayor precio',
              ].map((s) => PopupMenuItem(value: s, child: Text(s))).toList(),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['Todos', ...categories]
                .map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        c,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ink,
                          fontSize: 12,
                        ),
                      ),
                      selected: category == c,
                      onSelected: (_) => setState(() => category = c),
                      selectedColor: mint,
                      backgroundColor: surface,
                      showCheckmark: false,
                      side: const BorderSide(color: ink, width: 2),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 22),
        if (products.isEmpty)
          BoldPanel(
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 40),
                const SizedBox(height: 12),
                const Text(
                  'No encontramos productos',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {
                    search.clear();
                    setState(() => category = 'Todos');
                  },
                  child: const Text('Restablecer filtros'),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) => tile(context, products[i], i),
          ),
        const SizedBox(height: 16),
        Text(
          '${products.length} productos · precios en soles',
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Widget tile(BuildContext context, Product p, int index) => InkWell(
    onTap: () => showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(p.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Photo(p.image, width: 260, height: 170),
              const SizedBox(height: 16),
              Text(p.description),
              const SizedBox(height: 12),
              Text(
                p.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                ),
              ),
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
    child: BoldPanel(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Photo(p.image, width: 56, height: 60),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  p.id.length > 12
                      ? 'OR-${p.id.substring(p.id.length - 6)}'
                      : p.id,
                  style: const TextStyle(fontSize: 9, color: muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            decoration: BoxDecoration(
              color: [mint, coral, cyan, const Color(0xFFFFC400)][index % 4],
              border: Border.all(color: ink, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              p.price.replaceAll('.00', ''),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
            ),
          ),
        ],
      ),
    ),
  );
}
