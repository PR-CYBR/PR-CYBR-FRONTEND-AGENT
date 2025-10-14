import type { WebhookInfo } from '../lib/api';

interface Props {
  webhook?: WebhookInfo;
}

export function WebhookCard({ webhook }: Props) {
  return (
    <section className="flex flex-col gap-3 rounded-xl border border-slate-800 bg-slate-900/60 p-6 shadow-lg shadow-slate-950/30">
      <header>
        <h2 className="text-xl font-semibold text-white">Webhook Configuration</h2>
        <p className="text-sm text-slate-300">Secret values are masked automatically.</p>
      </header>
      {webhook ? (
        <dl className="space-y-3 text-sm text-slate-200">
          <div>
            <dt className="text-xs uppercase tracking-wide text-slate-500">Endpoint</dt>
            <dd className="font-mono text-xs text-slate-100">{webhook.url}</dd>
          </div>
          <div>
            <dt className="text-xs uppercase tracking-wide text-slate-500">Events</dt>
            <dd className="flex flex-wrap gap-2 pt-1">
              {webhook.events.map((event) => (
                <span key={event} className="rounded-full bg-slate-800/70 px-2 py-1 text-xs text-slate-200">
                  {event}
                </span>
              ))}
            </dd>
          </div>
          <div className="grid grid-cols-1 gap-2 sm:grid-cols-2">
            {webhook.createdAt && (
              <div>
                <dt className="text-xs uppercase tracking-wide text-slate-500">Created</dt>
                <dd>{new Date(webhook.createdAt).toLocaleString()}</dd>
              </div>
            )}
            {webhook.lastRedelivery && (
              <div>
                <dt className="text-xs uppercase tracking-wide text-slate-500">Last Delivery</dt>
                <dd>{new Date(webhook.lastRedelivery).toLocaleString()}</dd>
              </div>
            )}
          </div>
          <div>
            <dt className="text-xs uppercase tracking-wide text-slate-500">Status</dt>
            <dd>
              <span
                className={`rounded-full px-2 py-1 text-xs font-semibold ${webhook.active ? 'bg-emerald-500/20 text-emerald-300' : 'bg-rose-500/20 text-rose-300'}`}
              >
                {webhook.active ? 'Active' : 'Disabled'}
              </span>
            </dd>
          </div>
        </dl>
      ) : (
        <p className="text-sm text-slate-400">Webhook details unavailable. Confirm backend integration.</p>
      )}
    </section>
  );
}
