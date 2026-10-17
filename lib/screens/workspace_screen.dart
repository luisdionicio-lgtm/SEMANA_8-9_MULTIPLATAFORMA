import 'package:flutter/material.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/carousels.dart';
import 'product_form.dart';
import 'profile_screen.dart';
import 'product_list.dart';

class WorkspaceScreen extends StatefulWidget {
  final AppStore store;
  final VoidCallback onLogout;
  const WorkspaceScreen({
    super.key,
    required this.store,
    required this.onLogout,
  });
  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  int page = 0;
  String selectedCategory = 'Todos';
  final scaffold = GlobalKey<ScaffoldState>();
  final titles = ['Menú', 'Registrar productos', 'Listar productos', 'Perfil'];
  void navigate(int value) {
    selectedCategory = 'Todos';
    setState(() => page = value);
    scaffold.currentState?.closeDrawer();
  }

  Widget navigation(bool mobile) => Container(
    width: 244,
    color: surface,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 38),
              child: Brand(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 15),
              child: Text(
                'ESPACIO DE TRABAJO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: muted,
                ),
              ),
            ),
            for (final (index, icon) in [
              Icons.space_dashboard_outlined,
              Icons.add_box_outlined,
              Icons.inventory_2_outlined,
              Icons.person_outline_rounded,
            ].indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Material(
                  color: page == index ? mint : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 3,
                    ),
                    leading: Icon(
                      icon,
                      size: 21,
                      color: page == index ? forest : muted,
                    ),
                    title: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: page == index
                            ? FontWeight.w800
                            : FontWeight.w500,
                        color: page == index ? forest : muted,
                      ),
                    ),
                    onTap: () => navigate(index),
                  ),
                ),
              ),
            const Spacer(),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(Icons.logout_rounded, size: 20, color: muted),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 12, color: muted),
              ),
              onTap: widget.onLogout,
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Órbita · Laboratorio 08 / 09',
                style: TextStyle(fontSize: 10, color: muted),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.store,
    builder: (context, _) => LayoutBuilder(
      builder: (context, c) {
        final desktop = c.maxWidth >= 1050;
        return Scaffold(
          key: scaffold,
          backgroundColor: [const Color(0xFF102D2C), coral, forest, mint][page],
          bottomNavigationBar: NavigationBar(
            selectedIndex: page,
            onDestinationSelected: navigate,
            height: 66,
            backgroundColor: surface,
            indicatorColor: mint,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Menú',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_box_outlined),
                label: 'Registrar',
              ),
              NavigationDestination(
                icon: Icon(Icons.search_rounded),
                label: 'Productos',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Perfil',
              ),
            ],
          ),
          drawer: desktop ? null : Drawer(child: navigation(true)),
          body: Row(
            children: [
              if (desktop) ...[
                navigation(false),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(
                        horizontal: desktop ? 38 : 16,
                      ),
                      decoration: const BoxDecoration(
                        color: ink,
                        border: Border(bottom: BorderSide(color: line)),
                      ),
                      child: Row(
                        children: [
                          if (!desktop)
                            IconButton(
                              tooltip: 'Abrir menú',
                              onPressed: () =>
                                  scaffold.currentState!.openDrawer(),
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                              ),
                            ),
                          if (desktop) ...[
                            const Text(
                              'Workspace',
                              style: TextStyle(fontSize: 12, color: muted),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Icon(
                                Icons.chevron_right,
                                size: 15,
                                color: muted,
                              ),
                            ),
                          ],
                          Expanded(
                            child: Text(
                              titles[page],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (c.maxWidth > 650)
                            const Padding(
                              padding: EdgeInsets.only(right: 24),
                              child: Tag('Entorno demo'),
                            ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => navigate(3),
                            child: Row(
                              children: [
                                const ProfilePhoto(),
                                if (c.maxWidth > 650) ...[
                                  const SizedBox(width: 11),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.store.name,
                                        style: const TextStyle(
                                          color: ink,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Text(
                                        'Administrador demo',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        key: ValueKey('page-scroll-$page'),
                        padding: EdgeInsets.all(desktop ? 38 : 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1280),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.store.storageWarning)
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      'No se pudieron leer algunos datos locales. Se muestran los datos de ejemplo.',
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ),
                                // El estado del catálogo vive por encima de las pantallas: navegar no
                                // pierde productos. ValueKey reinicia formularios al cambiar de tarea.
                                KeyedSubtree(
                                  key: ValueKey(page),
                                  child: switch (page) {
                                    1 => ProductForm(
                                      store: widget.store,
                                      onSaved: () => navigate(2),
                                    ),
                                    2 => ProductList(
                                      initialCategory: selectedCategory,
                                      store: widget.store,
                                      onRegister: () => navigate(1),
                                    ),
                                    3 => ProfileScreen(store: widget.store),
                                    _ => home(context),
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  Widget home(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'MENÚ',
        style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          height: 1,
        ),
      ),
      const SizedBox(height: 20),
      BoldPanel(
        color: ink,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VALOR DEL CATÁLOGO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: mint,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'S/ ${(widget.store.products.fold<int>(0, (total, p) => total + p.cents) / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: mint,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${widget.store.products.length} productos',
              style: const TextStyle(color: cyan, fontSize: 11),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          menuTile(
            'Registrar\nproductos',
            Icons.add_box_outlined,
            mint,
            () => navigate(1),
          ),
          menuTile(
            'Listar\nproductos',
            Icons.format_list_bulleted_rounded,
            coral,
            () => navigate(2),
          ),
          menuTile(
            'Perfil',
            Icons.person_outline_rounded,
            forest,
            () => navigate(3),
            light: true,
          ),
          menuTile(
            'Logout',
            Icons.logout_rounded,
            const Color(0xFFFFC400),
            widget.onLogout,
          ),
        ],
      ),
      const SizedBox(height: 30),
      const Text(
        'EN TU ÓRBITA',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 22,
        ),
      ),
      const SizedBox(height: 14),
      DiscoveryCarousel(
        onExplore: (category) => setState(() {
          selectedCategory = category;
          page = 2;
        }),
      ),
      const SizedBox(height: 20),
      ProductCarousel(
        products: widget.store.products,
        onView: () => navigate(2),
      ),
    ],
  );
  Widget menuTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool light = false,
  }) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: BoldPanel(
        color: color,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: light ? Colors.white : ink, size: 24),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    softWrap: false,
                    style: TextStyle(
                      color: light ? Colors.white : ink,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: light ? Colors.white : ink,
            ),
          ],
        ),
      ),
    ),
  );
}
