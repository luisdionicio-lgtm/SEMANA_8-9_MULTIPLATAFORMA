import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();
  final email = TextEditingController(), password = TextEditingController();
  bool obscure = true, busy = false;
  String? error;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!form.currentState!.validate() || busy) return;
    setState(() {
      busy = true;
      error = null;
    });
    // Acceso docente demostrativo. Estas credenciales públicas no son secretos.
    // No simula seguridad real ni envía credenciales a terceros.
    if (!mounted) return;
    if (email.text.trim().toLowerCase() == 'demo@orbita.pe' &&
        password.text == 'Demo2026!') {
      widget.onLogin();
    } else {
      setState(() {
        busy = false;
        error = 'Los datos no coinciden. Usa el acceso de demostración.';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final login = Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 16 : 26,
                vertical: 40,
              ),
              child: Form(
                key: form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!wide) ...[const Brand(), const SizedBox(height: 48)],
                    Text(
                      'Entra a tu\npróxima órbita.',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Ingresa y dale un nuevo ritmo a tu catálogo de tecnología.',
                      style: TextStyle(fontSize: 15, height: 1.7, color: muted),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      key: const Key('login-email'),
                      controller: email,
                      validator: emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.username],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        hintText: 'tu@correo.com',
                        prefixIcon: Icon(Icons.mail_outline_rounded, size: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const Key('login-password'),
                      controller: password,
                      obscureText: obscure,
                      validator: requiredText,
                      onFieldSubmitted: (_) => submit(),
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          tooltip: obscure
                              ? 'Mostrar contraseña'
                              : 'Ocultar contraseña',
                          onPressed: () => setState(() => obscure = !obscure),
                          icon: Icon(
                            obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    if (error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ActionButton(
                        onPressed: busy ? null : submit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (busy)
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            else
                              const Text('Ingresar'),
                            const SizedBox(width: 12),
                            if (!busy)
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: mint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.science_outlined,
                                size: 18,
                                color: forest,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Acceso de demostración',
                                style: TextStyle(
                                  color: forest,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const SelectableText(
                            'demo@orbita.pe  ·  Demo2026!',
                            style: TextStyle(fontSize: 12, color: forest),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              email.text = 'demo@orbita.pe';
                              password.text = 'Demo2026!';
                            },
                            child: const Text('Completar datos de prueba'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Laboratorio Flutter web · Datos locales de ejemplo',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        if (!wide) return SingleChildScrollView(child: login);
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const Photo('workspace.jpg'),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x40122D24),
                              Color(0x10122D24),
                              Color(0xEE122D24),
                            ],
                            stops: [0, .35, 1],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 32,
                        left: 32,
                        child: Brand(light: true),
                      ),
                      Positioned(
                        left: 36,
                        right: 36,
                        bottom: 42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Un buen espacio.\nGrandes posibilidades.',
                              style: TextStyle(
                                fontSize: 42,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                                color: surface,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'La tecnología que inspira tu próximo paso,\nen un solo lugar.',
                              style: TextStyle(
                                color: Color(0xFFD8E9DF),
                                fontSize: 16,
                                height: 1.7,
                              ),
                            ),
                            const SizedBox(height: 34),
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 4,
                                  color: const Color(0xFFC6E7CE),
                                ),
                                const SizedBox(width: 7),
                                Container(
                                  width: 10,
                                  height: 4,
                                  color: Colors.white38,
                                ),
                                const Spacer(),
                                const Text(
                                  'ÓRBITA / WORKSPACE',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    letterSpacing: 1.4,
                                  ),
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
            ),
            Expanded(child: SingleChildScrollView(child: login)),
          ],
        );
      },
    ),
  );
}
