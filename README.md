<!--
Updates that need to be made:
1. 
-->

# PR-CYBR-FRONTEND-AGENT

## Overview

The **PR-CYBR-FRONTEND-AGENT** handles the development, optimization, and maintenance of user-facing interfaces across the PR-CYBR ecosystem. It ensures that all frontend components are intuitive, responsive, and aligned with the project's branding and functionality requirements.

## Key Features

- **UI/UX Optimization**: Develops visually appealing and user-friendly interfaces.
- **Responsive Design**: Ensures compatibility across devices and screen sizes.
- **Frontend Testing**: Implements unit and integration tests to maintain code quality.
- **Integration with Backend Services**: Seamlessly connects with APIs and backend services for dynamic content.
- **Customizable Components**: Provides reusable and customizable UI components for scalability.

## Getting Started

### Prerequisites

- **Git**: For cloning the repository.
- **Node.js and npm**: Required for running and building the application.
- **Docker**: Required for containerization and deployment.
- **Access to GitHub Actions**: For automated workflows.

### Local Setup

To set up the `PR-CYBR-FRONTEND-AGENT` locally on your machine:

1. **Clone the Repository**

```bash
git clone https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT.git
cd PR-CYBR-FRONTEND-AGENT
```

2. **Run Local Setup Script**

```bash
./scripts/local_setup.sh
```
_This script will install necessary dependencies and set up the local environment._

3. **Provision the Agent**

```bash
./scripts/provision_agent.sh
```
_This script configures the agent with default settings for local development._

### Cloud Deployment

To deploy the agent to a cloud environment:

1. **Configure Repository Secrets**

- Navigate to `Settings` > `Secrets and variables` > `Actions` in your GitHub repository.
- Add the required secrets:
   - `CLOUD_API_KEY`
   - `DOCKERHUB_USERNAME`
   - `DOCKERHUB_PASSWORD`
   - Any other cloud-specific credentials.

2. **Deploy Using GitHub Actions**

- The deployment workflow is defined in `.github/workflows/docker-compose.yml`.
- Push changes to the `main` branch to trigger the deployment workflow automatically.

3. **Manual Deployment**

- Use the deployment script for manual deployment:

```bash
./scripts/deploy_agent.sh
```

- Ensure you have Docker and cloud CLI tools installed and configured on your machine.

## Integration

The `PR-CYBR-FRONTEND-AGENT` integrates with other PR-CYBR agents to provide a seamless user experience. It communicates with the `PR-CYBR-BACKEND-AGENT` for data retrieval and submission, and interacts with the `PR-CYBR-USER-FEEDBACK-AGENT` to collect user feedback.

## Usage

- **Development**

  - Start the development server:

    ```bash
    python setup.py
    ```

  - Open your browser and navigate to `http://localhost:3000` to view the application.
  - Make changes to the source code in the `src/` directory; the app will reload automatically.

- **Testing**

  - Run unit and integration tests:

    ```bash
    python tests/*
    ```

- **Building for Production**

  - Create an optimized production build:

    ```bash
    python setup.py
    ```

  - The build artifacts will be stored in the `build/` directory.

## Documentation

- [Agent Dashboard Operations Guide](docs/dashboard.md): Detailed setup steps, available actions, environment configuration, screenshot guidance, and troubleshooting tips for the dashboard experience.

## License

This project is licensed under the **MIT License**. See the [`LICENSE`](LICENSE) file for details.

---

For more information, refer to the [React Documentation](https://reactjs.org/docs/getting-started.html) or contact the PR-CYBR team.
