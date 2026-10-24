# Centre de Formation SIB — Soritech Innov Business

Site vitrine responsive pour le Centre de Formation Soritech Innov Business (SIB).

**Slogan :** INNOVER • DÉVELOPPER • CONNECTER

## Contenu
- Présentation du centre et de son approche pédagogique
- Catalogue de démonstration avec filtres par domaine
- Formulaire de préinscription
- FAQ, contact et navigation responsive
- Panneau local de démonstration avec export CSV des demandes stockées dans le navigateur

## Lancer le site
Le site est statique : ouvrez `index.html` dans un navigateur ou déployez ce dépôt avec GitHub Pages ou un hébergeur statique.

## Avant la mise en production
1. Remplacer les coordonnées provisoires par le téléphone, l'e-mail et l'adresse officiels du centre.
2. Confirmer les formations, les tarifs, les durées et les dates de session.
3. Connecter le formulaire à un backend (par exemple Supabase avec politiques RLS) pour enregistrer les demandes de façon centralisée.
4. Mettre en place une authentification robuste avant d'ajouter un espace administrateur.
5. Ajouter les mentions légales et la politique de confidentialité applicables.

## Important sur les données
Le formulaire de cette première version conserve les demandes uniquement dans le `localStorage` du navigateur. Les demandes ne sont pas transmises à SIB et le panneau d'administration local n'est pas sécurisé. Ne l'utilisez pas pour collecter des données réelles avant intégration d'un backend et de contrôles d'accès.

Les images de démonstration sont chargées depuis Unsplash et nécessitent une connexion Internet.
