create table if not exists public.gsat_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('gsat-v1','gsat_mock_history_v2','gsat_mock_errors_v2')),
  payload jsonb not null,
  primary key (user_id, kind)
);
alter table public.gsat_progress enable row level security;
revoke all on public.gsat_progress from anon;
grant select, insert, update on public.gsat_progress to authenticated;
create policy "read own progress" on public.gsat_progress for select to authenticated using ((select auth.uid())=user_id);
create policy "insert own progress" on public.gsat_progress for insert to authenticated with check ((select auth.uid())=user_id);
create policy "update own progress" on public.gsat_progress for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
