import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import 'common.dart';

const orbitCurve = Cubic(.23, 1, .32, 1);

class DiscoveryCarousel extends StatefulWidget {
  final ValueChanged<String> onExplore;
  const DiscoveryCarousel({super.key, required this.onExplore});
  @override
  State<DiscoveryCarousel> createState() => _DiscoveryCarouselState();
}

class _DiscoveryCarouselState extends State<DiscoveryCarousel> {
  final controller = PageController();
  int page = 0;
  static const slides = [
    (
      'Laptops',
      'Ideas que\ntoman forma.',
      'Tu próxima gran idea empieza con las herramientas correctas.',
      'laptop.jpg',
    ),
    (
      'Audio',
      'Tu mundo.\nA tu ritmo.',
      'Encuentra espacio para escuchar, crear y concentrarte.',
      'headphones.jpg',
    ),
    (
      'Periféricos',
      'Cada detalle\nhace la diferencia.',
      'Haz de tu escritorio un lugar que se sienta tuyo.',
      'keyboard.jpg',
    ),
    (
      'Monitores',
      'Amplía tus\nposibilidades.',
      'Más espacio para tus proyectos y todo lo que viene.',
      'monitor.jpg',
    ),
  ];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void go(int index, {bool keyboard = false}) {
    if (keyboard ||
        HardwareKeyboard.instance.logicalKeysPressed.isNotEmpty ||
        MediaQuery.disableAnimationsOf(context)) {
      controller.jumpToPage(index);
    } else {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: orbitCurve,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 320,
          child: PageView.builder(
            key: const Key('discovery-carousel'),
            controller: controller,
            itemCount: slides.length,
            onPageChanged: (p) => setState(() => page = p),
            itemBuilder: (context, index) {
              final s = slides[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Photo(s.$4),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x000D1426),
                          Color(0xED0D1426),
                          Color(0xFF0D1426),
                        ],
                        stops: [0, .55, 1],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          s.$2,
                          style: const TextStyle(
                            color: ink,
                            fontSize: 29,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            letterSpacing: -.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          s.$3,
                          style: const TextStyle(
                            color: Color(0xFFD2DAEC),
                            fontSize: 12,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ActionButton.icon(
                          onPressed: () => widget.onExplore(s.$1),
                          icon: const Icon(
                            Icons.arrow_outward_rounded,
                            size: 17,
                          ),
                          label: Text('Explorar ${s.$1.toLowerCase()}'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          for (var i = 0; i < slides.length; i++)
            Semantics(
              label: 'Colección ${i + 1} de ${slides.length}',
              button: true,
              selected: page == i,
              child: InkWell(
                onTap: () => go(i),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: AnimatedContainer(
                      duration: MediaQuery.disableAnimationsOf(context)
                          ? Duration.zero
                          : const Duration(milliseconds: 160),
                      width: 22,
                      transformAlignment: Alignment.center,
                      transform: Matrix4.diagonal3Values(
                        page == i ? 1 : .3,
                        1,
                        1,
                      ),
                      height: 6,
                      decoration: BoxDecoration(
                        color: page == i ? forest : line,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          Text(
            '${page + 1} / ${slides.length}',
            style: const TextStyle(fontSize: 11, color: muted),
          ),
          IconButton(
            tooltip: 'Colección anterior',
            onPressed: page == 0 ? null : () => go(page - 1),
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          IconButton(
            tooltip: 'Siguiente colección',
            onPressed: page == slides.length - 1 ? null : () => go(page + 1),
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    ],
  );
}

class ProductCarousel extends StatefulWidget {
  final List<Product> products;
  final VoidCallback onView;
  const ProductCarousel({
    super.key,
    required this.products,
    required this.onView,
  });
  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final controller = PageController(viewportFraction: .86);
  int page = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(
        height: 260,
        child: PageView.builder(
          key: const Key('product-carousel'),
          controller: controller,
          itemCount: widget.products.length,
          padEnds: false,
          onPageChanged: (p) => setState(() => page = p),
          itemBuilder: (context, index) {
            final p = widget.products[index];
            return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: widget.onView,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Photo(p.image, width: double.infinity, height: 160),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: ink,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    p.price,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: forest,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 18,
                                  color: forest,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            'Desliza para descubrir',
            style: const TextStyle(fontSize: 11, color: muted),
          ),
          const Spacer(),
          Text(
            '${page + 1} / ${widget.products.length}',
            style: const TextStyle(fontSize: 11, color: forest),
          ),
        ],
      ),
    ],
  );
}
