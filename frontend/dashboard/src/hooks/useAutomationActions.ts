import { useCallback, useEffect, useMemo, useState } from 'react';
import type { ActionLog, AutomationAction } from '../lib/api';
import { fetchActionLogs, triggerAction } from '../lib/api';

interface ActionState {
  logs: ActionLog[];
  loading: boolean;
  triggering: boolean;
  error?: string;
}

export function useAutomationActions(action: AutomationAction) {
  const [state, setState] = useState<ActionState>({ logs: [], loading: true, triggering: false });

  const load = useCallback(async () => {
    setState((prev) => ({ ...prev, loading: true, error: undefined }));
    try {
      const result = await fetchActionLogs(action);
      setState({ logs: result, loading: false, triggering: false });
    } catch (err) {
      console.error('fetchActionLogs failed', err);
      setState((prev) => ({
        ...prev,
        loading: false,
        error: 'Unable to fetch latest logs. Check network or credentials.'
      }));
    }
  }, [action]);

  const execute = useCallback(async () => {
    setState((prev) => ({ ...prev, triggering: true, error: undefined }));
    try {
      await triggerAction(action);
      await load();
    } catch (err) {
      console.error('triggerAction failed', err);
      setState((prev) => ({
        ...prev,
        triggering: false,
        error: 'Failed to trigger workflow. Ensure you have permission.'
      }));
    }
  }, [action, load]);

  useEffect(() => {
    load().catch(() => {
      // errors handled above
    });
  }, [load]);

  return useMemo(
    () => ({
      ...state,
      reload: load,
      trigger: execute
    }),
    [state, load, execute]
  );
}
