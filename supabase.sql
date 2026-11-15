-- Run once in Supabase: SQL Editor > New query > paste > Run (safe to re-run)

create table if not exists folders (
  id text primary key,
  name text not null,
  vote_limit int not null default 100,
  round int not null default 0,
  created_at timestamptz default now()
);

create table if not exists options (
  id text primary key,
  folder_id text not null references folders(id) on delete cascade,
  name text not null,
  photo_url text,
  total int not null default 0,
  created_at timestamptz default now()
);

alter table folders enable row level security;
alter table options enable row level security;

drop policy if exists "folders all" on folders;
drop policy if exists "options all" on options;
create policy "folders all" on folders for all using (true) with check (true);
create policy "options all" on options for all using (true) with check (true);

-- atomic vote counting (safe when many people vote at once)
create or replace function add_votes(votes jsonb) returns void
language plpgsql as $$
declare k text; v int;
begin
  for k in select jsonb_object_keys(votes) loop
    v := (votes->>k)::int;
    if v > 0 and v <= 1000 then
      update options set total = total + v where id = k;
    end if;
  end loop;
end $$;
grant execute on function add_votes(jsonb) to anon;

-- public bucket for contestant photos
insert into storage.buckets (id, name, public) values ('photos', 'photos', true)
on conflict (id) do nothing;

drop policy if exists "photos read" on storage.objects;
drop policy if exists "photos insert" on storage.objects;
drop policy if exists "photos update" on storage.objects;
drop policy if exists "photos delete" on storage.objects;
create policy "photos read" on storage.objects for select using (bucket_id = 'photos');
create policy "photos insert" on storage.objects for insert with check (bucket_id = 'photos');
create policy "photos update" on storage.objects for update using (bucket_id = 'photos');
create policy "photos delete" on storage.objects for delete using (bucket_id = 'photos');
