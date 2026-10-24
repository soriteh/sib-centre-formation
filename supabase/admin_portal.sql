-- Secure administration for SIB Centre Formation
create table if not exists public.sib_site_admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
alter table public.sib_site_admins enable row level security;
revoke all on public.sib_site_admins from anon, authenticated;
grant select on public.sib_site_admins to authenticated;

create or replace function public.sib_is_site_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select
    lower(coalesce(auth.jwt() ->> 'email', '')) = 'sib.innovbuss@gmail.com'
    or exists (
      select 1 from public.sib_site_admins a
      where a.user_id = (select auth.uid())
    );
$$;
revoke all on function public.sib_is_site_admin() from public, anon;
grant execute on function public.sib_is_site_admin() to authenticated;

create table if not exists public.sib_formation_courses (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(btrim(title)) between 2 and 160),
  category text not null check (char_length(btrim(category)) between 2 and 80),
  level text not null default 'Tous niveaux' check (char_length(level) <= 80),
  description text not null check (char_length(btrim(description)) between 2 and 1200),
  duration text not null default 'À définir' check (char_length(duration) <= 100),
  price text not null default 'Sur demande' check (char_length(price) <= 100),
  published boolean not null default false,
  sort_order integer not null default 100,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.sib_formation_courses enable row level security;
revoke all on public.sib_formation_courses from anon, authenticated;
grant select on public.sib_formation_courses to anon, authenticated;
grant insert, update, delete on public.sib_formation_courses to authenticated;
drop policy if exists "Public can read published formation courses" on public.sib_formation_courses;
create policy "Public can read published formation courses"
on public.sib_formation_courses for select to anon, authenticated
using (published = true or (select public.sib_is_site_admin()));
drop policy if exists "Admins can insert formation courses" on public.sib_formation_courses;
create policy "Admins can insert formation courses"
on public.sib_formation_courses for insert to authenticated
with check ((select public.sib_is_site_admin()));
drop policy if exists "Admins can update formation courses" on public.sib_formation_courses;
create policy "Admins can update formation courses"
on public.sib_formation_courses for update to authenticated
using ((select public.sib_is_site_admin()))
with check ((select public.sib_is_site_admin()));
drop policy if exists "Admins can delete formation courses" on public.sib_formation_courses;
create policy "Admins can delete formation courses"
on public.sib_formation_courses for delete to authenticated
using ((select public.sib_is_site_admin()));

drop policy if exists "Admins can read formation inquiries" on public.sib_formation_inquiries;
create policy "Admins can read formation inquiries"
on public.sib_formation_inquiries for select to authenticated
using ((select public.sib_is_site_admin()));
drop policy if exists "Admins can update formation inquiries" on public.sib_formation_inquiries;
create policy "Admins can update formation inquiries"
on public.sib_formation_inquiries for update to authenticated
using ((select public.sib_is_site_admin()))
with check ((select public.sib_is_site_admin()));
drop policy if exists "Admins can delete formation inquiries" on public.sib_formation_inquiries;
create policy "Admins can delete formation inquiries"
on public.sib_formation_inquiries for delete to authenticated
using ((select public.sib_is_site_admin()));

-- Seed initial admin only if this email already exists in Supabase Auth.
insert into public.sib_site_admins(user_id)
select id from auth.users where lower(email) = 'sib.innovbuss@gmail.com'
on conflict (user_id) do nothing;

-- SQL privileges are required in addition to RLS policies.
grant select, update, delete on public.sib_formation_inquiries to authenticated;
grant select, insert, update, delete on public.sib_formation_courses to authenticated;
