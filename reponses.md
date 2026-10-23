# Réponses techniques — MaBiblio

## Phase 01–02 : Listes et layouts
- `ListTile` affiche un livre avec leading (avatar), title, subtitle et trailing (note).
- `ListView.separated` ajoute un séparateur entre chaque élément.
- `Expanded` dans une `Column` donne une hauteur bornée à la liste verticale.

## Phase 03–04 : Interaction et détail
- Les filtres utilisent `setState` pour mettre à jour l'affichage.
- Le compteur de l'AppBar montre le nombre de livres lus.

## Phase 05–06 : Grilles et responsive
- `GridView.builder` avec `MediaQuery` adapte le nombre de colonnes (2/3/4).

## Phase 07 : Persistance JSON
- `fromJson`/`toJson` convertissent un `Livre` en Map JSON.
- `LivreService` charge depuis les assets puis sauvegarde dans un fichier local avec `path_provider`.
- `FutureBuilder` gère l'état de chargement/erreur.

## Phase 08–10 : Finalisation
- `BottomNavigationBar` navigue entre Catalogue, Galerie et Ma liste.
- Le bouton Réinitialiser supprime le fichier local et recharge les données d'origine.
" filePath">
C:\Users\DELL\Desktop\tp application mobile\ma_biblio\reponses.md