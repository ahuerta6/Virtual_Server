[← Local AI](README.md)

# Roadmap

These items came from project discussions. They are requirements and design goals unless explicitly marked implemented elsewhere.

## Durable notes and context profiles

Maintain compact project notes and reusable profiles covering role, audience, working style, preferences, stable facts, and constraints. Record decisions and unresolved work so the assistant can resume a project without relying on an ever-growing chat.

Chat history is not guaranteed automatic cross-chat memory. Preferences and stored context do not grant permission to execute actions.

## Scoped local document access

Explore a local file assistant that searches document contents as well as names, so differently titled files can still be found. The discussed scope was user documents, with a user prompt initiating work and a persistent folder grant avoiding repeated approval for each read inside that scope.

The requested export behavior is to copy selected documents to a USB device while preserving the originals. Platform integration, permission enforcement, destination checks, and implementation remain to be designed and verified.

## Portable application

Package another copy of the local AI for installation on other computers. Platform, architecture, and distribution format have not been selected.

Design requirements include onboarding, explicit resource permissions, revocation, reusable profiles, durable notes, and a clear explanation of local inference versus optional external services. Existing infrastructure credentials and human approval certificates must not be bundled into a distributable application.

## Defensive review and reliability

- Recheck current firewall rules and IPv6 behavior before making isolation claims.
- Design separate disposable lab networks for testing.
- Plan defensive inventory, patch/configuration review, and log review within explicitly authorized scope.
- Validate full host boot behavior and GPU device discovery.
- Measure realistic prompts through Open WebUI and evaluate answer correctness alongside latency.
