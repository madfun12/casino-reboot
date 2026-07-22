# Repository Guidelines

## Project Structure & Module Organization

This repository is a QBCore/FiveM casino resource collection. Each top-level `casino-*` directory is an independently started FiveM resource and has an `fxmanifest.lua` that defines its load order. Game logic is generally split into `client/` and `server/` Lua files; shared settings live in each resource's `config.lua`. `casinoUi/` contains the NUI overlay (`html/index.html`, `html/js/script.js`, and `html/css/stylesheet.css`). The `casino-luckywheel/stream/` directory holds streamed GTA assets. Root PNG files are inventory images documented in `README.md`.

## Build, Test, and Development Commands

There is no package-based build or automated test suite. Develop against a local FiveM server with QBCore, `qb-target`, `qb-menu`, PolyZone, and the required MLO/DLC loader installed. Add each resource to `server.cfg`, for example:

```cfg
ensure casino_chip
ensure casino_member
ensure casino-roulette
ensure casinoUi
```

Restart a changed resource from the server console with `restart casino-roulette`. Use the FiveM client and server console to verify interactions, chip balances, payouts, and errors after every behavior change.

## Coding Style & Naming Conventions

Match the surrounding file's indentation (Lua is commonly four spaces; existing manifests may use tabs). Keep client-only code in client scripts and perform authoritative money, inventory, and reward changes on the server. Use descriptive Lua `camelCase` locals/functions, `UPPER_SNAKE_CASE` only for established globals/constants, and resource-specific event names. Preserve `fxmanifest.lua` script order: dependencies and configs must load before code that consumes them. For NUI changes, use standard HTML/CSS/JavaScript and avoid injecting untrusted strings with `innerHTML`.

## Testing Guidelines

Test the affected resource in a clean local server session and exercise both success and failure paths: insufficient chips, invalid state, leaving an interaction zone, reconnects, and concurrent players. Confirm client notifications agree with server-side inventory or currency results. Check F8 and server logs for Lua/NUI errors. Update `luckywheel.sql` only when the schema change is intentional and documented in the PR.

## Commit & Pull Request Guidelines

Git history is not available in this checkout, so use short imperative commit subjects scoped to a resource, such as `roulette: validate server-side bets`. Keep commits focused. PRs should state the affected resources, explain configuration or dependency changes, list manual test steps, link the related issue when available, and include screenshots or a short clip for UI/gameplay changes. Never commit server credentials, player data, or generated runtime artifacts.
