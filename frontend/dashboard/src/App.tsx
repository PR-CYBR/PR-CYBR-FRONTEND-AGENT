import { useMemo } from 'react';
import { ActionCard } from './components/ActionCard';
import { LogsList } from './components/LogsList';
import { RepoMetadataCard } from './components/RepoMetadataCard';
import { WebhookCard } from './components/WebhookCard';
import { useAutomationActions } from './hooks/useAutomationActions';
import { useDashboardState } from './hooks/useDashboardState';
import { config } from './lib/config';

const actionDescriptions = {
  audit: 'Run compliance audits to validate infrastructure controls.',
  'security-scan': 'Launch dependency and code scanning workflows via GitHub Actions.',
  'wiki-sync': 'Update internal wiki content with the latest operational notes.'
} as const;

function ActionSection() {
  const audit = useAutomationActions('audit');
  const scan = useAutomationActions('security-scan');
  const wiki = useAutomationActions('wiki-sync');

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
      <ActionCard
        action="audit"
        description={actionDescriptions.audit}
        logs={<LogsList logs={audit.logs} loading={audit.loading} />}
        loading={audit.loading}
        triggering={audit.triggering}
        onTrigger={audit.trigger}
        onRefresh={audit.reload}
      />
      <ActionCard
        action="security-scan"
        description={actionDescriptions['security-scan']}
        logs={<LogsList logs={scan.logs} loading={scan.loading} />}
        loading={scan.loading}
        triggering={scan.triggering}
        onTrigger={scan.trigger}
        onRefresh={scan.reload}
      />
      <ActionCard
        action="wiki-sync"
        description={actionDescriptions['wiki-sync']}
        logs={<LogsList logs={wiki.logs} loading={wiki.loading} />}
        loading={wiki.loading}
        triggering={wiki.triggering}
        onTrigger={wiki.trigger}
        onRefresh={wiki.reload}
      />
    </div>
  );
}

export default function App() {
  const dashboard = useDashboardState();

  const pageTitle = useMemo(() => `${config.dashboardTitle}`, []);

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950 pb-12">
      <div className="mx-auto flex max-w-6xl flex-col gap-8 px-6 pt-12">
        <header className="flex flex-col gap-2">
          <p className="text-xs uppercase tracking-[0.3em] text-slate-500">{config.repoOwner}</p>
          <h1 className="text-4xl font-bold text-white">{pageTitle}</h1>
          <p className="max-w-3xl text-sm text-slate-300">
            Trigger automated security workflows, review audit history, and inspect webhook connectivity—all without exposing
            sensitive credentials.
          </p>
        </header>

        <RepoMetadataCard
          metadata={dashboard.data?.metadata}
          version={dashboard.data?.version ?? config.buildVersion}
          loading={dashboard.loading}
          error={dashboard.error}
        />

        <ActionSection />

        <WebhookCard webhook={dashboard.data?.webhook} />
      </div>
    </div>
  );
}
