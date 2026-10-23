import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/services/livre_service.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;
  final List<Livre> livres;
  const DetailScreen({super.key, required this.livre, required this.livres});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l = widget.livre;
    return Scaffold(
      appBar: AppBar(title: Text(l.titre)),
      body: Card(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: 200,
              color: l.couleur,
              alignment: Alignment.center,
              child: Text(
                l.titre,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(leading: const Icon(Icons.person), title: Text(l.auteur)),
            ListTile(leading: const Icon(Icons.calendar_today), title: Text('${l.annee}')),
            ListTile(leading: const Icon(Icons.category), title: Text(l.genre)),
            OverflowBar(
              children: [
                TextButton.icon(
                  icon: Icon(l.favori ? Icons.favorite : Icons.favorite_border),
                  label: const Text('Ajouter aux favoris'),
                  onPressed: () async {
                    setState(() => l.favori = !l.favori);
                    await sauvegarderLivres(widget.livres);
                  },
                ),
                TextButton.icon(
                  icon: Icon(l.lu ? Icons.check_box : Icons.check_box_outline_blank),
                  label: const Text('Marquer comme lu'),
                  onPressed: () async {
                    setState(() => l.lu = !l.lu);
                    await sauvegarderLivres(widget.livres);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
