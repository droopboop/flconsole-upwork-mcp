# For clients without sign-in (OAuth) support: a manual token.
# Get it in the Telegram bot: /mcp → "Manual token (other apps)". It is shown once.
claude mcp add --transport http flconsole https://mcp.lite.flconsole.com/mcp \
  --header "Authorization: Bearer <token>"
