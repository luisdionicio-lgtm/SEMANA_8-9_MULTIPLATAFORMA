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
      message(context, 'Tu perfil se actualizó correctamente.');
    } catch (_) {
      if (mounted) {
        setState(() => saving = false);
        message(context, 'No se pudo guardar el perfil. Inténtalo otra vez.');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const PageHeading(
        'Perfil',
        'Los detalles que hacen tu espacio más tuyo.',
      ),
      LayoutBuilder(
        builder: (context, c) {
          final identity = Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: mint,
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: forest,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.store.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.store.email,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Administrador demo',
                          style: TextStyle(color: forest, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          final details = Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información personal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text('Mantén actualizados tus datos de contacto.'),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: name,
                      readOnly: !editing,
                      validator: requiredText,
                      maxLength: 80,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        counterText: '',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: email,
                      readOnly: !editing,
                      validator: emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 120,
                      decoration: const InputDecoration(
                        labelText: 'Correo',
                        counterText: '',
                        prefixIcon: Icon(Icons.mail_outline_rounded, size: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phone,
                      readOnly: !editing,
                      validator: (v) =>
                          v == null ||
                              !RegExp(
                                r'^\+?[\d\s()-]{7,20}$',
                              ).hasMatch(v.trim())
                          ? 'Ingresa un teléfono válido (7 a 20 caracteres).'
                          : null,
                      keyboardType: TextInputType.phone,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        prefixIcon: Icon(Icons.phone_outlined, size: 20),
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Divider(),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ActionButton.icon(
                          onPressed: saving
                              ? null
                              : () {
                                  if (editing) {
                                    save();
                                  } else {
                                    setState(() => editing = true);
                                  }
                                },
                          icon: Icon(
                            editing ? Icons.check_rounded : Icons.edit_outlined,
                            size: 18,
                          ),
                          label: Text(
                            saving
                                ? 'Guardando…'
                                : editing
                                ? 'Guardar cambios'
                                : 'Editar perfil',
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
                    const SizedBox(height: 22),
                    const Text(
                      'Perfil de ejemplo guardado en este navegador. Usa datos ficticios para el laboratorio. Editar el correo del perfil no modifica el acceso demo.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          );
          return c.maxWidth >= 850
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: identity),
                    const SizedBox(width: 28),
                    Expanded(flex: 3, child: details),
                  ],
                )
              : Column(
                  children: [identity, const SizedBox(height: 24), details],
                );
        },
      ),
    ],
  );
}
