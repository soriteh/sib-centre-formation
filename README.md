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
- `admin.html` — espace d’administration privé (connexion par lien e-mail Supabase Auth)
- `supabase/admin_portal.sql` — migration pour le rôle administrateur, le catalogue en base et les politiques RLS
- `confidentialite.html` — politique de confidentialité à valider
- `mentions-legales.html` — informations légales à compléter
- `404.html` — page d’erreur personnalisée
- `sitemap.xml` et `robots.txt` — référencement

## Publication
Le workflow `.github/workflows/pages.yml` prépare une publication GitHub Pages à chaque push sur `main`. L’activation du service Pages dans les paramètres du dépôt et la réussite du workflow doivent être vérifiées séparément.

URL attendue après activation : https://soriteh.github.io/sib-centre-formation/

## Espace d’administration
Ouvrir `admin.html` sur le site publié, puis demander un lien de connexion à `sib.innovbuss@gmail.com`. Le mot de passe n’est pas stocké dans GitHub : Supabase Auth gère la connexion par lien e-mail. Si l’URL de retour est refusée, ajouter l’URL exacte de `admin.html` aux Redirect URLs de Supabase Auth. L’espace admin permet de consulter les préinscriptions et de gérer le catalogue stocké dans `sib_formation_courses`. **La modification du catalogue en base ne met pas encore automatiquement à jour les cartes statiques de la page publique** : cette synchronisation reste à développer.

## Supabase et sécurité
Le formulaire utilise le endpoint REST Supabase et une clé publishable destinée au navigateur. Il ne doit jamais contenir de clé `service_role` ou de secret serveur.

La table `sib_formation_inquiries` autorise l’insertion publique des champs de préinscription via une policy RLS. La lecture, la modification et la suppression publiques sont interdites. L’accès aux demandes est restreint aux utilisateurs authentifiés reconnus par `public.sib_is_site_admin()`. La migration crée aussi `sib_site_admins` et `sib_formation_courses` avec RLS. Les soumissions publiques ne disposent pas de lecture publique.

## Avant lancement public
1. Tester une préinscription réelle et confirmer qu’elle apparaît dans Supabase.
2. Vérifier l’espace d’administration `admin.html` en conditions réelles et effectuer un test de connexion complet.
3. Vérifier que l’adresse `sib.innovbuss@gmail.com` est confirmée dans Supabase Auth et que l’envoi des liens e-mail fonctionne. L’accès administrateur est limité à cette adresse et aux identifiants ajoutés explicitement dans `sib_site_admins`.
4. Confirmer les formations réellement ouvertes, les tarifs, les durées, les dates et les conditions.
5. Faire valider la politique de confidentialité et les mentions légales selon les règles applicables.
6. Ajouter une protection anti-spam adaptée (par exemple CAPTCHA et limitation de débit) et surveiller les soumissions abusives.
7. Vérifier le statut GitHub Actions et l’URL du site en ligne.

## Note
Le catalogue contient des exemples de formations et les informations commerciales ne sont pas encore confirmées. Le formulaire constitue une demande de contact, pas une inscription définitive. Les images de démonstration sont chargées depuis Unsplash et nécessitent Internet.
