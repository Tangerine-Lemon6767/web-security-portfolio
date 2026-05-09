# Client-Side Session Persistence Leading to Cross-Account Favorite and Booking Visibility

## Target
[Marriott International]

---

# Summary

During testing of authenticated user flows, user-specific data was observed to persist across account changes within the same browser session.

After logging out from one account and logging into another account using the same browser, the second user was still able to view and interact with data associated with the previous user session.

The issue affected:

- My Favorites
- Booking-related session state
- Previously loaded booking information

Investigation indicated that the behavior was related to client-side session/storage persistence rather than a confirmed server-side authorization bypass.

---

# Testing Environment

- Two separate user accounts were created for testing
- Testing was performed using the same browser session
- Additional testing was performed using a separate browser/device for comparison

---

# Findings

## 1. Favorites Persistence Across Accounts

### Steps to Reproduce

1. Login as User A
2. Add items into **My Favorites**
3. Logout from User A
4. Login as User B using the same browser
5. Navigate to **My Favorites**

### Observed Behavior

User B was able to:

- View favorites previously created by User A
- Modify favorite entries associated with the previously loaded browser state

Changes made under User B appeared to affect the persisted favorites state originally created under User A within the same browser environment.

---

## 2. Booking Session Persistence

Additional testing showed similar persistence behavior involving booking-related state.

### Observed Behavior

- Booking/session-related information remained available after account switching
- Session/browser identifiers appeared reused between authenticated users in the same browser context
- Previously loaded booking information remained visible after switching accounts

Because booking operations may involve real reservations and financial impact, no destructive testing or booking modification attempts were performed.

---

# Technical Analysis

Browser-side investigation showed:

- Persistent values stored within browser storage/session mechanisms
- Session/browser identifiers remained available after logout
- User-related state remained accessible across account transitions within the same browser

No direct evidence of confirmed server-side Broken Access Control was identified during testing.

The observed behavior appears related to insufficient client-side state invalidation after logout.

---

# Security Impact

Although no confirmed server-side authorization bypass was demonstrated, the behavior may still create privacy and security concerns in shared-browser or shared-device scenarios.

Potential risks include:

- Exposure of previous user activity to subsequent users
- Accidental modification of persisted user-specific preferences
- Confusion regarding account/session isolation
- Possible unintended interaction with cached booking/session state

If similar persistence behavior were to affect sensitive server-side authenticated flows, the impact could become significantly more severe.

---

# Severity Assessment

Suggested Severity: Informational / Low

### Reasoning

- No confirmed server-side access control bypass
- Behavior appears primarily client-side persistence related
- Potential privacy implications exist on shared-device environments

---

# Research Notes

This case was useful for analyzing the distinction between:

- Client-side persistence
- Browser storage behavior
- Session invalidation
- Broken Access Control vs frontend state confusion

The testing process also highlighted the importance of validating whether sensitive information originates from:

- Browser-side cached/local storage
or
- Server-side authenticated responses

---

# Skills Demonstrated

- Session analysis
- Browser storage inspection
- Authenticated flow testing
- Client-side vs server-side validation analysis
- Logic flaw investigation
- Web application security testing methodology

## Evidence

<img width="1366" height="768" alt="IMG_5349" src="https://github.com/user-attachments/assets/4591cba4-3234-4968-8141-01296a076550" />
<img width="1366" height="768" alt="IMG_5344" src="https://github.com/user-attachments/assets/fb2482f4-0c52-4f26-afa3-1cde2545d823" />
<img width="1366" height="768" alt="IMG_5346" src="https://github.com/user-attachments/assets/a1810dff-0200-4128-bab1-ba29c45b8c0b" />
<img width="1366" height="768" alt="IMG_5339" src="https://github.com/user-attachments/assets/a121b091-b02b-432c-a414-69e6c83b72e2" />
<img width="1366" height="768" alt="IMG_5332" src="https://github.com/user-attachments/assets/1e187471-14cf-4623-aee6-342eaf56e4a0" />
<img width="1366" height="768" alt="IMG_5335" src="https://github.com/user-attachments/assets/b604d151-1d7c-44b5-82c2-a88fdb75e7e0" />
<img width="1366" height="768" alt="lara local storage booking" src="https://github.com/user-attachments/assets/b145f1f6-83c9-4080-8a6d-aec1545c2432" />
<img width="1366" height="768" alt="lara booking cookie" src="https://github.com/user-attachments/assets/fc8b9b00-d254-4add-9fb9-d5bc8a28d550" />


