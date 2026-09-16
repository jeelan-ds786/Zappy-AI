# Security Policy

## Supported scope

SkyPulse is an educational prototype using reviewed public content and synthetic account data. It
is not connected to Sky customer systems and must not be used to process real customer accounts,
payments, claims, identity documents, or credentials.

## Data boundaries

- Never commit secrets, access tokens, generated transcripts, or real customer PII.
- Never scrape authenticated Sky pages. Account capabilities require authorized APIs and remain
  synthetic until such access is provided.
- Browser recordings stay on the client in the current demo. Only the recognized transcript is
  submitted to the agent API.
- Public catalog and Protect plan data must never be represented as live policy or claim data.
- Irreversible actions require an explicit confirmation layer before any real connector is added.

## Reporting

Report vulnerabilities privately to the repository owner. Include reproduction steps, affected
versions, and impact. Do not include real credentials or customer data in a report.