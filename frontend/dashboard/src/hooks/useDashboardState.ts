import { useCallback, useEffect, useState } from 'react';
import type { DashboardState } from '../lib/api';
import { config } from '../lib/config';
import { fetchDashboardState, safeWebhookDisplay } from '../lib/api';

interface DashboardViewState {
  data?: DashboardState;
  loading: boolean;
  error?: string;
}

export function useDashboardState(): DashboardViewState {
  const [state, setState] = useState<DashboardViewState>({ loading: true });

  const load = useCallback(async () => {
    setState({ loading: true });
    try {
      const response = await fetchDashboardState();
      setState({
        loading: false,
        data: {
          ...response,
          version: response.version ?? config.buildVersion,
          webhook: safeWebhookDisplay(response.webhook)
        }
      });
    } catch (err) {
      console.error('fetchDashboardState failed', err);
      setState({
        loading: false,
        data: {
          version: config.buildVersion,
          metadata: {
            defaultBranch: config.repoName,
            latestCommit: 'unknown'
          }
        },
        error: 'Unable to retrieve dashboard metadata. Showing fallback values.'
      });
    }
  }, []);

  useEffect(() => {
    load().catch(() => {
      // handled
    });
  }, [load]);

  return state;
}
