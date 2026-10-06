# Installing flconsole (for AI agents)

flconsole is a **hosted** MCP server for new Upwork jobs. There is nothing to clone, build or run — only add the remote server to the client config.

- URL: `https://mcp.lite.flconsole.com/mcp`
- Transport: Streamable HTTP
- Auth: OAuth 2.1 (sign-in through Telegram), or a manual bearer token

## Cline

Add this to `cline_mcp_settings.json`:

```json
{
  "mcpServers": {
    "flconsole": {
      "type": "streamableHttp",
      "url": "https://mcp.lite.flconsole.com/mcp"
    }
  }
}
```

If the client opens a sign-in page, ask the user to complete it: tap **Continue in Telegram**, tap **Allow** in the flconsole bot and enter the 4-digit code on the page.

If the client cannot sign in with OAuth, ask the user for a manual token: in the Telegram bot [@flconsole_upwork_job_alerts_bot](https://t.me/flconsole_upwork_job_alerts_bot) send `/mcp` → **Manual token (other apps)**. Then use:

```json
{
  "mcpServers": {
    "flconsole": {
      "type": "streamableHttp",
      "url": "https://mcp.lite.flconsole.com/mcp",
      "headers": { "Authorization": "Bearer <token>" }
    }
  }
}
```

Never invent a token and never put it in a shared or committed file.

## Check

Call `get_usage`. It returns the remaining quotas — the server is connected. Then try `find_jobs` with filters, for example `{"filters": {"schema_version": 1, "base": {"q": "python"}}}`, or ask the user which jobs they want and create a feed with `create_feed` (it needs the user's approval).

## No Upwork login

flconsole never asks for Upwork credentials and does not act in the user's Upwork account.
