-- TFT 제작 일지 · 참고 자료(PDF) 저장소 설정
-- Supabase 대시보드 → SQL Editor → New query 에 전체를 붙여 넣고 Run 하세요. 한 번만 실행하면 됩니다.

-- 1) 자료 목록을 기록 테이블에 저장할 수 있게 허용
alter table public.docs drop constraint if exists docs_col_check;
alter table public.docs add constraint docs_col_check check (col in ('runs', 'samples', 'records', 'refs'));

-- 2) PDF 보관함 만들기 (비공개, 파일당 50MB, PDF만)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('refs', 'refs', false, 52428800, array['application/pdf'])
on conflict (id) do update set public = false, file_size_limit = 52428800, allowed_mime_types = array['application/pdf'];

-- 3) 팀 비밀번호로 로그인한 사람만 보고, 올리고, 지울 수 있게 잠금
drop policy if exists "team read refs"   on storage.objects;
drop policy if exists "team upload refs" on storage.objects;
drop policy if exists "team update refs" on storage.objects;
drop policy if exists "team delete refs" on storage.objects;

create policy "team read refs"   on storage.objects for select to authenticated using (bucket_id = 'refs');
create policy "team upload refs" on storage.objects for insert to authenticated with check (bucket_id = 'refs');
create policy "team update refs" on storage.objects for update to authenticated using (bucket_id = 'refs');
create policy "team delete refs" on storage.objects for delete to authenticated using (bucket_id = 'refs');
