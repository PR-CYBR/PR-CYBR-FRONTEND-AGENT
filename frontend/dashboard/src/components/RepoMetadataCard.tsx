import { config } from '../lib/config';
import type { RepoMetadata } from '../lib/api';

interface Props {
  metadata?: RepoMetadata;
  version: string;
  loading: boolean;
  error?: string;
}

export function RepoMetadataCard({ metadata, version, loading, error }: Props) {
  return (
    <section className="flex flex-col gap-3 rounded-xl border border-slate-800 bg-slate-900/60 p-6 shadow-lg shadow-slate-950/30">
      <header className="flex flex-col">
        <span className="text-xs uppercase tracking-wide text-slate-400">Repository</span>
        <h1 className="text-2xl font-semibold text-white">
          {config.repoOwner}/{config.repoName}
        </h1>
      </header>
      <dl className="grid grid-cols-1 gap-4 text-sm text-slate-300 sm:grid-cols-2">
        <div>
          <dt className="text-xs uppercase tracking-wide text-slate-500">Default Branch</dt>
          <dd className="font-medium text-slate-100">{metadata?.defaultBranch ?? 'unknown'}</dd>
        </div>
        <div>
          <dt className="text-xs uppercase tracking-wide text-slate-500">Latest Commit</dt>
          <dd className="font-mono text-xs text-slate-200">{metadata?.latestCommit ?? 'unknown'}</dd>
        </div>
        {metadata?.description && (
          <div className="sm:col-span-2">
            <dt className="text-xs uppercase tracking-wide text-slate-500">Description</dt>
            <dd className="text-slate-200">{metadata.description}</dd>
          </div>
        )}
        {metadata?.topics && metadata.topics.length > 0 && (
          <div className="sm:col-span-2">
            <dt className="text-xs uppercase tracking-wide text-slate-500">Topics</dt>
            <dd className="flex flex-wrap gap-2 pt-1">
              {metadata.topics.map((topic) => (
                <span key={topic} className="rounded-full bg-slate-800/70 px-2 py-1 text-xs text-slate-200">
                  {topic}
                </span>
              ))}
            </dd>
          </div>
        )}
      </dl>
      <div className="flex flex-wrap items-center justify-between gap-2 text-xs text-slate-400">
        <span>Dashboard build: {version}</span>
        {loading ? <span className="animate-pulse">Syncing…</span> : <span>Last sync: {new Date().toLocaleString()}</span>}
      </div>
      {error && <p className="text-xs text-amber-400">{error}</p>}
    </section>
  );
}
