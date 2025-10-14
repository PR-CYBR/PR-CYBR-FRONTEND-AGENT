import { ArrowPathIcon, PlayIcon } from '@heroicons/react/24/outline';
import type { ReactNode } from 'react';
import type { AutomationAction } from '../lib/api';
import { classNames } from '../lib/classNames';

const actionLabels: Record<AutomationAction, string> = {
  audit: 'Audit',
  'security-scan': 'Security Scan',
  'wiki-sync': 'Wiki Sync'
};

interface Props {
  action: AutomationAction;
  description: string;
  logs: ReactNode;
  loading: boolean;
  triggering: boolean;
  onTrigger: () => Promise<void>;
  onRefresh: () => Promise<void>;
  disabled?: boolean;
}

export function ActionCard({
  action,
  description,
  logs,
  loading,
  triggering,
  onTrigger,
  onRefresh,
  disabled
}: Props) {
  return (
    <section className="flex flex-col gap-4 rounded-xl border border-slate-800 bg-slate-900/60 p-6 shadow-lg shadow-slate-950/30">
      <header className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h2 className="text-xl font-semibold text-white">{actionLabels[action]}</h2>
          <p className="text-sm text-slate-300">{description}</p>
        </div>
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => {
              void onRefresh();
            }}
            disabled={loading}
            className={classNames(
              'inline-flex items-center gap-2 rounded-lg border border-slate-700 px-3 py-2 text-sm font-medium transition',
              'bg-slate-900 text-slate-200 hover:bg-slate-800 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand',
              loading && 'cursor-not-allowed opacity-50'
            )}
          >
            <ArrowPathIcon className={classNames('h-4 w-4', loading && 'animate-spin')} />
            Refresh
          </button>
          <button
            type="button"
            onClick={() => {
              void onTrigger();
            }}
            disabled={disabled || triggering}
            className={classNames(
              'inline-flex items-center gap-2 rounded-lg bg-brand px-4 py-2 text-sm font-semibold text-slate-900 transition',
              'hover:bg-sky-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand',
              (disabled || triggering) && 'cursor-not-allowed opacity-50'
            )}
          >
            <PlayIcon className={classNames('h-4 w-4', triggering && 'animate-pulse')} />
            Trigger
          </button>
        </div>
      </header>
      <div className="max-h-64 overflow-y-auto rounded-lg bg-slate-950/60 p-4">
        {logs}
      </div>
    </section>
  );
}
