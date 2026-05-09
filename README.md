# Web Security Portfolio

Hands-on web security portfolio: API testing, authentication analysis, and vulnerability research.

-----

## About

Junior web security researcher with hands-on experience in API testing, authentication flow analysis, and identifying input validation weaknesses in web applications. Self-taught through independent research, real-world application testing, and hands-on lab work.

-----

## Projects

### API Testing

**[Marriott — Improper Filter Validation Analysis](api-testing/marriott-filter-validation-analysis.md)**

- Tested `filter[employment_type]` parameter behavior on a live public API endpoint
- Identified silent failure behavior where invalid, null, and empty values returned HTTP 200 instead of proper validation errors
- Documented response size patterns to distinguish valid, invalid, and fallback states
- Severity: Informational/Low — public endpoint, no sensitive data exposure confirmed

**[IDOR — Wishlist Analysis](api-testing/idor-wishlist-analysis.md)**

- Analyzed object reference handling in wishlist functionality
- Explored access control behavior across user-specific endpoints

-----

### Authentication & Session Analysis

**[Marriott — Session Persistence Analysis](client-side-session-analysis/marriott-session-persistence.md)**

- Analyzed session token handling and client-side storage behavior
- Observed authentication flow and explored potential weaknesses in session persistence

-----

### Labs

**[SQL Injection Practice System](projects/security-labs/readme.md)**

- Built a custom vulnerable e-commerce web application to practice SQL injection techniques
- [`app.py`](projects/security-labs/app.py) — vulnerable Flask application
- [`attack.py`](projects/security-labs/attack.py) — attack scripts demonstrating SQL injection techniques
- [`AAA.db`](projects/security-labs/AAA.db) — SQLite database for realistic query behavior testing
- [`templates/ABC.html`](projects/security-labs/templates/ABC.html) — frontend simulation
- [`project.py`](projects/security-labs/project.py) — full project entry point

-----

### Tools

**[Recon Script](tools/recon-tools/recon.sh)**

- Built a Bash-based reconnaissance tool for endpoint discovery
- Automates basic recon workflow during web application testing
- [View documentation](tools/recon-tools/READMErecon.md)

-----

## Skills

- API Testing & Parameter Manipulation
- Input Validation Assessment
- Authentication & Session Analysis
- Reconnaissance & Endpoint Discovery
- Response Behavior Comparison
- SQL Injection (Practice)
- Basic Scripting (Python & Bash)

-----

## Tools

- `curl` — HTTP request crafting and parameter fuzzing
- `katana` — Web crawling and endpoint discovery
- `waybackurls` — Historical URL reconnaissance
- Browser DevTools — XHR analysis and request replay
- Python — Scripting and vulnerable lab environments
- Linux CLI / Bash — Automation and recon workflows

-----

## Focus Areas

- API Security
- Access Control
- Authentication Weaknesses
- Input Validation
