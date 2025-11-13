-- Tabelle pets
create table if not exists pets (
  id bigserial primary key,
  user_id uuid references auth.users(id),
  name text not null,
  species text not null,       -- Dog / Cat
  age int not null,
  weight numeric default 1.0,
  image_url text not null,
  description text default 'Keine Beschreibung vorhanden'
);

-- RLS aktivieren
alter table pets enable row level security;

-- Policies
create policy "Users can read their own pets"
  on pets for select using (auth.uid() = user_id);

create policy "Users can insert pets"
  on pets for insert with check (auth.uid() = user_id);

create policy "Users can update their own pets"
  on pets for update using (auth.uid() = user_id);

create policy "Users can delete their own pets"
  on pets for delete using (auth.uid() = user_id);

