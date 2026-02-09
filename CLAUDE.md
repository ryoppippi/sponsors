# Sponsor

Automated GitHub sponsor showcase using SponsorKit. Fetches sponsor data and generates SVG/PNG visualisations.

## Tech Stack

- **Runtime**: Bun
- **Language**: TypeScript (strict mode, bundler resolution)
- **Main Library**: SponsorKit
- **Linting**: oxlint (strict, type-aware)
- **Formatting**: oxfmt (tabs, semicolons, single quotes)
- **Type Checking**: tsgo
- **Build System**: Nix Flakes with flake-parts

## Development Commands

```bash
nix develop                  # Enter dev shell
bun run update               # Generate sponsor visualisations
bun run typecheck             # Type check with tsgo
bun run lint                  # Lint with oxlint
bun run format                # Format with oxfmt
bun run format:check          # Check formatting
nix flake check               # Run all Nix checks (treefmt, pre-commit, typos, gitleaks)
nix run                       # Run the default app (install deps + update sponsors)
```

## Project Structure

```
.
├── flake.nix                 # Nix flake entry point (inputs + imports)
├── nix/
│   ├── treefmt.nix           # Formatter config (nixfmt, deadnix, statix, oxfmt)
│   ├── git-hooks.nix         # Pre-commit hooks (gitleaks, treefmt)
│   ├── checks.nix            # Flake checks (typos, gitleaks)
│   ├── devshell.nix          # Dev shell packages
│   └── apps.nix              # Default app (sponsor generation)
├── sponsor.config.ts         # SponsorKit configuration (tiers, rendering)
├── sponsors.svg/png          # Generated sponsor visualisations
└── sponsors.json             # Exported sponsor data
```

## CI/CD

- **Sponsor Update**: Daily cron job runs `nix run` and commits changes
- **Lint**: Runs `nix flake check` on push and PRs
- **Monthly Tag**: Creates YYYYMM release tags on the 1st of each month

## Code Style

- Use `import type` for type-only imports
- No `console.log` (enforced by oxlint)
- Strict TypeScript: no `any`, no floating promises
- UK English spelling in text content
- All code-related output (commits, comments, docs, PRs) in English
