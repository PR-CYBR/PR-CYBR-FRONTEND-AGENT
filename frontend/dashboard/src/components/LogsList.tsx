import type { ActionLog } from '../lib/api';
import { classNames } from '../lib/classNames';

interface Props {
  logs: ActionLog[];
  loading: boolean;
}

const statusColor: Record<ActionLog['status'], string> = {
  queued: 'bg-yellow-500/20 text-yellow-300',
  in_progress: 'bg-blue-500/20 text-blue-300',
  completed: 'bg-emerald-500/20 text-emerald-300',
  failed: 'bg-rose-500/20 text-rose-300'
};

export function LogsList({ logs, loading }: Props) {
  if (loading) {
    return <p className="animate-pulse text-sm text-slate-300">Loading recent runs…</p>;
  }

  if (!logs.length) {
    return <p className="text-sm text-slate-400">No runs recorded yet.</p>;
  }

  return (
    <ol className="space-y-3 text-sm text-slate-200">
      {logs.map((log) => (
        <li key={log.id} className="rounded-lg border border-slate-800 bg-slate-900/60 p-3">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <span
              className={classNames('inline-flex items-center gap-2 rounded-full px-2 py-1 text-xs font-semibold', statusColor[log.status])}
            >
              {log.status.replace('_', ' ')}
            </span>
            <div className="flex flex-wrap gap-2 text-xs text-slate-400">
              {log.startedAt && <span>Started {new Date(log.startedAt).toLocaleString()}</span>}
              {log.completedAt && <span>Ended {new Date(log.completedAt).toLocaleString()}</span>}
            </div>
          </div>
          {log.summary && <p className="mt-2 text-slate-300">{log.summary}</p>}
          {log.url && (
            <a
              href={log.url}
              target="_blank"
              rel="noreferrer"
              className="mt-3 inline-flex items-center text-xs font-medium text-sky-300 hover:text-sky-200"
            >
              View on GitHub
            </a>
          )}
        </li>
      ))}
    </ol>
  );
}
