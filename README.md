# Ticket Handoff Assistant

[![TypeScript](https://img.shields.io/badge/TypeScript-%233178c6?style=flat-square&logo=typescript)](#) [![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](#) [![Platform](https://img.shields.io/badge/platform-macOS-lightgrey?style=flat-square)](#)

> Turn 30-minute escalation write-ups into 3-minute handoffs — with full context, no copy-pasting, and 50% fewer follow-up questions.

Ticket Handoff Assistant is a privacy-first desktop app for IT support engineers. It fetches ticket context from Jira on request, lets you track troubleshooting steps interactively as you work, generates an AI summary of completed and unattempted steps, and posts formatted escalation notes back to Jira in one click.

## Features

- **Jira Fetch** — Enter a ticket ID and click "Fetch from Jira" to pull summary, reporter, and current status directly from your Jira instance
- **Interactive Troubleshooting Checklists** — Track steps in real time as you work; the checklist becomes the basis for the escalation summary
- **AI Escalation Summaries** — Ollama generates a structured summary of completed steps, steps not attempted, and recommended next steps (optional, runs offline with a local endpoint and an available model)
- **One-Click Jira Post** — Post formatted markdown escalation notes back to the ticket without leaving the app
- **Draft Persistence** — Save and resume mid-escalation; handoffs survive interruptions and shift changes
- **File Attachments** — Attach screenshots or logs directly to Jira tickets from the app

## Quick Start

### Prerequisites

- Node.js 22.22.2+ within 22.x, 24.15+ within 24.x, or 26+ (the locked `jsdom` dependency requires this; CI currently selects Node 20)
- pnpm 10 (CI pins 10.28.1)
- Rust toolchain (stable) + Tauri v2 prerequisites for macOS
- Jira instance and API token only for real Jira integration; fixture tests do not need credentials

### Installation

```bash
git clone https://github.com/saagpatel/TicketHandoff.git
cd TicketHandoff
pnpm install --frozen-lockfile
```

### Run (development)

```bash
# Browser preview (native IPC is unavailable here)
pnpm dev
# Desktop development (writes application data)
pnpm tauri dev
```

Configure real Jira access in the desktop app Settings; `.env.example` does not
provide Jira credential variables. Avoid real Jira requests or posting notes
when inspecting the UI or running synthetic tests.

### Build (desktop app)

```bash
pnpm tauri build
```

## Tech Stack

| Layer            | Technology                  |
| ---------------- | --------------------------- |
| Desktop shell    | Tauri 2 + Rust              |
| Frontend         | React + TypeScript + Vite   |
| Jira integration | Jira REST API v3            |
| AI summaries     | Ollama (local, optional)    |
| Storage          | SQLite (drafts and history) |
| Styling          | Tailwind CSS                |

## Architecture

Ticket Handoff is a Tauri 2 desktop app. The Rust backend owns Jira API communication (authenticating requests with Basic authentication using the email and API token stored in macOS Keychain), draft persistence to SQLite, and Ollama integration for summary generation. The React frontend has Home, New Escalation, History, and Settings routes; New Escalation renders the ticket context, checklist, and generated notes alongside the support tool the engineer is already using. Keyboard shortcuts are documented in `KEYBOARD_SHORTCUTS.md` for fast escalation workflows.

## License

MIT

See [CONTRIBUTING.md](CONTRIBUTING.md#verification) for focused tests, type/build checks, native prerequisites, and the managed verification contract.
