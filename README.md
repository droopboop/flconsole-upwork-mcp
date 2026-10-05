<p align="center">
  <a href="https://flconsole.com/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo">
    <img src="https://flconsole.com/og/mcp.png" alt="flconsole — free Upwork MCP server for your AI agent" width="720">
  </a>
</p>

<h1 align="center">flconsole — free Upwork MCP server</h1>

<p align="center">
  New Upwork jobs for Claude Code, Codex, Cursor and the Claude app.<br>
  Your agent finds new jobs, reads them and shows you the ones that fit.
</p>

<p align="center">
  <a href="https://flconsole.com/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo"><b>Website</b></a> ·
  <a href="https://flconsole.com/docs/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo"><b>Docs</b></a> ·
  <a href="https://t.me/flconsole_upwork_job_alerts_bot?start=github_repo"><b>Telegram bot</b></a>
</p>

<p align="center">
  <img alt="Price: free" src="https://img.shields.io/badge/price-free-2e9e5b">
  <img alt="MCP: Streamable HTTP" src="https://img.shields.io/badge/MCP-Streamable%20HTTP-111">
  <img alt="Sign-in: Telegram" src="https://img.shields.io/badge/sign--in-Telegram-26A5E4">
  <img alt="No API key" src="https://img.shields.io/badge/API%20key-not%20needed-555">
</p>

---

flconsole is a free service that watches new Upwork jobs and delivers matching ones to your Telegram or to your AI agent over MCP.

This repository holds ready-to-paste configs and a short guide. The server is hosted — there is nothing to install or run.

```
https://mcp.lite.flconsole.com/mcp
```

- **Free.** No card, no API key, no paid plan.
- **New jobs only.** Jobs posted in the last 30 minutes; no search in older jobs.
- **Your feeds, shared with Telegram.** A feed your agent creates also sends alerts to the [Telegram bot](https://t.me/flconsole_upwork_job_alerts_bot?start=github_repo) within a minute of posting.
- **No access to your Upwork account.** flconsole never asks for your Upwork login.

## Contents

- [Connect](#connect) — Claude Code, Codex, Claude app, Cursor, other clients
- [Sign-in](#sign-in)
- [Tools](#tools)
- [Prompts to start with](#prompts-to-start-with)
- [With Upwork's own MCP](#with-upworks-own-mcp)
- [Limits](#limits)
- [Links](#links)

## Connect

### Claude Code

```bash
claude mcp add --transport http flconsole https://mcp.lite.flconsole.com/mcp
```

Add `--scope user` to use it in all your projects. Then run `/mcp` → `flconsole` → **Authenticate**.
Guide: [flconsole in Claude Code](https://flconsole.com/mcp/claude-code?utm_source=github&utm_medium=referral&utm_campaign=repo) · file: [`configs/claude-code.sh`](configs/claude-code.sh)

### Codex

```bash
codex mcp add flconsole --url https://mcp.lite.flconsole.com/mcp
codex mcp login flconsole
```

The second command opens the sign-in page in your browser.
Guide: [flconsole in Codex](https://flconsole.com/mcp/codex?utm_source=github&utm_medium=referral&utm_campaign=repo) · file: [`configs/codex.sh`](configs/codex.sh)

### Claude app

Web, desktop and mobile: **Settings → Connectors → Add custom connector**, paste the server URL:

```
https://mcp.lite.flconsole.com/mcp
```

Guide: [flconsole in the Claude app](https://flconsole.com/mcp/claude?utm_source=github&utm_medium=referral&utm_campaign=repo)

### Cursor

Add to `~/.cursor/mcp.json`, then sign in when Cursor asks:

```json
{
  "mcpServers": {
    "flconsole": { "url": "https://mcp.lite.flconsole.com/mcp" }
  }
}
```

Guide: [flconsole in Cursor](https://flconsole.com/mcp/cursor?utm_source=github&utm_medium=referral&utm_campaign=repo) · file: [`configs/cursor.mcp.json`](configs/cursor.mcp.json)

### Other clients

Any MCP client with Streamable HTTP works. If it supports sign-in (OAuth), add the server URL and sign in as below. If it doesn't, use a **manual token**: in the Telegram bot send `/mcp` → **Manual token (other apps)**, then send it as `Authorization: Bearer <token>`.
Examples: [`configs/manual-token.claude-code.sh`](configs/manual-token.claude-code.sh), [`configs/manual-token.codex.toml`](configs/manual-token.codex.toml).

## Sign-in

Through Telegram — no password, no API key:

1. Your client opens a sign-in page in the browser.
2. Tap **Continue in Telegram** (or scan the QR code). The flconsole bot opens; if you're new, tap Start.
3. The bot names the app that wants access. Tap **Allow** and get a 4-digit code.
4. Enter the code on the sign-in page. Done.

The sign-in link works for 10 minutes. Disconnect any app later in the bot: `/mcp` → **Disconnect**.

## Tools

| Tool | What it does |
|---|---|
| `find_jobs` | New jobs by a feed, all feeds or any filters |
| `get_job_details` | Full data for the jobs you picked |
| `list_feeds` | Your feeds with filters and status |
| `create_feed` | Creates a feed; needs your approval |
| `update_feed` | Changes, pauses or resumes a feed |
| `delete_feed` | Deletes a feed; needs your approval |
| `preview_filters` | How many jobs matched in the last hours, with samples |
| `parse_upwork_url` | Turns an Upwork search link into filters |
| `list_categories` | Upwork categories and subcategories |
| `find_locations` | Countries and regions by name |
| `get_usage` | What's left of your limits |

Arguments, filters and job fields: [MCP reference](https://flconsole.com/docs/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo).

## Prompts to start with

```text
Check new jobs in my feeds and show only relevant ones.
```

```text
Create a feed from this Upwork search link: <link>. Show me the filters before saving.
```

On a schedule in Claude Code:

```text
/loop 10m check new jobs in my feeds and show only relevant ones
```

## With Upwork's own MCP

Upwork has its own MCP server for actions in your account. Use flconsole to find new jobs and Upwork's MCP to send proposals: your agent never runs repeated searches from your Upwork account. A freelancer [reports a policy violation](https://www.reddit.com/r/UpworkOfficial/comments/1w8dxc6/upwork_mcp/) after checking Upwork's MCP for new jobs every 15 minutes.

```text
Every 15 minutes, check new jobs in my flconsole feeds, pick the ones that fit, draft a proposal for each and ask me before sending anything through Upwork.
```

Setup: [flconsole + Upwork's MCP](https://flconsole.com/upwork-mcp?utm_source=github&utm_medium=referral&utm_campaign=repo)

## Limits

| | Limit |
|---|---|
| Feeds | 5 (shared with Telegram) |
| `find_jobs` | 100 jobs an hour, 1,000 a day, one call every 60 seconds |
| `get_job_details` | 30 jobs an hour |
| Feed changes | 20 an hour |
| `preview_filters` | 10 an hour |
| `parse_upwork_url` | 30 an hour |
| Connections | 5 apps at a time |

`get_usage` shows what's left.

## Links

- Website: [flconsole.com](https://flconsole.com/?utm_source=github&utm_medium=referral&utm_campaign=repo)
- MCP server: [flconsole.com/mcp](https://flconsole.com/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo)
- MCP reference: [flconsole.com/docs/mcp](https://flconsole.com/docs/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo)
- Telegram bot: [@flconsole_upwork_job_alerts_bot](https://t.me/flconsole_upwork_job_alerts_bot?start=github_repo)
- Compare with paid tools: [flconsole.com/compare](https://flconsole.com/compare?utm_source=github&utm_medium=referral&utm_campaign=repo)
- Privacy: [flconsole.com/privacy](https://flconsole.com/privacy?utm_source=github&utm_medium=referral&utm_campaign=repo) · Terms: [flconsole.com/terms](https://flconsole.com/terms?utm_source=github&utm_medium=referral&utm_campaign=repo)

The configs and text in this repository are under the [MIT License](LICENSE). The hosted service follows its [terms of use](https://flconsole.com/terms?utm_source=github&utm_medium=referral&utm_campaign=repo).
