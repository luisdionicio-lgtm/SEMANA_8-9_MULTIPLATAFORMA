import 'dart:ui' show PointerDeviceKind;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/app_store.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/workspace_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(MyApp(store: AppStore(preferences)));
}

class MyApp extends StatefulWidget {
  final AppStore store;
  const MyApp({super.key, required this.store});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Órbita — tu catálogo conectado',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      },
    ),
    // La web conserva un viewport de celular, incluso en monitores grandes.
    // MediaQuery interno evita que widgets y diálogos usen el ancho del PC.
    builder: (context, child) => LayoutBuilder(
      builder: (context, limits) {
        final framed = limits.maxWidth >= 600;
        final height = framed
            ? math.min(limits.maxHeight - 48, 812.0)
            : limits.maxHeight;
        final width = framed
            ? math.min(376.0, height / 2.16)
            : math.min(limits.maxWidth, 390.0);
        final screen = MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(width - (framed ? 12 : 0), height - (framed ? 38 : 0)),
          ),
          child: child!,
        );
        return Stack(
          fit: StackFit.expand,
          children: [
            if (framed)
              Image.asset(
                'assets/images/workspace.jpg',
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
            ColoredBox(
              color: framed ? const Color(0xE6091020) : const Color(0xFF0D1426),
            ),
            Center(
              child: Container(
                width: width,
                height: height,
                padding: EdgeInsets.all(framed ? 5 : 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF070B14),
                  borderRadius: BorderRadius.circular(framed ? 36 : 0),
                  border: framed
                      ? Border.all(color: const Color(0xFF596075), width: 1)
                      : null,
                  boxShadow: framed
                      ? const [
                          BoxShadow(
                            color: Color(0x80000000),
                            offset: Offset(0, 14),
                            blurRadius: 40,
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(framed ? 30 : 0),
                  child: Column(
                    children: [
                      if (framed)
                        Container(
                          height: 26,
                          color: const Color(0xFF0D1426),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              const Text(
                                '9:41',
                                style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 64,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.wifi,
                                size: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.battery_full,
                                size: 13,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                      Expanded(child: screen),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
    home: loggedIn
        ? WorkspaceScreen(
            store: widget.store,
            onLogout: () => setState(() => loggedIn = false),
          )
        : LoginScreen(onLogin: () => setState(() => loggedIn = true)),
  );
}
