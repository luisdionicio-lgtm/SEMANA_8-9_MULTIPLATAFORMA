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
  bool obscure = true;
  String? error;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void submit() {
    if (!form.currentState!.validate()) return;
    if (email.text.trim().toLowerCase() == 'demo@orbita.pe' &&
        password.text == 'Demo2026!') {
      widget.onLogin();
    } else {
      setState(() => error = 'Usa los datos de demostración.');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Brand(light: true),
          const SizedBox(height: 28),
          Transform.rotate(
            angle: -.045,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              color: mint,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.north_east_rounded, size: 20),
                  SizedBox(width: 7),
                  Text(
                    'TU PRÓXIMA ÓRBITA',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          BoldPanel(
            color: surface,
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ingresa a tu tienda.',
                    style: TextStyle(color: muted),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    key: const Key('login-email'),
                    controller: email,
                    validator: emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    key: const Key('login-password'),
                    controller: password,
                    validator: requiredText,
                    obscureText: obscure,
                    onFieldSubmitted: (_) => submit(),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        tooltip: obscure
                            ? 'Mostrar contraseña'
                            : 'Ocultar contraseña',
                        onPressed: () => setState(() => obscure = !obscure),
                        icon: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ActionButton.icon(
                      onPressed: submit,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                      label: const Text('Ingresar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                email.text = 'demo@orbita.pe';
                password.text = 'Demo2026!';
              },
              child: const Text('Completar datos de prueba'),
            ),
          ),
          const Center(
            child: Text(
              'Acceso de demostración',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ),
        ],
      ),
    ),
  );
}
