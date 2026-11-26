-- 기존 테이블, 데이터 및 RLS 정책 유지. Supabase SQL Editor에서 먼저 실행.
begin;
alter table public.gsat_progress drop constraint if exists gsat_progress_kind_check;
alter table public.gsat_progress add constraint gsat_progress_kind_check check (kind in ('gsat-v1','gsat_mock_history_v2','gsat_mock_errors_v2','gsat_notes_v360'));
commit;
