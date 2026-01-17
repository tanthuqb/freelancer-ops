# Freelancer Ops Platform

Freelancer Ops is a comprehensive platform designed to streamline freelancer operations, including project management, task tracking, and team collaboration. It is built on top of Supabase for a robust backend and real-time capabilities.

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) (Must be running)
- [Supabase CLI](https://supabase.com/docs/guides/cli/getting-started) (`npm install -g supabase`)

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone <repository_url>
   cd freelancer-ops
   ```

2. **Start the local Supabase stack**
   This command will start the full Supabase local development environment, including database, auth, storage, and edge functions.

   ```bash
   supabase start
   ```

3. **Reset and Seed Data (Optional)**
   If you want to reset the database and load the demo seed data (users, projects, tasks):
   ```bash
   supabase db reset
   ```
   _Note: `supabase start` already applies migrations and seeds on first run._

---

## 🔐 Demo Accounts

The system comes pre-configured with the following demo accounts for testing different roles and permissions:

| Role       | Email             | Password | Permissions                                                        |
| ---------- | ----------------- | -------- | ------------------------------------------------------------------ |
| **Owner**  | `owner@demo.com`  | `123456` | Full access to Workspace, Billing, and Member Management.          |
| **Admin**  | `admin@demo.com`  | `123456` | Can manage Projects, Tasks, and Members (cannot delete Workspace). |
| **Member** | `member@demo.com` | `123456` | Can view and edit assigned Tasks and Projects.                     |
| **Client** | `client@demo.com` | `123456` | Restricted view access to specific Projects/Tasks.                 |

---

## 🛠️ Features

### Support CLI Seed (v1.0)

The current version supports fully automated database seeding for a quick start development environment.

**Key capabilities:**

- **Automated Auth Seeding**: Pre-creates 4 distinct user roles (Owner, Admin, Member, Client) with consistent UUIDs for testing.
- **Relational Data Populating**: Automatically generates a complete hierarchy of data:
  - **Workspace**: Creates a "Demo Workspace".
  - **Members**: Links all seeded users to the workspace with correct roles.
  - **Projects**: Creates a sample "Web Redesign" project.
  - **Tasks**: Populates tasks with different statuses (ToDo, Doing) and assignees.
  - **Comments**: Adds sample comments to task for testing real-time features.
- **Cloud Sync**: Seed data can be pushed to remote Supabase projects for staging/demo environments using `supabase db reset --linked`.

---

## 📂 Project Structure

```
freelancer-ops/
├── supabase/
│   ├── migrations/      # Database schema changes
│   ├── seeds/           # Seed data files
│   │   ├── 01_auth.sql  # Creates demo users
│   │   └── 02_app.sql   # Creates app data (workspaces, projects, tasks)
│   └── config.toml      # Local Supabase configuration
└── ...
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
