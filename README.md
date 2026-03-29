# Ticket Handoff Assistant

[![TypeScript](https://img.shields.io/badge/TypeScript-%233178c6?style=flat-square&logo=typescript)](#) [![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](#) [![Platform](https://img.shields.io/badge/platform-macOS-lightgrey?style=flat-square)](#)

> Turn 30-minute escalation write-ups into 3-minute handoffs — with full context, no copy-pasting, and 50% fewer follow-up questions.

Ticket Handoff Assistant is a privacy-first desktop app for IT support engineers. It fetches ticket context from Jira automatically, lets you track troubleshooting steps interactively as you work, generates an AI summary of what worked and what didn't, and posts formatted escalation notes back to Jira in one click.

## Features

- **Auto Jira Fetch** — Enter a ticket ID and the app pulls summary, reporter, and current status directly from your Jira instance
- **Interactive Troubleshooting Checklists** — Track steps in real time as you work; the checklist becomes the basis for the escalation summary
- **AI Escalation Summaries** — Local AI generates a structured summary of actions taken, outcomes, and recommended next steps (optional, runs offline via Ollama)
- **One-Click Jira Post** — Post formatted markdown escalation notes back to the ticket without leaving the app
- **Draft Persistence** — Save and resume mid-escalation; handoffs survive interruptions and shift changes
- **File Attachments** — Attach screenshots or logs directly to Jira tickets from the app

## Quick Start

### Prerequisites

- Node.js 20+
- pnpm 9+
- Rust toolchain (stable) + Tauri v2 prerequisites for macOS
- Jira Cloud or Server instance with API token

### Installation

```bash
git clone https://github.com/saagpatel/TicketHandoff.git
cd TicketHandoff
pnpm install
cp .env.example .env
# Set JIRA_URL, JIRA_EMAIL, JIRA_API_TOKEN in .env
```

### Run (development)

```bash
pnpm dev
```

### Build (desktop app)

```bash
pnpm tauri build
```

## Tech Stack

| Layer | Technology |
|-------|------------|
| Desktop shell | Tauri 2 + Rust |
| Frontend | React + TypeScript + Vite |
| Jira integration | Jira REST API v3 |
| AI summaries | Ollama (local, optional) |
| Storage | SQLite (drafts and history) |
| Styling | Tailwind CSS |

## Architecture

Ticket Handoff is a Tauri 2 desktop app. The Rust backend owns Jira API communication (signing requests with the stored API token), draft persistence to SQLite, and Ollama integration for summary generation. The React frontend renders the ticket context, checklist, and generated notes in a focused single-screen layout designed to sit alongside whatever support tool the engineer is already using. Keyboard shortcuts are documented in `KEYBOARD_SHORTCUTS.md` for fast escalation workflows.

## License

MIT
