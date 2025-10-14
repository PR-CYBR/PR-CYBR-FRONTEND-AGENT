interface DashboardConfig {
  apiBaseUrl: string;
  repoOwner: string;
  repoName: string;
  dashboardTitle: string;
  webhookEndpoint: string;
  buildVersion: string;
}

const env = import.meta.env as Record<string, string | undefined>;

export const config: DashboardConfig = {
  apiBaseUrl: env.VITE_API_BASE_URL ?? '/api',
  repoOwner: env.VITE_REPO_OWNER ?? 'unknown-owner',
  repoName: env.VITE_REPO_NAME ?? 'unknown-repo',
  dashboardTitle: env.VITE_DASHBOARD_TITLE ?? 'Security Automation Dashboard',
  webhookEndpoint: env.VITE_WEBHOOK_ENDPOINT ?? '/api/webhooks/github',
  buildVersion: env.VITE_BUILD_VERSION ?? 'dev'
};

export const apiCredentials = (() => {
  const user = env.VITE_API_BASIC_USER;
  const pass = env.VITE_API_BASIC_PASSWORD;

  if (user && pass) {
    return btoa(`${user}:${pass}`);
  }

  return undefined;
})();
