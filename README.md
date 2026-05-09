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

**[SQL Injection Practice System](projects/security%20labs/readme.md)**

- Built a custom vulnerable e-commerce web application to practice SQL injection techniques
- Implemented attack scenarios in `attack.py` against a vulnerable `app.py` Flask application
- Used SQLite (`AAA.db`) for realistic query behavior testing
- Includes HTML templates (`Templates/ABC.html`) for realistic frontend simulation

-----

### Tools

**[Recon Script](tools/recon-tools/recon.sh)**

- Built a Bash-based reconnaissance tool for endpoint discovery
- Automates basic recon workflow during web application testing

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