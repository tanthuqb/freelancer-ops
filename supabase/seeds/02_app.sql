do $$
declare
  v_owner_id uuid := '11111111-1111-1111-1111-111111111111';
  v_admin_id uuid := '22222222-2222-2222-2222-222222222222';
  v_member_id uuid := '33333333-3333-3333-3333-333333333333';
  v_client_id uuid := '44444444-4444-4444-4444-444444444444';
  
  v_workspace_id uuid := 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
  v_project_id uuid := 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';
begin
    -- Cleanup app tables
    delete from public.task_comments where workspace_id = v_workspace_id;
    delete from public.tasks where workspace_id = v_workspace_id;
    delete from public.projects where workspace_id = v_workspace_id;
    delete from public.workspace_members where workspace_id = v_workspace_id;
    delete from public.workspaces where id = v_workspace_id;

    -- 1. Create Workspace
    -- Trigger will add v_owner_id as 'owner' in workspace_members
    insert into public.workspaces (id, name, owner_id)
    values (v_workspace_id, 'Demo Workspace', v_owner_id);

    -- 2. Add other members
    insert into public.workspace_members (workspace_id, user_id, role)
    values 
        (v_workspace_id, v_admin_id, 'admin'),
        (v_workspace_id, v_member_id, 'member'),
        (v_workspace_id, v_client_id, 'client');

    -- 3. Create Project
    insert into public.projects (id, workspace_id, name, status, created_by)
    values (v_project_id, v_workspace_id, 'Web Redesign', 'active', v_owner_id);

    -- 4. Create Tasks
    insert into public.tasks (workspace_id, project_id, title, description, status, priority, assignee_id, created_by)
    values
        (v_workspace_id, v_project_id, 'Design System', 'Create a unified design system', 'doing', 5, v_admin_id, v_owner_id),
        (v_workspace_id, v_project_id, 'Homepage Layout', 'Implement responsive homepage', 'todo', 4, v_member_id, v_admin_id),
        (v_workspace_id, v_project_id, 'Client Review', 'Gather feedback', 'todo', 3, v_client_id, v_owner_id);

    -- 5. Create Comments
    insert into public.task_comments (workspace_id, task_id, author_id, body)
    select v_workspace_id, id, v_owner_id, 'Let''s get this started!'
    from public.tasks 
    where title = 'Design System';

end $$;
