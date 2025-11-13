create table if not exists diary_entries (
  id bigserial primary key,
  pet_id bigint references pets(id),
  date timestamp not null,
  type text not null,
  description text,
  note text,
  custom_fields jsonb
);

alter table diary_entries enable row level security;

create policy "Users can read diary entries of their pets"
  on diary_entries for select using (
    exists (select 1 from pets where pets.id = diary_entries.pet_id and pets.user_id = auth.uid())
  );

create policy "Users can insert diary entries for their pets"
  on diary_entries for insert with check (
    exists (select 1 from pets where pets.id = diary_entries.pet_id and pets.user_id = auth.uid())
  );

-- UPDATE
create policy "Users can update diary entries of their pets"
  on diary_entries
  for update
  using (
    exists (
      select 1 from pets
      where pets.id = diary_entries.pet_id
        and pets.user_id = auth.uid()
    )
  );

-- DELETE
create policy "Users can delete diary entries of their pets"
  on diary_entries
  for delete
  using (
    exists (
      select 1 from pets
      where pets.id = diary_entries.pet_id
        and pets.user_id = auth.uid()
    )
  );