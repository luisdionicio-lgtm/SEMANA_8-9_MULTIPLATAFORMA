import 'package:flutter/material.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProfileScreen extends StatefulWidget {
  final AppStore store;
  const ProfileScreen({super.key, required this.store});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final form = GlobalKey<FormState>();
  late final name = TextEditingController(text: widget.store.name),
      email = TextEditingController(text: widget.store.email),
      phone = TextEditingController(text: widget.store.phone);
  bool editing = false, saving = false;
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!form.currentState!.validate() || saving) return;
    setState(() => saving = true);
    try {
      await widget.store.updateProfile(
        name.text.trim(),
        email.text.trim(),
        phone.text.trim(),
      );
      if (!mounted) return;
      setState(() {
        editing = false;
        saving = false;
      });
      message(context, 'Perfil actualizado.');
    } catch (_) {
      if (mounted) {
        setState(() => saving = false);
        message(context, 'No se pudo guardar. Inténtalo otra vez.');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'PERFIL',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w900,
          height: 1,
          color: ink,
        ),
      ),
      const SizedBox(height: 22),
      BoldPanel(
        color: coral,
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(13),
          color: surface,
          child: Row(
            children: [
              const ProfilePhoto(radius: 34),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.store.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Cuenta de demostración',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      Form(
        key: form,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              readOnly: !editing,
              validator: requiredText,
              maxLength: 80,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                counterText: '',
                fillColor: mint,
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: email,
              readOnly: !editing,
              validator: emailValidator,
              maxLength: 120,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo',
                counterText: '',
                fillColor: surface,
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: phone,
              readOnly: !editing,
              maxLength: 20,
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null ||
                      !RegExp(r'^\+?[\d\s()-]{7,20}$').hasMatch(v.trim())
                  ? 'Ingresa un teléfono válido.'
                  : null,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                counterText: '',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ActionButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: coral,
                  foregroundColor: ink,
                ),
                onPressed: saving
                    ? null
                    : () {
                        if (editing) {
                          save();
                        } else {
                          setState(() => editing = true);
                        }
                      },
                icon: Icon(editing ? Icons.check : Icons.arrow_forward_rounded),
                label: Text(
                  saving
                      ? 'Guardando…'
                      : editing
                      ? 'Guardar cambios'
                      : 'Editar perfil',
                ),
              ),
            ),
            if (editing)
              TextButton(
                onPressed: saving
                    ? null
                    : () {
                        name.text = widget.store.name;
                        email.text = widget.store.email;
                        phone.text = widget.store.phone;
                        setState(() => editing = false);
                      },
                child: const Text('Cancelar'),
              ),
          ],
        ),
      ),
    ],
  );
}
