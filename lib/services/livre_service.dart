import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:ma_biblio/models/livre.dart';

Future<File> _fichierSauvegarde() async {
  final dossier = await getApplicationDocumentsDirectory();
  return File('${dossier.path}/mabiblio.json');
}

Future<List<Livre>> chargerLivres() async {
  try {
    final fichier = await _fichierSauvegarde();
    if (await fichier.exists()) {
      final contenu = await fichier.readAsString();
      final List<dynamic> donnees = jsonDecode(contenu) as List<dynamic>;
      return donnees.map((e) => Livre.fromJson(e as Map<String, dynamic>)).toList();
    }
  } catch (e) {
    // Si le fichier est corrompu, on repart des donnees d'origine.
  }
  final contenu = await rootBundle.loadString('assets/livres.json');
  final List<dynamic> donnees = jsonDecode(contenu) as List<dynamic>;
  return donnees.map((e) => Livre.fromJson(e as Map<String, dynamic>)).toList();
}

Future<void> sauvegarderLivres(List<Livre> livres) async {
  final fichier = await _fichierSauvegarde();
  final donnees = livres.map((l) => l.toJson()).toList();
  await fichier.writeAsString(jsonEncode(donnees));
}

Future<void> reinitialiserLivres() async {
  final fichier = await _fichierSauvegarde();
  if (await fichier.exists()) {
    await fichier.delete();
  }
}
