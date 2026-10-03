# Contributing

Thank you for your interest in contributing!

## Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Make your changes
4. Commit using [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `chore:`, etc.
5. Push and open a pull request

## Reporting Issues

Open a [GitHub Issue](../../issues) with a clear description and steps to reproduce.

## Code Style

Follow the existing conventions in the codebase.

## Verification

Run from the repository root with pnpm 10, a supported Node version from the
[README](README.md#prerequisites), and stable Rust plus the native Tauri
prerequisites when checking Rust. Install with `pnpm install --frozen-lockfile`.
The prepare hook configures Husky; prefer a standalone clone when preserving
another worktree's Git configuration. `pnpm install --frozen-lockfile --ignore-scripts`
can be used for an inspection install, but skips lifecycle scripts used by CI.

For a focused frontend change and then broader checks:

```sh
pnpm test --run src/utils/__tests__/dateFormat.test.ts
pnpm test --run
pnpm lint
pnpm build
```

`pnpm test` alone starts watch mode. `make test` runs once. `lint` is TypeScript
checking (`tsc --noEmit`), and `build` runs TypeScript followed by Vite; neither
is a formatting check. Prettier is installed but there is no format script:
check only selected changed files with `pnpm exec prettier --check <file>`.

For Rust changes:

```sh
cargo test --manifest-path src-tauri/Cargo.toml
cargo fmt --manifest-path src-tauri/Cargo.toml --all -- --check
cargo clippy --manifest-path src-tauri/Cargo.toml --all-targets -- -D warnings
```

A test-name filter after the manifest narrows Rust coverage. Fixture unit tests
need no Jira token, Ollama service, or production database. See the
[managed verification list](.codex/verify.commands) and
[runner](.codex/scripts/run_verify_commands.sh) for guards and performance
budgets in addition to correctness checks. The workflows under `.github/workflows/`
are authoritative for provider gates; API/database performance lanes require
explicit configured targets and are not a default local verification step.

For UI changes, check the changed flow in a browser preview with synthetic data
where possible. Native IPC needs `pnpm tauri dev`; launch initializes persistent
application data and may migrate a legacy database. Use a disposable environment
for desktop validation rather than an existing credential-bearing profile.
Do not post Jira notes or upload attachments as a verification shortcut.
Browser/fixture success does not prove real Jira access or a signed release.
Documentation-only changes do not require launching the desktop app.
