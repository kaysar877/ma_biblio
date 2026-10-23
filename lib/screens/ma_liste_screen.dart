import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/services/livre_service.dart';
import 'package:ma_biblio/screens/detail_screen.dart';

class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;
  const MaListeScreen({super.key, required this.livres});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  IconData _iconeGenre(String g) {
    switch (g) {
      case 'Roman':
        return Icons.menu_book;
      case 'Science':
        return Icons.science;
      case 'Histoire':
        return Icons.history_edu;
      case 'Jeunesse':
        return Icons.child_care;
      case 'Informatique':
        return Icons.computer;
      default:
        return Icons.book;
    }
  }

  List<Livre> get _affiches {
    return widget.livres.where((l) {
      if (_nouveautesSeulement && !l.nouveaute) return false;
      if (!(_genres[l.genre] ?? true)) return false;
      return true;
    }).toList();
  }

  bool get _tousSelectionnes =>
      _genres.values.every((v) => v) && _genres.isNotEmpty;
  bool get _aucunSelectionne => _genres.values.every((v) => !v);

  void _toggleTous(bool? value) {
    setState(() {
      if (value == true) {
        _genres.updateAll((k, v) => true);
      } else {
        _genres.updateAll((k, v) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final affiches = _affiches;
    final lus = affiches.where((l) => l.lu).length;
    return Scaffold(
      appBar: AppBar(title: Text('Lus : $lus / ${affiches.length}')),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (v) => setState(() => _nouveautesSeulement = v ?? false),
          ),
          ..._genres.keys.map((g) {
            final count = widget.livres.where((l) => l.genre == g).length;
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Icon(_iconeGenre(g)),
              title: Text(g),
              subtitle: Text('$count livres'),
              activeColor: Colors.blue,
              value: _genres[g],
              onChanged: (v) => setState(() => _genres[g] = v ?? false),
            );
          }),
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousSelectionnes
                ? true
                : (_aucunSelectionne ? false : null),
            onChanged: _toggleTous,
          ),
          Expanded(
            child: affiches.isEmpty
                ? const Center(child: Text('Aucun livre à afficher'))
                : ListView.separated(
                    itemCount: affiches.length,
                    separatorBuilder: (c, i) => const Divider(),
                    itemBuilder: (context, i) {
                      final l = affiches[i];
                      return InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailScreen(livre: l, livres: widget.livres)),
                          );
                          setState(() {});
                        },
                        child: CheckboxListTile(
                        title: Text(
                          l.titre,
                          style: l.lu
                              ? const TextStyle(decoration: TextDecoration.lineThrough)
                              : null,
                        ),
                        subtitle: Text('${l.auteur} – ${l.annee}'),
                        value: l.lu,
                        onChanged: (v) async {
                          setState(() => l.lu = v ?? false);
                          await sauvegarderLivres(widget.livres);
                        },
                      ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
