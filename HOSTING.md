# How to host an HTML file as a public link via GitHub Gist

A 4-step workflow for sharing a self-contained HTML artifact (dashboard, mockup, one-pager) without setting up a server, build pipeline, or DNS.

Used at Gainsight for Pulse 2026 demos.

---

## Prerequisites (one-time)

1. **Install the GitHub CLI**:
   ```bash
   brew install gh           # macOS
   # or: winget install --id GitHub.cli   on Windows
   # or: see https://cli.github.com/
   ```

2. **Authenticate**:
   ```bash
   gh auth login
   ```
   Choose `github.com` → `HTTPS` → authenticate via browser. Token stored in the system keychain. One-time only.

---

## Publish

3. **From the folder containing the HTML file**, create a public gist:
   ```bash
   gh gist create my_file.html --public --desc "Short description"
   ```
   The command prints the gist URL:
   ```
   https://gist.github.com/your-username/1a95279e93898ff141b9b4696301273b
   ```
   Copy the **hex ID at the end** of that URL.

4. **Wrap the gist ID with gistpreview** to get the rendered URL:
   ```
   https://gistpreview.github.io/?1a95279e93898ff141b9b4696301273b
   ```
   That's the shareable link. Anyone opens it and sees the HTML rendered as a webpage.

---

## Update later

```bash
gh gist edit <gist-id> my_file.html
```

Same gistpreview URL always serves the latest version. No re-deployment, no link change, no cache to bust on the host side (the visitor's browser may still cache — `Cmd+Shift+R` to hard-reload).

---

## How it works

- **GitHub Gist** — free, permanent, public file hosting from GitHub.
- **gistpreview.github.io** — small open-source service that fetches the raw gist content and renders it as HTML in the browser (instead of GitHub's default behavior of showing source code).
- **No build step**, no server, no DNS. Works for any single-file HTML with public-CDN dependencies (Tailwind, Chart.js, htmx, etc.).

---

## When to use something else

| Need | Use |
|---|---|
| Branded URL like `your-team.github.io/demo` | GitHub Pages (a real repo with Pages enabled) |
| Multiple files (JS, CSS, images split out) | GitHub Pages, Netlify, Vercel |
| Custom domain (`demo.yourcompany.com`) | GitHub Pages with custom domain, or Cloudflare Pages |
| Private to a logged-in team | Vercel/Netlify team, or GitHub Pages with private repo (Pro account) |
| Server-side API calls (real backend) | Cloudflare Worker, Vercel function, or full hosting platform |

---

## Caveats

- **gistpreview.github.io is a free community service**, not Gainsight-owned. Occasional outages happen. Pre-load the link on your demo laptop before going on stage.
- **Public gists are public.** Anyone who guesses or finds the URL can read the content. Don't embed secrets, API keys, or sensitive customer data.
- **CDN-loaded dependencies** (Tailwind, Chart.js) require internet. Open the page once on the demo machine ahead of time so the browser caches them.

---

*Workflow used for the PX × Skilljar adoption-gap dashboard at Pulse 2026.*
