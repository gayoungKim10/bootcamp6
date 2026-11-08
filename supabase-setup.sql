-- TFT 제작 일지 · Supabase 초기 설정
-- Supabase 대시보드 → SQL Editor → New query 에 전체를 붙여 넣고 Run 하세요. 한 번만 실행하면 됩니다.

-- 1) 기록 저장 테이블 (차수 runs / 샘플 samples / 공정 기록 records 를 한 테이블에 보관)
create table if not exists public.docs (
  col text not null check (col in ('runs', 'samples', 'records')),
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (col, id)
);

-- 2) 팀 비밀번호로 로그인한 사람만 읽고 쓸 수 있게 잠금
alter table public.docs enable row level security;

drop policy if exists "team read" on public.docs;
drop policy if exists "team insert" on public.docs;
drop policy if exists "team update" on public.docs;
drop policy if exists "team delete" on public.docs;

create policy "team read"   on public.docs for select to authenticated using (true);
create policy "team insert" on public.docs for insert to authenticated with check (true);
create policy "team update" on public.docs for update to authenticated using (true) with check (true);
create policy "team delete" on public.docs for delete to authenticated using (true);

-- 3) 다른 조원이 저장하면 바로 화면에 보이도록 실시간 전송 켜기
do $$
begin
  alter publication supabase_realtime add table public.docs;
exception when duplicate_object then null;
end $$;
