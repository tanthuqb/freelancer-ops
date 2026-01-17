-- The pgcrypto extension is already created in the 'extensions' schema by migrations
-- ensure we can use it

do $$
declare
  owner_id uuid := '11111111-1111-1111-1111-111111111111';
  admin_id uuid := '22222222-2222-2222-2222-222222222222';
  member_id uuid := '33333333-3333-3333-3333-333333333333';
  client_id uuid := '44444444-4444-4444-4444-444444444444';
begin
  -- Cleanup
  delete from auth.identities where user_id in (owner_id, admin_id, member_id, client_id);
  delete from auth.users where id in (owner_id, admin_id, member_id, client_id);

  -- OWNER
  insert into auth.users (
    id, instance_id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at
  )
  values (
    owner_id,
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'owner@demo.com',
    extensions.crypt('123456', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{"full_name":"Demo Owner"}',
    now(), now()
  );

  insert into auth.identities (
    id, user_id, identity_data, provider, provider_id,
    last_sign_in_at, created_at, updated_at
  )
  values (
    owner_id, owner_id,
    format('{"sub":"%s","email":"owner@demo.com"}', owner_id)::jsonb,
    'email', owner_id,
    now(), now(), now()
  );

  -- ADMIN
  insert into auth.users (
    id, instance_id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at
  )
  values (
    admin_id,
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'admin@demo.com',
    extensions.crypt('123456', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{"full_name":"Demo Admin"}',
    now(), now()
  );

  insert into auth.identities (
    id, user_id, identity_data, provider, provider_id,
    last_sign_in_at, created_at, updated_at
  )
  values (
    admin_id, admin_id,
    format('{"sub":"%s","email":"admin@demo.com"}', admin_id)::jsonb,
    'email', admin_id,
    now(), now(), now()
  );

  -- MEMBER
  insert into auth.users (
    id, instance_id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at
  )
  values (
    member_id,
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'member@demo.com',
    extensions.crypt('123456', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{"full_name":"Demo Member"}',
    now(), now()
  );

  insert into auth.identities (
    id, user_id, identity_data, provider, provider_id,
    last_sign_in_at, created_at, updated_at
  )
  values (
    member_id, member_id,
    format('{"sub":"%s","email":"member@demo.com"}', member_id)::jsonb,
    'email', member_id,
    now(), now(), now()
  );

  -- CLIENT
  insert into auth.users (
    id, instance_id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at
  )
  values (
    client_id,
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'client@demo.com',
    extensions.crypt('123456', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{"full_name":"Demo Client"}',
    now(), now()
  );

  insert into auth.identities (
    id, user_id, identity_data, provider, provider_id,
    last_sign_in_at, created_at, updated_at
  )
  values (
    client_id, client_id,
    format('{"sub":"%s","email":"client@demo.com"}', client_id)::jsonb,
    'email', client_id,
    now(), now(), now()
  );

end $$;
