# Monitoring & Alerting di GCP Monitoring

## Uptime Check

```
1. Buka Cloud Console → Monitoring → Uptime Checks.
2. Klik Create Uptime Check.
   - Protocol: HTTP
   - Resource: URL
   - URL: https://<SERVICE_URL>/healthz
   - Check frequency: 1 minute
   - Timeout: 10 seconds
   - Response validation: HTTP status = 200
```

## Alerting Policy

```
1. Buka Monitoring → Alerting → Create Policy.
2. Tambahkan Condition:
   - Resource type: Uptime Check URL
   - Condition trigger: if uptime check failed for 5 minutes
3. Notification channel:
   - Tambahkan Slack → Integrasikan lewat Webhook Slack.
   - Atau gunakan Email notification.
4. Simpan policy.
```

### Dengan setup ini, jika /healthz tidak memberikan 200 OK selama 5 menit, alert akan dikirim ke Slack/email.