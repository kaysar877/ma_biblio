import 'package:flutter/material.dart';

class Livre {
  final int id;
  String titre;
  String auteur;
  String genre;
  int annee;
  double note;
  Color couleur;
  bool nouveaute;
  bool lu;
  bool favori;

  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.annee,
    required this.note,
    required this.couleur,
    this.nouveaute = false,
    this.lu = false,
    this.favori = false,
  });

  factory Livre.fromJson(Map<String, dynamic> json) {
    String hex = (json['couleur'] as String).replaceAll('#', '');
    return Livre(
      id: json['id'] as int,
      titre: json['titre'] as String,
      auteur: json['auteur'] as String,
      genre: json['genre'] as String,
      annee: json['annee'] as int,
      note: (json['note'] as num).toDouble(),
      couleur: Color(int.parse('FF$hex', radix: 16)),
      nouveaute: json['nouveaute'] as bool? ?? false,
      lu: json['lu'] as bool? ?? false,
      favori: json['favori'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    String hex = couleur.value.toRadixString(16).substring(2).toUpperCase();
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'genre': genre,
      'annee': annee,
      'note': note,
      'couleur': '#$hex',
      'nouveaute': nouveaute,
      'lu': lu,
      'favori': favori,
    };
  }
}
