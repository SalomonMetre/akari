# Application de Jeu Akari

Akari, également connu sous le nom de Light Up, est un jeu de puzzle logique où les joueurs placent des ampoules dans une grille pour illuminer toutes les cellules tout en suivant des règles spécifiques. Cette application offre une version numérique du jeu avec diverses fonctionnalités, y compris des modes solo et multijoueur (fonctionalité en cours de développement).

## Table des Matières

- [Fonctionnalités](#fonctionnalités)
- [Structure du Projet](#structure-du-projet)
- [Commencer](#commencer)
- [Dépendances](#dépendances)
- [Contribuer](#contribuer)
- [Licence](#licence)

## Fonctionnalités

- **Mode Solo** : Jouez au jeu classique Akari avec différents niveaux de difficulté.
- **Mode Multijoueur** : Affrontez des amis ou d'autres joueurs en ligne.
- **Classement** : Suivez vos progrès et comparez vos scores avec ceux des autres joueurs.
- **Authentification Utilisateur** : Inscrivez-vous et connectez-vous pour sauvegarder vos progrès et accéder aux fonctionnalités multijoueur.
- **Interface Responsive** : Profitez d'une expérience fluide sur les appareils mobiles et de bureau.

## Structure du Projet

```
.
├── constants
│   ├── app_colors.dart        # Définit les schémas de couleurs utilisés dans l'application
│   ├── asset_names.dart       # Noms des ressources pour les images et icônes
│   ├── debug_settings.dart    # Paramètres de débogage
│   ├── fonts.dart             # Styles de polices utilisés dans l'application
│   ├── numericals.dart        # Constantes numériques
│   ├── route_names.dart       # Noms des routes pour la navigation
│   ├── route_paths.dart       # Définitions des chemins de routage
│   └── texts.dart             # Textes constants utilisés dans l'application
├── firebase_options.dart       # Configuration de Firebase
├── functions
│   ├── cell_functions.dart    # Fonctions liées aux opérations sur les cellules
│   ├── grid_functions.dart    # Fonctions liées aux opérations sur la grille
│   ├── routing.dart           # Utilitaires de routage
│   └── utilities.dart         # Fonctions utilitaires générales
├── images
│   ├── akari_bg.jpeg          # Image de fond
│   ├── akari_bg.png           # Image de fond alternative
│   ├── bg1.jpg                # Autre image de fond
│   └── logo.png               # Logo de l'application
├── main.dart                   # Point d'entrée principal de l'application
├── models
│   ├── auth_model.dart        # Modèle d'authentification utilisateur
│   ├── db_model.dart          # Modèle de base de données
│   └── leaderboard_entry.dart # Modèle d'entrée de classement
├── multiplayer
│   ├── client.dart            # Logique du client multijoueur
│   └── server.dart            # Logique du serveur multijoueur
├── routes
│   └── routes.dart            # Définitions des routes
└── screens
    ├── game_page.dart         # Écran de jeu
    ├── home_page.dart         # Écran d'accueil
    ├── intro_page.dart        # Écran d'introduction
    ├── leaderboard.dart       # Écran de classement
    ├── level_page.dart        # Écran de sélection des niveaux
    ├── menu_page.dart         # Écran de menu
    ├── multiplayer_game_page.dart # Écran de jeu multijoueur
    ├── multiplayer_page.dart  # Écran de mode multijoueur
    ├── signin_page.dart       # Écran de connexion
    ├── signup_page.dart       # Écran d'inscription
    └── start_page.dart        # Écran de démarrage
```

## Commencer

Pour obtenir une copie locale et la faire fonctionner, suivez ces étapes simples :

### Prérequis

- SDK Flutter
- SDK Dart

### Installation

1. Clonez le dépôt
   ```sh
   git clone https://github.com/SalomonMetre/akari.git
   ```
2. Naviguez vers le répertoire du projet
   ```sh
   cd akari_game
   ```
3. Installez les dépendances
   ```sh
   flutter pub get
   ```
4. Configurez Firebase
   - Suivez les instructions dans `firebase_options.dart` pour configurer Firebase pour votre projet.

### Exécuter l'Application

Pour exécuter l'application, utilisez la commande suivante :

```sh
flutter run
```

## Dépendances

- Flutter
- Dart
- Firebase
- Autres packages (à retrouver dans le fichier .yaml)

## Contribuer

Les contributions sont ce qui rend la communauté open source un endroit incroyable inspirer et créer. Toute contribution que vous faites est **grandement appréciée**.

1. Forkez le projet
2. Créez votre branche de fonctionnalité (`git checkout -b feature/votre-fonctionnalité`)
3. Commitez vos modifications (`git commit -m 'Ajouter ma fonctionnalité'`)
4. Pushez vers la branche (`git push origin feature/votre-fonctionalité`)
5. Ouvrez une Pull Request

## Licence

Distribué sous la licence MIT. Voir `LICENSE` pour plus d'informations.