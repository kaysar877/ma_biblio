import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/services/livre_service.dart';
import 'package:ma_biblio/screens/catalogue_screen.dart';
import 'package:ma_biblio/screens/galerie_screen.dart';
import 'package:ma_biblio/screens/ma_liste_screen.dart';
import 'package:ma_biblio/screens/parametres_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Livre>> _futurLivres;
  int _index = 0;
  List<Livre>? _livres;

  @override
  void initState() {
    super.initState();
    _futurLivres = chargerLivres();
  }

  void _recharger() {
    setState(() {
      _futurLivres = chargerLivres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        _livres = snapshot.data!;
        final screens = [
          CatalogueScreen(livres: _livres!),
          GalerieScreen(livres: _livres!),
          MaListeScreen(livres: _livres!),
        ];
        return Scaffold(
          appBar: AppBar(
            title: const Text('MaBiblio'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ParametresScreen(
                        livres: _livres!,
                        onReset: _recharger,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: screens[_index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catalogue'),
              BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Galerie'),
              BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Ma liste'),
            ],
          ),
        );
      },
    );
  }
}
