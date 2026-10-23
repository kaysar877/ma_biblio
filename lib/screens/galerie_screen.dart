import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/widgets/livre_grid_item.dart';
import 'package:ma_biblio/widgets/livre_card.dart';
import 'package:ma_biblio/screens/detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;
  const GalerieScreen({super.key, required this.livres});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _grille = true;

  int _colonnes(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return 2;
    if (w < 900) return 3;
    return 4;
  }

  void _trierParNote() {
    setState(() {
      widget.livres.sort((a, b) => b.note.compareTo(a.note));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            icon: Icon(_grille ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _grille = !_grille),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _trierParNote,
          ),
        ],
      ),
      body: _grille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _colonnes(context),
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: widget.livres.length,
              itemBuilder: (context, i) {
                final l = widget.livres[i];
                return LivreGridItem(
                  livre: l,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(livre: l, livres: widget.livres)),
                    );
                    setState(() {});
                  },
                );
              },
            )
          : ListView.builder(
              itemCount: widget.livres.length,
              itemBuilder: (context, i) {
                final l = widget.livres[i];
                return LivreCard(
                  livre: l,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(livre: l, livres: widget.livres)),
                    );
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
