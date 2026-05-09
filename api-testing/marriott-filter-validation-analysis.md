# Improper Filter Validation Causing Inconsistent API Response Behavior

**Target:** Marriott International

-----

## Summary

During testing of a public job-search API endpoint, inconsistent input validation behavior was observed within the `employment_type` filtering mechanism.

The backend accepted unexpected, empty, and unsupported filter values while continuing to return successful responses (HTTP 200 OK).

Instead of explicitly rejecting malformed input, the endpoint processed unsupported values and returned response patterns that differed from normal filtered requests.

Testing showed inconsistent server-side handling of filter input rather than confirmed unauthorized access, sensitive data exposure, or filter bypass.

-----

## Endpoint Tested

```
POST /api/get-jobs?radius=15&filter[employment_type][0]=FULL_TIME
POST /api/get-jobs?radius=15&filter[employment_type][0]=INVALID
POST /api/get-jobs?radius=15&filter[employment_type][1]=INVALID
POST /api/get-jobs?radius=15&filter[employment_type][0]=ALL
POST /api/get-jobs?radius=15&filter[employment_type][0]=
POST /api/get-jobs?radius=15&filter[employment_type][]=
POST /api/get-jobs?radius=15&filter[employment_type][1]=NULL
```

-----

## Testing Environment

- Public unauthenticated job-search functionality
- Testing performed through browser developer tools (Firefox DevTools — Network/XHR)
- Multiple request variations compared using response size, response timing, and response structure

-----

## Findings

### 1. Expected Filter Behavior

Supplying valid filter values returned expected filtered job listing responses.

**Example**

```
filter[employment_type][0]=FULL_TIME
```

**Observed behavior:**

- Endpoint returned HTTP 200 OK
- Response size was approximately 397 KB
- Normal filtered job results were returned

-----

### 2. Invalid Filter Handling

Supplying unsupported filter values resulted in inconsistent backend behavior.

**Example**

```
filter[employment_type][1]=INVALID
```

**Observed behavior:**

- Endpoint returned HTTP 200 OK
- Response size dropped significantly (approximately 657 B in observed requests)
- Response structure differed from valid filter requests
- Unsupported input was processed instead of being explicitly rejected

Similar behavior was observed when:

- Unsupported enum values were supplied
- Filter indexes were modified
- Alternate array positions were used

-----

### 3. Empty / Loose Validation Cases

Additional tests showed that malformed or loosely structured filter values did not consistently fail validation.

**Examples**

```
filter[employment_type][0]=
filter[employment_type][]=
filter[employment_type][1]=NULL
```

**Observed behavior included:**

- Request accepted successfully
- Endpoint continued returning HTTP 200 OK
- Response behavior differed from valid filter requests
- Malformed input was processed instead of explicitly rejected with validation errors

-----

## Response Size Pattern

|Filter Value    |Status|Response Size|Behavior                            |
|----------------|------|-------------|------------------------------------|
|`FULL_TIME`     |200 OK|~397 KB      |Valid filtered results returned     |
|`PART_TIME`     |200 OK|~209 KB      |Valid filtered results returned     |
|*(empty string)*|200 OK|~408 KB      |Default fallback — all jobs returned|
|`ALL`           |200 OK|~657 B       |Minimal response — no explicit error|
|`INVALID`       |200 OK|~657 B       |Silent failure — no validation error|
|`NULL`          |200 OK|~657 B       |Silent failure — no validation error|

-----

## Technical Analysis

The backend appeared to accept loosely structured filter input without strict server-side validation of:

- Accepted filter values
- Array structure consistency
- Empty parameter handling
- Unsupported enumeration values

Instead of rejecting malformed input with explicit validation errors, the endpoint frequently processed unsupported values and returned alternate response patterns.

Testing did not confirm:

- Unauthorized access
- Privilege escalation
- Sensitive data exposure
- Definitive filter bypass

However, the behavior demonstrated inconsistent backend input validation and weak parameter handling.

-----

## Security Impact

Although the endpoint involved public job listing data rather than authenticated or sensitive information, weak validation behavior may still indicate broader input-handling inconsistencies within backend filtering logic.

**Potential concerns include:**

- Inconsistent backend filtering behavior
- Increased attack surface for parameter manipulation
- Unexpected fallback states
- Weak server-side validation practices

In larger authenticated systems, similar validation weaknesses could potentially affect more sensitive filtering or access-control logic.

-----

## Severity Assessment

**Suggested Severity:** Informational / Low

**Reasoning:**

- No sensitive data exposure was confirmed
- No authentication or authorization bypass was observed
- The issue affects public job listing functionality only
- The behavior primarily reflects weak input validation and inconsistent backend handling

-----

## Reproduction Steps

1. Open the public Marriott job search page at `https://careers.marriott.com/jobs`
1. Open browser developer tools and navigate to the **Network** tab, filtered to **XHR**
1. Trigger a job search to capture the `POST /api/get-jobs` request
1. Right-click the request and select **Edit and Resend**
1. Modify the `filter[employment_type]` parameter with the following values in separate requests:
- `FULL_TIME` — baseline valid request
- `INVALID` — unsupported enum value
- `NULL` — null string value
- `ALL` — boundary enum value
- *(empty string)* — empty value
- `filter[employment_type][]=` — malformed array key
1. Compare returned status codes, response sizes, and response structures across all variations

-----

## Test Statistics

|Metric                                  |Value      |
|----------------------------------------|-----------|
|Total Requests Sent                     |~29        |
|Data Transferred                        |~1.01 MB   |
|Total Test Duration                     |~40 minutes|
|HTTP Errors Observed                    |0          |
|Silent Failures (200 + minimal response)|Multiple   |

-----

## Research Notes

This assessment was useful for examining:

- Backend filter validation behavior
- Parameter manipulation testing
- Array-based query handling
- Differences between expected filter logic and server-side processing
- Response comparison methodology

The testing process showed how malformed filter structures may trigger alternate backend behavior even when no direct security impact is immediately visible.

-----

## Skills Demonstrated

- API testing
- Parameter manipulation
- Input validation assessment
- Backend behavior observation
- Response comparison methodology
- Web application security research

## Evidence

<img width="1366" height="768" alt="_" src="https://github.com/user-attachments/assets/32234e5d-2821-49ba-a947-6cdc717051b3" />

<img width="1366" height="768" alt="0invalid vs 1 invalid 2" src="https://github.com/user-attachments/assets/cdac5908-5c5e-4ba8-ab35-56be630fbb97" />

<img width="1366" height="768" alt="IMG_5351" src="https://github.com/user-attachments/assets/6ae8cf78-19d7-42dc-a2a1-f2b3921137da" />

