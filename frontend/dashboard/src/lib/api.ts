import axios, { AxiosHeaders, type AxiosInstance } from 'axios';
import { apiCredentials, config } from './config';

export type AutomationAction = 'audit' | 'security-scan' | 'wiki-sync';

export interface ActionLog {
  id: string;
  status: 'queued' | 'in_progress' | 'completed' | 'failed';
  startedAt?: string;
  completedAt?: string;
  url?: string;
  summary?: string;
}

export interface RepoMetadata {
  defaultBranch: string;
  latestCommit: string;
  description?: string;
  topics?: string[];
}

export interface WebhookInfo {
  url: string;
  events: string[];
  createdAt?: string;
  lastRedelivery?: string;
  active: boolean;
}

export interface DashboardState {
  metadata?: RepoMetadata;
  webhook?: WebhookInfo;
  version: string;
}

const client: AxiosInstance = axios.create({
  baseURL: config.apiBaseUrl,
  timeout: 10000
});

client.interceptors.request.use((request) => {
  const headers = request.headers instanceof AxiosHeaders ? request.headers : new AxiosHeaders(request.headers);

  if (apiCredentials && !headers.has('Authorization')) {
    headers.set('Authorization', `Basic ${apiCredentials}`);
  }

  headers.set('X-Requested-With', 'Security-Automation-Dashboard');

  request.headers = headers;
  return request;
});

export async function triggerAction(action: AutomationAction, payload?: Record<string, unknown>) {
  await client.post(`/actions/${action}/trigger`, payload ?? {});
}

export async function fetchActionLogs(action: AutomationAction): Promise<ActionLog[]> {
  const response = await client.get<ActionLog[]>(`/actions/${action}/runs`);
  return response.data;
}

export async function fetchDashboardState(): Promise<DashboardState> {
  const response = await client.get<DashboardState>('/dashboard');
  return response.data;
}

export function safeWebhookDisplay(info?: WebhookInfo) {
  if (!info) return undefined;

  return {
    ...info,
    url: maskSecrets(info.url)
  };
}

export function maskSecrets(value: string): string {
  if (!value) return value;
  const [base, query] = value.split('?');
  if (!query) return value;

  const maskedQuery = query
    .split('&')
    .map((pair) => {
      const [key, val] = pair.split('=');
      if (!val) return pair;
      const hidden = val.length <= 4 ? '*'.repeat(val.length) : `${val.slice(0, 2)}***${val.slice(-1)}`;
      return `${key}=${hidden}`;
    })
    .join('&');

  return `${base}?${maskedQuery}`;
}
