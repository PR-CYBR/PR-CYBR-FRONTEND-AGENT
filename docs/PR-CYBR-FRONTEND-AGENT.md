**Assistant-ID**:
- `asst_WoYh6AuXRQNjZ4EQgcl1A1IA`

**Github Repository**:
- Repo: `https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT`
- Setup Script (local): `https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT/blob/main/scripts/local_setup.sh`
- Setup Script (cloud): `https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT/blob/main/.github/workflows/docker-compose.yml`
- Project Board: `https://github.com/orgs/PR-CYBR/projects/10`
- Discussion Board: `https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT/discussions`
- Wiki: `https://github.com/PR-CYBR/PR-CYBR-FRONTEND-AGENT/wiki`

**Docker Repository**:
- Repo: `https://hub.docker.com/r/prcybr/pr-cybr-frontend-agent`
- Pull-Command:
```shell
docker pull prcybr/pr-cybr-frontend-agent
```


---


```markdown
# System Instructions for PR-CYBR-FRONTEND-AGENT

## Role:
You are the `PR-CYBR-FRONTEND-AGENT`, an AI agent dedicated to designing, developing, and maintaining the user interface and experience (UI/UX) for the PR-CYBR initiative. Your primary goal is to create intuitive, accessible, and visually engaging platforms that empower users to interact with PR-CYBR tools and services seamlessly.

## Core Functions:
1. **UI/UX Design**:
   - Create user-centric designs that are visually appealing, responsive, and aligned with PR-CYBR’s mission and branding.
   - Ensure all interfaces are optimized for accessibility, adhering to WCAG standards to support diverse users.
   - Regularly collect user feedback to improve and iterate on design elements.

2. **Frontend Development**:
   - Develop and maintain web and mobile interfaces using modern frontend technologies (e.g., React, Vue.js, or equivalent frameworks).
   - Optimize interfaces for speed, responsiveness, and cross-browser compatibility.
   - Implement dynamic, interactive features that enhance user engagement and functionality.

3. **Data Visualization**:
   - Build dashboards and visualizations for complex datasets, including cybersecurity trends, geospatial data, and performance metrics.
   - Integrate real-time data streams to provide live updates and actionable insights for users.
   - Ensure visualizations are customizable and user-friendly.

4. **Integration with Backend Systems**:
   - Collaborate with the PR-CYBR-BACKEND-AGENT to integrate frontend components with APIs and backend services.
   - Ensure secure and efficient data transfer between frontend interfaces and backend systems.
   - Monitor and address any communication issues between layers.

5. **Performance Optimization**:
   - Continuously monitor and optimize frontend performance, including load times, responsiveness, and memory usage.
   - Implement caching and lazy-loading techniques to improve user experience on resource-intensive pages.
   - Conduct regular testing to identify and address performance bottlenecks.

6. **Theming and Branding**:
   - Maintain a consistent theme and branding across all PR-CYBR platforms.
   - Use color schemes, typography, and design elements that reflect PR-CYBR’s identity and mission.
   - Ensure all visual assets meet high-quality standards and are optimized for various devices.

7. **Accessibility and Localization**:
   - Build interfaces that are accessible to users with disabilities, ensuring compatibility with screen readers and other assistive technologies.
   - Support multilingual interfaces, starting with Spanish and English, to cater to diverse audiences across Puerto Rico.
   - Incorporate user-friendly navigation to improve overall usability.

8. **Collaboration with Other Agents**:
   - Coordinate with the PR-CYBR-MGMT-AGENT to prioritize frontend development tasks.
   - Work closely with the PR-CYBR-DATABASE-AGENT and PR-CYBR-DATA-INTEGRATION-AGENT to fetch and display accurate data.
   - Provide frontend components that support the PR-CYBR-SECURITY-AGENT’s user-focused cybersecurity workflows.

9. **Testing and Debugging**:
   - Implement rigorous testing protocols to identify bugs, usability issues, or performance regressions.
   - Use automated testing frameworks to validate UI functionality across devices and browsers.
   - Address and resolve frontend issues promptly to ensure a seamless user experience.

10. **User Feedback Integration**:
    - Collect, analyze, and act on user feedback to continuously enhance PR-CYBR platforms.
    - Create mockups, prototypes, and wireframes to gather input before major updates.
    - Regularly review analytics data to identify areas for improvement.

## Key Directives:
- Prioritize user satisfaction by delivering intuitive, reliable, and accessible interfaces.
- Maintain alignment with PR-CYBR’s mission, ensuring all platforms reflect the initiative’s goals and values.
- Work proactively to enhance performance, security, and design consistency.

## Interaction Guidelines:
- Collaborate effectively with other agents to ensure seamless integration between frontend and backend systems.
- Provide regular updates on development progress and challenges to PR-CYBR management.
- Use simple and clear language to explain frontend-related concepts to non-technical stakeholders.
- Respond to user or agent requests for frontend changes, enhancements, or troubleshooting promptly.

## Context Awareness:
- Maintain a deep understanding of PR-CYBR’s mission, audience, and operational requirements.
- Adapt frontend designs to support new tools, services, or workflows introduced by PR-CYBR.
- Stay updated on the latest frontend technologies and trends to ensure cutting-edge development practices.

## Tools and Capabilities:
You are equipped with advanced design tools, frontend development frameworks, and real-time collaboration capabilities to build and maintain robust interfaces. Leverage these tools to deliver high-quality platforms that serve PR-CYBR’s users and stakeholders effectively.
```

**Directory Structure**:

```shell
PR-CYBR-FRONTEND-AGENT/
	.github/
		workflows/
			ci-cd.yml
			docker-compose.yml
			openai-function.yml
	config/
		docker-compose.yml
		secrets.example.yml
		settings.yml
	docs/
		OPORD/
		README.md
	scripts/
		deploy_agent.sh
		local_setup.sh
		provision_agent.sh
	src/
		agent_logic/
			__init__.py
			core_functions.py
		shared/
			__init__.py
			utils.py
	tests/
		test_core_functions.py
	web/
		README.md
		index.html
	.gitignore
	LICENSE
	README.md
	requirements.txt
	setup.py
```

## Agent Core Functionality Overview

```markdown
# PR-CYBR-FRONTEND-AGENT Core Functionality Technical Outline

## Introduction

The **PR-CYBR-FRONTEND-AGENT** is dedicated to designing, developing, and maintaining the user interface and experience (UI/UX) for the PR-CYBR initiative. Its primary goal is to create intuitive, accessible, and visually engaging platforms that empower users to interact with PR-CYBR tools and services seamlessly.
```

```markdown
### Directory Structure

PR-CYBR-FRONTEND-AGENT/
├── config/
│   ├── docker-compose.yml
│   ├── secrets.example.yml
│   └── settings.yml
├── public/
│   ├── index.html
│   ├── favicon.ico
│   └── manifest.json
├── scripts/
│   ├── deploy_agent.sh
│   ├── local_setup.sh
│   └── provision_agent.sh
├── src/
│   ├── components/
│   │   ├── Header.jsx
│   │   ├── Footer.jsx
│   │   └── MapView.jsx
│   ├── pages/
│   │   ├── Home.jsx
│   │   ├── Dashboard.jsx
│   │   └── Settings.jsx
│   ├── styles/
│   │   ├── main.css
│   │   └── themes.css
│   ├── App.jsx
│   └── index.jsx
├── tests/
│   ├── test_components.js
│   └── test_pages.js
└── webpack.config.js
```

```markdown
## Key Files and Modules

- **`src/App.jsx`**: The root component that defines the application structure.
- **`src/components/`**: Contains reusable UI components.
- **`src/pages/`**: Defines the main pages/views of the application.
- **`src/styles/`**: Includes CSS files for styling the application.
- **`public/index.html`**: The HTML template for the single-page application.
- **`webpack.config.js`**: Configuration for building the application using Webpack.

## Core Functionalities

### 1. UI/UX Design and Implementation

#### Components and Pages:

- **`Header.jsx` and `Footer.jsx`** (`components/`)
  - Provide consistent navigation and branding across all pages.
  - Responsive design for various screen sizes.

- **`Home.jsx`** (`pages/`)
  - Serves as the landing page with an overview of PR-CYBR's mission.
  - Includes calls-to-action for user engagement.

- **`Dashboard.jsx`** (`pages/`)
  - Displays interactive data visualizations and real-time updates.
  - Integrates with `MapView` component for geospatial data.

#### Interaction with Other Agents:

- **Data Consumption**: Fetches data from `PR-CYBR-BACKEND-AGENT` APIs.
- **User Feedback**: Sends user interactions and feedback to `PR-CYBR-USER-FEEDBACK-AGENT`.

### 2. Data Visualization (`MapView.jsx`)

#### Modules and Functions:

- **`renderMap()`**
  - Inputs: Geospatial data from backend APIs.
  - Processes: Renders an interactive map using Leaflet and MapBox with the Jawg Matrix theme.
  - Outputs: Visual representation of data centered on Puerto Rico.

- **`updateMapLayers()`**
  - Inputs: User selections, data filters.
  - Processes: Updates map layers and markers dynamically.
  - Outputs: Real-time map updates.

#### Interaction with Other Agents:

- **Real-time Data**: Receives live data feeds from `PR-CYBR-DATA-INTEGRATION-AGENT`.
- **Performance Metrics**: Adjusts visualization based on performance feedback from `PR-CYBR-PERFORMANCE-AGENT`.

### 3. Frontend Routing (`App.jsx` and `index.jsx`)

#### Modules and Functions:

- **`setupRouting()`**
  - Uses React Router to define application routes.
  - Ensures smooth navigation without full page reloads.

- **`handleAuth()`**
  - Manages user authentication states.
  - Redirects users appropriately based on login status.

#### Interaction with Other Agents:

- **Authentication**: Communicates with `PR-CYBR-BACKEND-AGENT` for user authentication via APIs.
- **Security**: Implements frontend security measures guided by `PR-CYBR-SECURITY-AGENT`.

### 4. Theming and Branding (`styles/`)

#### Modules and Files:

- **`themes.css`**
  - Defines color schemes, fonts, and UI elements to maintain branding consistency.
  - Supports theme switching (e.g., light and dark modes).

- **`main.css`**
  - Contains global styles applied throughout the application.
  - Ensures responsive design and accessibility.

#### Interaction with Other Agents:

- **Accessibility**: Works with `PR-CYBR-DOCUMENTATION-AGENT` to ensure compliance with accessibility standards.
- **User Preferences**: Retrieves and applies user-specific settings from `PR-CYBR-BACKEND-AGENT`.

### 5. Internationalization (i18n)

#### Modules and Functions:

- **`i18n.js`**
  - Configures language support (e.g., English and Spanish).
  - Loads language resources and applies translations.

- **`LanguageSelector` Component**
  - Allows users to switch languages dynamically.
  - Stores language preferences.

#### Interaction with Other Agents:

- **Localization Data**: Coordinates with `PR-CYBR-DATA-INTEGRATION-AGENT` for localized content.
- **User Preferences**: Stores language settings via `PR-CYBR-BACKEND-AGENT`.

## Inter-Agent Communication Mechanisms

### Communication Protocols

- **RESTful APIs**: Fetches data and submits user actions via HTTP requests.
- **WebSockets**: Implements real-time features through persistent connections where necessary.

### Data Formats

- **JSON**: Standard format for data exchange with backend services.

### Authentication and Authorization

- **JWT Tokens**: Manages user sessions and permissions.
- **OAuth 2.0**: Integrates third-party authentication if required.

## Interaction with Specific Agents

### PR-CYBR-BACKEND-AGENT

- **Data Retrieval**: Consumes APIs for data display and user actions.
- **User Management**: Handles user authentication and profile management.

### PR-CYBR-USER-FEEDBACK-AGENT

- **Feedback Collection**: Sends user feedback and interaction data.
- **Surveys and Forms**: Embeds feedback mechanisms within the UI.

### PR-CYBR-SECURITY-AGENT

- **Security Policies**: Implements frontend security measures.
- **Vulnerability Mitigation**: Receives updates on potential frontend vulnerabilities.

## Technical Workflows

### Data Fetching Workflow

1. **API Calls**: Uses Axios or Fetch API to request data.
2. **State Management**: Utilizes React's state or Redux for managing application state.
3. **Rendering**: Updates UI components based on new data.

### Map Interaction Workflow

1. **User Interaction**: Captures events like clicks and zooms.
2. **Data Update**: Requests updated data based on user actions.
3. **Map Refresh**: Renders new data on the map in real-time.

## Build and Deployment

- **Build Tools**: Uses Webpack and Babel for transpiling and bundling code.
- **Testing**: Implements Jest and Enzyme for unit and integration tests.
- **Continuous Integration**: Integrated with `PR-CYBR-CI-CD-AGENT` for automated builds and deployments.

## Accessibility and Compliance

- **ARIA Roles**: Uses proper ARIA attributes for assistive technologies.
- **Keyboard Navigation**: Ensures all UI elements are accessible via keyboard.
- **Contrast Ratios**: Follows WCAG guidelines for color contrast.

## Error Handling and Logging

- **Error Boundaries**: React components that catch and handle rendering errors.
- **Logging**: Sends frontend errors to `PR-CYBR-BACKEND-AGENT` for logging and analysis.

## Security Considerations

- **Input Validation**: Sanitizes user inputs to prevent XSS attacks.
- **Secure Storage**: Avoids storing sensitive data in localStorage or cookies.
- **Content Security Policy (CSP)**: Defines policies to prevent code injection.

## Conclusion

The **PR-CYBR-FRONTEND-AGENT** is vital for delivering an engaging and user-friendly interface for the PR-CYBR initiative. By leveraging modern frontend technologies and ensuring close integration with other agents, it provides users with seamless access to PR-CYBR's tools and services, supporting the initiative's mission of enhancing cybersecurity awareness and resilience.
```


---

## OpenAI Functions

## Function List for PR-CYBR-FRONTEND-AGENT

```markdown
## Function List for PR-CYBR-FRONTEND-AGENT

1. **agent_dashboard_chat**: Facilitates real-time communication between users and the PR-CYBR agents, allowing for inquiries, support, and interaction directly through the dashboard interface.

2. **user_feedback_collection**: Gathers user feedback on the interface and overall user experience to inform design improvements and feature updates.

3. **data_visualization_dashboard**: Creates dynamic dashboards that visualize cybersecurity trends and performance metrics, providing users with actionable insights.

4. **multilingual_support**: Enables the user interface to support multiple languages, starting with Spanish and English, to cater to a diverse audience.

5. **accessibility_features**: Enhances the platform with accessibility options compatible with screen readers and other assistive technologies, ensuring inclusivity for all users.

6. **performance_monitoring_tool**: Provides insights into the frontend performance, including load times and responsiveness, allowing developers to optimize user experience.

7. **custom_theme_selector**: Allows users to customize the interface themes according to their preferences, improving user satisfaction and comfort.

8. **real_time_data_updates**: Integrates real-time data streams into the interface, ensuring that users see live updates on relevant cybersecurity metrics and news.

9. **notification_center**: Manages notifications related to system updates, new features, or alerts relevant to users’ interests and activities.

10. **tutorial_and_help_section**: Offers tutorials and guided help for new users, facilitating a smoother onboarding experience and better understanding of the platform functionalities.
```