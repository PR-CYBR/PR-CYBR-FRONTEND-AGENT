# Agent Dashboard Operations Guide

The agent dashboard provides a single point of control for running, testing, and documenting the PR-CYBR frontend. Use this guide to prepare your local environment, understand the supported workflows, manage configuration, and resolve common issues quickly.

## 1. Setup Checklist

### Prerequisites
- **Git** for cloning and syncing the repository.
- **Python 3.10+** with `pip` for executing the helper scripts.
- **Node.js 18+ and npm** for installing frontend dependencies.
- **Docker** (optional) when you need to validate containerized builds.

### Install Dependencies
1. Clone the repository and move into the project directory:
   ```bash
   git clone https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT.git
   cd PR-CYBR-FRONTEND-AGENT
   ```
2. Run the local setup script to install Python dependencies and bootstrap tooling:
   ```bash
   ./scripts/local_setup.sh
   ```
3. Provision the agent defaults, including sample configuration and helper data:
   ```bash
   ./scripts/provision_agent.sh
   ```
4. Start the development server to verify the dashboard loads:
   ```bash
   python setup.py
   ```
   Then open `http://localhost:3000` in your browser to view the dashboard.

### Optional: Container Build
- Build the dashboard image: `docker build -t pr-cybr-dashboard .`
- Run it locally: `docker run -p 8080:80 pr-cybr-dashboard`

## 2. Available Actions

| Action | Description | Command |
| --- | --- | --- |
| Install dependencies | Installs Python requirements and prepares local tooling. | `./scripts/local_setup.sh` |
| Provision defaults | Seeds configuration for a predictable development environment. | `./scripts/provision_agent.sh` |
| Start development server | Runs the dashboard locally with hot reload. | `python setup.py` |
| Run test suite | Executes automated checks located in `tests/`. | `pytest` |
| Build production bundle | Generates optimized assets in the `build/` directory. | `python setup.py` (with production flags when configured) |
| Build Docker image | Validates container delivery artifacts. | `docker build -t pr-cybr-dashboard .` |

> **Tip:** Use `npm install` and `npm run build` if you are working directly within the JavaScript toolchain instead of the Python wrapper scripts.

## 3. Environment Variables

Configure environment variables in a `.env` file at the repository root or inject them into your shell before running scripts.

| Variable | Purpose |
| --- | --- |
| `CLOUD_API_KEY` | Authenticates dashboard calls to PR-CYBR cloud services. |
| `DOCKERHUB_USERNAME` / `DOCKERHUB_PASSWORD` | Required for publishing container images from CI/CD. |
| `MAPBOX_TOKEN` | Powers map layers inside the interactive dashboard views. |
| `OPENAI_API_KEY` | Enables conversational agent features in the chat interface. |
| `SENTRY_DSN` (optional) | Captures runtime errors for observability. |

**Security guidance:**
- Never commit `.env` files. Add sensitive keys using GitHub Actions secrets for automated workflows.
- Rotate tokens when teammates change or when exposed in logs.

## 4. Screenshot Capture & Embedding

1. **Prepare the scene**
   - Start the development server and navigate to the dashboard view you want to capture.
   - Resize the browser window to the desired dimensions (desktop and mobile breakpoints are both valuable).
2. **Capture the screenshot**
   - Use your OS screenshot tool or Playwright automation to capture the visible area.
   - Save the image inside `docs/images/` using a descriptive filename, for example `docs/images/dashboard-overview.png`.
3. **Optimize (optional)**
   - Compress large PNG files or convert to WebP/JPEG to keep repository size manageable.
4. **Embed in documentation**
   - Reference the image with Markdown syntax:
     ```markdown
     ![Dashboard overview](images/dashboard-overview.png)
     ```
   - When linking from `docs/dashboard.md`, use a relative path (`images/...`). For files outside the `docs/` directory, prefix with `docs/images/...` as needed.
5. **Version control**
   - Add both the updated Markdown file and the new image asset to your commit: `git add docs/dashboard.md docs/images/dashboard-overview.png`.

## 5. Troubleshooting

| Symptom | Resolution |
| --- | --- |
| Dashboard page is blank | Ensure the development server is running and accessible at `http://localhost:3000`. Check browser console for JavaScript errors. |
| Map tiles not loading | Confirm `MAPBOX_TOKEN` is defined and valid. Refresh tokens or inspect network calls for 401 errors. |
| API requests failing | Verify `OPENAI_API_KEY` and `CLOUD_API_KEY` are present. Inspect proxy/firewall settings blocking outbound requests. |
| Docker build fails | Clear old layers with `docker system prune` and rerun the build. Make sure Docker Desktop/daemon is active. |
| Tests fail intermittently | Reinstall dependencies (`./scripts/local_setup.sh`) and clear caches (`rm -rf node_modules build`). |

## 6. Additional Resources
- [Agent Actions Overview](agent-actions.md)
- [Agent Dashboard Architecture](agent-dashboard.md)
- [Agent Database Reference](agent-database.md)
- Project-wide onboarding: `README.md`

Maintain this guide alongside feature updates to keep dashboard onboarding fast and reliable.
