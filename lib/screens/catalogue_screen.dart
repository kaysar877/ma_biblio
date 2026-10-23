import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/screens/detail_screen.dart';
import 'package:ma_biblio/widgets/livre_card.dart';

class CatalogueScreen extends StatefulWidget {
  final List<Livre> livres;
  const CatalogueScreen({super.key, required this.livres});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    final nouveautes = widget.livres.where((l) => l.nouveaute).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Nouveautés', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          // Liste horizontale des nouveautes, hauteur fixe 160
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, i) {
                final l = nouveautes[i];
                return Container(
                  width: 110,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: l.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        l.titre,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Tout le catalogue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          // Expanded donne une hauteur bornee a la ListView verticale dans la Column
          Expanded(
            child: ListView.separated(
              itemCount: widget.livres.length,
              separatorBuilder: (context, index) => const Divider(indent: 72),
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
          ),
        ],
      ),
    );
  }
}
