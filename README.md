# Centre de Formation SIB — Soritech Innov Business

Site vitrine responsive du Centre de Formation Soritech Innov Business.

**Slogan officiel :** INNOVER • DÉVELOPPER • CONNECTER

## Fonctionnalités présentes
- Site vitrine responsive avec navigation mobile.
- Catalogue de démonstration avec filtres et recherche par mot-clé.
- Formulaire de préinscription relié au projet Supabase SIB Gestion.
- Table Supabase `public.sib_formation_inquiries` avec Row Level Security (RLS) activée.
- Pages de confidentialité et mentions légales, favicon, page 404, `robots.txt` et sitemap.
- Workflow GitHub Actions prévu pour publication GitHub Pages.

## Pages
- `index.html` — site principal
- `confidentialite.html` — politique de confidentialité à valider
- `mentions-legales.html` — informations légales à compléter
- `404.html` — page d’erreur personnalisée
- `sitemap.xml` et `robots.txt` — référencement

## Publication
Le workflow `.github/workflows/pages.yml` prépare une publication GitHub Pages à chaque push sur `main`. L’activation du service Pages dans les paramètres du dépôt et la réussite du workflow doivent être vérifiées séparément.

URL attendue après activation : https://soriteh.github.io/sib-centre-formation/

## Supabase et sécurité
Le formulaire utilise le endpoint REST Supabase et une clé publishable destinée au navigateur. Il ne doit jamais contenir de clé `service_role` ou de secret serveur.

La table `sib_formation_inquiries` autorise l’insertion publique des champs de préinscription via une policy RLS. La lecture, la modification et la suppression publiques sont interdites. L’accès de l’équipe SIB aux demandes doit être configuré avec authentification et politiques spécifiques avant d’ajouter un tableau d’administration.

## Avant lancement public
1. Tester une préinscription réelle et confirmer qu’elle apparaît dans Supabase.
2. Créer un espace d’administration authentifié avec politiques d’accès dédiées.
3. Ajouter les coordonnées officielles, l’adresse, le responsable de publication et les informations d’immatriculation.
4. Confirmer les formations réellement ouvertes, les tarifs, les durées, les dates et les conditions.
5. Faire valider la politique de confidentialité et les mentions légales selon les règles applicables.
6. Ajouter une protection anti-spam adaptée (par exemple CAPTCHA et limitation de débit) et surveiller les soumissions abusives.
7. Vérifier le statut GitHub Actions et l’URL du site en ligne.

## Note
Le catalogue contient des exemples de formations et les informations commerciales ne sont pas encore confirmées. Le formulaire constitue une demande de contact, pas une inscription définitive. Les images de démonstration sont chargées depuis Unsplash et nécessitent Internet.
