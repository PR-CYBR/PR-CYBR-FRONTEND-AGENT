import { describe, expect, it } from 'vitest';
import { maskSecrets } from './api';

describe('maskSecrets', () => {
  it('masks token-like query parameters', () => {
    const masked = maskSecrets('https://example.com/hook?token=abc12345&secret=s3cr3t');
    expect(masked).toBe('https://example.com/hook?token=ab***5&secret=s3***t');
  });

  it('returns original value when no query parameters present', () => {
    const url = 'https://example.com';
    expect(maskSecrets(url)).toBe(url);
  });

  it('handles short values by fully masking', () => {
    const masked = maskSecrets('https://example.com?h=abc');
    expect(masked).toBe('https://example.com?h=***');
  });
});
