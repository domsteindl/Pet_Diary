create table if not exists pet_appointments (
  id bigserial primary key,
  pet_id bigint references pets(id),
  date timestamp not null,
  description text not null,
  type text not null
);

alter table pet_appointments enable row level security;

-- Pet Appointments Policies
create policy "Users can read appointments of their pets"
  on pet_appointments for select using (
    exists (
      select 1 from pets
      where pets.id = pet_appointments.pet_id
        and pets.user_id = auth.uid()
    )
  );

create policy "Users can insert appointments for their pets"
  on pet_appointments for insert with check (
    exists (
      select 1 from pets
      where pets.id = pet_appointments.pet_id
        and pets.user_id = auth.uid()
    )
  );

create policy "Users can update appointments of their pets"
  on pet_appointments for update using (
    exists (
      select 1 from pets
      where pets.id = pet_appointments.pet_id
        and pets.user_id = auth.uid()
    )
  );

create policy "Users can delete appointments of their pets"
  on pet_appointments for delete using (
    exists (
      select 1 from pets
      where pets.id = pet_appointments.pet_id
        and pets.user_id = auth.uid()
    )
  );