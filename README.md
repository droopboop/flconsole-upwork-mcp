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
  <a href="https://allmcps.com/mcp/flconsole-upwork-jobs?verify=b03913f3-7778-423c-a600-9e2194854d92"><img alt="AllMCPs Verified" src="https://allmcps.com/api/badge/flconsole-upwork-jobs"></a>
</p>

---

flconsole is a free service that watches new Upwork jobs and delivers matching ones to your Telegram or to your AI agent over MCP.

This repository holds ready-to-paste configs and a short guide. The server is hosted — there is nothing to install or run.

```
https://mcp.lite.flconsole.com/mcp
```

- **Free.** No card, no API key, no paid plan.
- **One feed, for your agent and your phone.** Your agent saves searches as feeds on the server; turn on alerts for any of them with one command and the [Telegram bot](https://t.me/flconsole_upwork_job_alerts_bot?start=github_repo) sends matching jobs within a minute of posting.
- **No access to your Upwork account.** flconsole never asks for your Upwork login.

## Contents

- [Connect](#connect) — Claude Code, Codex, Claude app, Cursor, other clients
- [Sign-in](#sign-in)
- [Three ways to work](#three-ways-to-work)
- [Tools](#tools)
- [Prompts to start with](#prompts-to-start-with)
- [Skill for Claude Code](#skill-for-claude-code)
- [No terminal? Install in Claude app](#no-terminal-install-in-claude-app)
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

Web, desktop and mobile: **Customize → Connectors → + → Add custom connector**, paste the server URL:

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

## Three ways to work

| Way | What your agent does | What is stored |
|---|---|---|
| **1. Search only** | `find_jobs` with a search query and filters in every call | Nothing |
| **2. Feeds for your agent + memory** | Starts each session with `get_agent_context`, keeps up to 5 feeds with alerts off (search, job and client filters, your AI filter in plain words, its own notes) and its notes about you. Start any agent anywhere and it picks up where the last one stopped | Feeds and the agent's notes, on flconsole's server |
| **3. Telegram alerts** | Turns on alerts for a feed with one command (`set_feed_alerts`): the Telegram bot sends you every new matching job, filtered by the same AI filter | The same feed, now with alerts on |

A feed with alerts off is for your agent only: nothing goes to Telegram and nothing runs on the server — your agent checks it with `find_jobs` and applies your AI filter itself. You see both kinds in the bot's `/feeds`, where you can turn alerts on or off, pause or delete a feed.

## Tools

| Tool | What it does |
|---|---|
| `get_agent_context` | Start of a session: how-to, the agent's notes about you and all your feeds |
| `find_jobs` | New jobs by a feed, all feeds or any filters |
| `get_job_details` | Full data for the jobs you picked |
| `list_feeds` | Your feeds: filters, AI filter, alerts on or off, paused |
| `create_feed` | Saves a feed (alerts off unless you ask); needs your approval |
| `update_feed` | Changes a feed's search, filters, AI filter or the agent's notes |
| `set_feed_alerts` | Turns Telegram alerts for a feed on or off; needs your approval |
| `set_feed_paused` | Pauses or resumes a feed |
| `delete_feed` | Deletes a feed; needs your approval |
| `save_agent_instructions` | Saves the agent's notes about you: preferences, conclusions |
| `preview_filters` | How many jobs matched over the last 7 days: total, ~per day and per UTC day, with samples |
| `parse_upwork_url` | Turns an Upwork search link into filters |
| `list_categories` | Upwork categories and subcategories |
| `find_locations` | Countries and regions by name |
| `get_usage` | What's left of your limits |

Arguments, filters and job fields: [MCP reference](https://flconsole.com/docs/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo).

## Prompts to start with

```text
Find new React Native jobs: hourly from $40, clients from the US or Canada with verified payment. Show only the ones about fintech.
```

```text
Check new jobs in my flconsole feeds and show only the ones that fit.
```

```text
Save this Upwork search link as a feed: <link>. Show me the filters before saving.
```

```text
Turn on Telegram alerts for my React Native feed.
```

On a schedule in Claude Code:

```text
/loop 10m check new jobs in my feeds and show only relevant ones
```

## Skill for Claude Code

[`skills/upwork-job-hunter`](skills/upwork-job-hunter/SKILL.md) turns your agent into a job scout. No feed needed: the agent searches new jobs with your query and filters and reads every job itself.

- **Picks up where you left off.** Every session starts with `get_agent_context`: your feeds and what the agent learned about you are kept on the server, so any agent on any device continues the same work. Prefer a local file? Say so, and it keeps `upwork-job-hunter.md` instead.
- **Setup in 3 steps**, like the onboarding of the Telegram bot: what to search, job and client filters, and your own AI criteria in plain words. The agent counts matching jobs at every step and suggests how to sharpen the search.
- **Your AI filter, applied by your agent.** It tests your criteria on real jobs, shows what passed and why, and you adjust them.
- **Shortlist with reasons** on every check, and proposal drafts for the jobs you pick. Nothing is sent for you.
- **Tuning with numbers.** Too many jobs, too few or not the right ones — the agent shows the counts and offers concrete changes to the search, filters and criteria.
- **Telegram alerts** when you want them: one command turns them on for the same feed, with the same AI filter.

Install it with the [skills](https://skills.sh) CLI (add `-g` to use it in all your projects):

```bash
npx skills add droopboop/flconsole-upwork-mcp
```

Or copy it into `~/.claude/skills/`:

```bash
mkdir -p ~/.claude/skills/upwork-job-hunter && curl -fsSL https://raw.githubusercontent.com/droopboop/flconsole-upwork-mcp/main/skills/upwork-job-hunter/SKILL.md -o ~/.claude/skills/upwork-job-hunter/SKILL.md
```

Then ask Claude Code:

```text
Set up my Upwork job search.
```

## No terminal? Install in Claude app

Works in the Claude app on the web and on desktop.

1. Open **Customize → Connectors**, click **+** → **Add custom connector** and paste `https://mcp.lite.flconsole.com/mcp`. Click **Connect** and sign in through Telegram (see [Sign-in](#sign-in)).
2. **Quickest: paste a prompt.** Copy the [ready prompt](https://flconsole.com/how-to/mcp?utm_source=github&utm_medium=referral&utm_campaign=repo#no-terminal) and paste it at the start of a chat, or into the instructions of a Claude project.

**Want it installed? Add the skill.** After step 1:

1. Download [**upwork-job-hunter.zip**](https://github.com/droopboop/flconsole-upwork-mcp/releases/latest/download/upwork-job-hunter.zip). Don't unzip it.
2. In Claude, open **Customize → Skills**, click **+** → **Create skill** → **Upload a skill** and pick the file. Make sure the skill is turned on. If you don't see Skills, turn on **Code execution and file creation** in **Settings → Capabilities**.
3. Start a new chat and say:

```text
Set up my Upwork job search.
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
| Feeds with Telegram alerts | 5 |
| Feeds for your agent (alerts off) | 5 more |
| `find_jobs` | 100 jobs an hour, 1,000 a day, one call every 60 seconds |
| `get_job_details` | 30 jobs an hour |
| Feed changes | 20 an hour |
| Changes to the agent's notes | 30 an hour |
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
