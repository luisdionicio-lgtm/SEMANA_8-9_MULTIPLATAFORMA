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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF121C31),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.code_rounded, color: forest, size: 22),
                  SizedBox(height: 10),
                  Text(
                    'Hecho con Flutter',
                    style: TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Un catálogo, todas tus ideas.',
                    style: TextStyle(fontSize: 11, color: muted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
          bottomNavigationBar: NavigationBar(
            selectedIndex: page,
            onDestinationSelected: navigate,
            height: 72,
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
                      height: 70,
                      padding: EdgeInsets.symmetric(
                        horizontal: desktop ? 38 : 16,
                      ),
                      decoration: const BoxDecoration(
                        color: surface,
                        border: Border(bottom: BorderSide(color: line)),
                      ),
                      child: Row(
                        children: [
                          if (!desktop)
                            IconButton(
                              tooltip: 'Abrir menú',
                              onPressed: () =>
                                  scaffold.currentState!.openDrawer(),
                              icon: const Icon(Icons.menu_rounded),
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
                                color: ink,
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
                                const CircleAvatar(
                                  radius: 19,
                                  backgroundColor: mint,
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: forest,
                                    size: 21,
                                  ),
                                ),
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
                        padding: EdgeInsets.all(desktop ? 38 : 20),
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
                                const SizedBox(height: 38),
                                const Divider(),
                                const SizedBox(height: 12),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Órbita · Tecnología que conecta',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: muted,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Flutter web',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: muted,
                                      ),
                                    ),
                                  ],
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
      PageHeading(
        'Tu próxima órbita.',
        'Hola, ${widget.store.name.split(' ').first}. Encuentra lo que mueve tus ideas.',
      ),
      DiscoveryCarousel(
        onExplore: (category) => setState(() {
          selectedCategory = category;
          page = 2;
        }),
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          Expanded(
            child: Text(
              'En tu radar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TextButton(
            onPressed: () => navigate(2),
            child: const Text('Ver catálogo'),
          ),
        ],
      ),
      const SizedBox(height: 14),
      ProductCarousel(
        products: widget.store.products,
        onView: () => navigate(2),
      ),
      const SizedBox(height: 30),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              const Icon(Icons.add_box_outlined, color: forest, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Haz crecer tu catálogo',
                      style: TextStyle(color: ink, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Una nueva pieza. Más posibilidades.',
                      style: TextStyle(fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () => navigate(1),
                      child: const Text('Registrar producto'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
