# Improper Filter Validation Leading to Unintended Job Listing Exposure

## Target
Marriott International

---

# Summary

During testing of a public job-search API endpoint, inconsistent filter validation behavior was identified within the employment type filtering mechanism.

The endpoint accepted unexpected or invalid filter values and returned broader job listing results instead of rejecting malformed input or enforcing strict validation.

Testing demonstrated that invalid or empty filter values could alter application behavior and produce responses inconsistent with expected filtering logic.

---

# Endpoint Tested

```http
GET /api/get-jobs
```

Example observed requests:

```http
get-jobs?radius=15&filter[employment_type][0]=FULL_TIME
```

```http
get-jobs?radius=15&filter[employment_type][1]=INVALID
```

```http
get-jobs?radius=15&filter[employment_type][]=
```

---

# Testing Environment

- Public unauthenticated job-search functionality
- Testing performed through browser developer tools
- Multiple request variations compared using response size, response timing, and returned result sets

---

# Findings

## 1. Expected Filter Behavior

Supplying valid filter values returned appropriately filtered job listings.

### Example

```http
filter[employment_type][0]=FULL_TIME
```

Returned:
- Only FULL_TIME job listings
- Approximate response size: 397 KB

---

## 2. Invalid Filter Handling

Supplying invalid filter values resulted in inconsistent behavior.

### Example

```http
filter[employment_type][1]=INVALID
```

Observed behavior:
- Endpoint returned significantly broader results
- Response size increased substantially (~657 KB)
- Filtering restrictions appeared bypassed

Similar behavior occurred when:
- Empty filter values were supplied
- Unexpected array structures were used
- Filter indexes were modified

---

## 3. Empty / Loose Validation Cases

Additional tests showed that malformed filter structures did not consistently fail validation.

### Examples

```http
filter[employment_type][0]=
```

```http
filter[employment_type][]=
```

Observed behavior included:
- Unfiltered or partially filtered result sets
- Larger response sizes than expected
- Different application behavior despite invalid input structure

---

# Technical Analysis

The application appeared to trust loosely structured filter input without strict server-side validation of:

- Accepted filter values
- Array structure consistency
- Empty parameter handling
- Invalid enumeration enforcement

Instead of rejecting malformed input, the endpoint frequently defaulted to broader result behavior.

Testing did not reveal direct sensitive data exposure; however, the behavior demonstrated inconsistent backend filtering logic.

---

# Security Impact

Although the endpoint involved public job listing data rather than sensitive authenticated information, weak validation behavior may still indicate broader input-handling inconsistencies within backend filtering mechanisms.

Potential concerns include:

- Unintended data exposure through filter bypass behavior
- Increased attack surface for parameter manipulation testing
- Backend logic inconsistencies
- Weak server-side validation practices

In larger authenticated systems, similar validation weaknesses could potentially affect sensitive filtering logic or authorization-related controls.

---

# Severity Assessment

Suggested Severity: Informational / Low

### Reasoning

- No sensitive data exposure was confirmed
- Behavior affected public job listing data
- No authentication or authorization bypass identified
- Issue primarily demonstrates weak filter validation and inconsistent backend logic handling

---

# Research Notes

This case was useful for analyzing:

- Backend filter validation behavior
- Parameter manipulation testing
- Array-based query handling
- Differences between frontend filtering and backend enforcement
- Logic flaw discovery methodology

The testing process also highlighted how malformed input structures may trigger unexpected backend behavior even when no direct vulnerability is immediately visible.

---

# Skills Demonstrated

- API testing
- Parameter manipulation
- Logic flaw analysis
- Backend behavior observation
- Response comparison methodology
- Input validation testing
- Web application security research