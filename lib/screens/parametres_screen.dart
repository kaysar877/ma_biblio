import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/services/livre_service.dart';

class ParametresScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback onReset;

  const ParametresScreen({super.key, required this.livres, required this.onReset});

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              subtitle: const Text('Nom, e-mail, mot de passe'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil sélectionné')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              tileColor: Colors.blue.shade50,
              iconColor: Colors.blue,
              textColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Langue'),
              subtitle: const Text('Français'),
            ),
            ListTile(
              // dense reduit la hauteur, isThreeLine permet 3 lignes, enabled false desactive le tile
              dense: true,
              isThreeLine: true,
              enabled: false,
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              subtitle: const Text('MaBiblio v1.0\nApplication de gestion de bibliothèque'),
            ),
            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Réinitialiser ma bibliothèque'),
              subtitle: const Text('Efface les lectures et favoris sauvegardés'),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Réinitialiser ?'),
                    content: const Text(
                      'Les états de lecture et favoris seront réinitialisés. Confirmer ?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Confirmer'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await reinitialiserLivres();
                  widget.onReset();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bibliothèque réinitialisée')),
                    );
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
