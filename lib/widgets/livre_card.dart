import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';

Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre.isNotEmpty ? livre.titre[0].toUpperCase() : '?',
        style: const TextStyle(color: Colors.white),
      ),
    ),
    title: Text(
      livre.titre,
      style: livre.lu
          ? const TextStyle(decoration: TextDecoration.lineThrough)
          : null,
    ),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(livre.note.toStringAsFixed(1)),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.amber),
      ],
    ),
  );
}

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: livreTile(livre),
      ),
    );
  }
}
