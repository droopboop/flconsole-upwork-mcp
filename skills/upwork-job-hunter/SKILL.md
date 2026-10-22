---
name: upwork-job-hunter
description: Find new Upwork jobs that fit the user and shortlist them, using the flconsole MCP server. Use when the user asks to check new Upwork jobs, set up a job search or feed, find clients, or review jobs before applying.
---

# Upwork job hunter

You help a freelancer find new Upwork jobs worth applying to. Jobs come from the flconsole MCP server
(`https://mcp.lite.flconsole.com/mcp`, free, sign-in with Telegram). It sees jobs posted in the last
30 minutes, so check often and act on fresh jobs first.

If the `flconsole` tools are missing, tell the user how to connect, then stop:

```bash
claude mcp add --transport http --scope user flconsole https://mcp.lite.flconsole.com/mcp
```

Then `/mcp` → `flconsole` → **Authenticate**.

## 1. Know what fits

Before the first search, learn the user's profile once and keep it for the session:
- skills and the kind of work they want (one or two lines);
- lowest hourly rate or fixed budget they accept;
- client signals that matter to them (verified payment, hire history, spend, country);
- what they never take (for example: unpaid tests, "cheap and fast", agencies only).

If they have an Upwork profile text or a past proposal, read it instead of asking.

## 2. Set up feeds

1. Call `list_feeds`. Reuse a feed that already matches.
2. If the user gives an Upwork search link, call `parse_upwork_url` and show the filters.
3. Otherwise build filters from the profile. Check them with `preview_filters`: aim for about
   5–40 jobs a day. Zero means the search is too narrow; hundreds means add client filters or
   narrow the words.
4. Show the filters and the preview count, then call `create_feed`. The user approves it.
   The same feed also sends alerts to their Telegram bot within a minute of posting.

## 3. Check new jobs

1. Call `find_jobs` for the user's feeds.
2. Drop jobs that break the user's rules. Keep the rest ranked by fit: skill match, budget, client
   quality, how fresh the job is.
3. For the top few, call `get_job_details` and read the full description.
4. Show a short list: title, budget, client signals, why it fits, the link. Say why you dropped
   the others in one line.

On a schedule in Claude Code:

```text
/loop 10m check new jobs in my flconsole feeds and show only the ones that fit
```

## 4. Help with the proposal

If the user picks a job, draft a short proposal from their profile and the job text: open with the
client's problem, show one relevant result, propose a first step, ask one question. Never send
anything for the user. If they also use Upwork's own MCP server for their account, ask before
every action there.

## Limits

Call `get_usage` when a call fails with a limit error and tell the user when it resets. Do not loop
faster than every 5 minutes.
