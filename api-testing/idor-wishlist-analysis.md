# IDOR in Wishlist Functionality Leading to Unauthorized Access

**Target:** REI Co-op (rei.com)  
**Tested By:** redhoodsec  
**Date:** April 17, 2026  
**Severity:** Low–Medium  
**CWE:** CWE-284 – Improper Access Control  
**OWASP:** A01:2021 – Broken Access Control  
**Bug Bounty Scope:** Out of scope — documented for portfolio purposes only

-----

## Important Note

This finding was discovered during informal testing prior to reviewing REI’s bug bounty scope. REI’s program explicitly excludes wish list functionality. No malicious action was taken, no sensitive data was accessed or retained, and testing was stopped immediately after confirming the issue to avoid affecting another user’s data.

-----

## Summary

During testing of the REI wish list feature, an Insecure Direct Object Reference (IDOR) was identified by modifying a numeric identifier in the URL path. By changing the wish list ID from one value to another, it was possible to access another user’s wish list without authorization. Additionally, items from the unauthorized wish list could be added to the tester’s own shopping cart, demonstrating insufficient authorization checks on wish list ownership.

The access control enforcement was found to be **inconsistent** — some list IDs correctly block unauthorized access while others do not — suggesting the check depends on a per-list privacy flag set by the owner rather than a blanket server-side ownership validation.

-----

## Vulnerability Details

|Field                |Detail                                                |
|---------------------|------------------------------------------------------|
|**Type**             |Insecure Direct Object Reference (IDOR)               |
|**CWE**              |CWE-284: Improper Access Control                      |
|**OWASP Category**   |A01:2021 – Broken Access Control                      |
|**Affected Endpoint**|`https://www.rei.com/lists/{id}`                      |
|**ID Format**        |Sequential integer (e.g. `/lists/2344`, `/lists/2346`)|
|**Auth Required**    |No — accessible while logged into a different account |

-----

## Testing Scenario

The wish list endpoint uses a numeric ID in the URL path:

```
GET https://www.rei.com/lists/2344
```

The identifier was manually incremented:

```
GET https://www.rei.com/lists/2346
```

The server returned a different user’s wish list contents instead of rejecting the request.

-----

## Steps to Reproduce

1. Log into REI as Account A (attacker account).
1. Navigate to your own wish list — note the numeric ID in the URL (e.g. `/lists/2344`).
1. Manually change the ID in the URL bar to a different value (e.g. `/lists/2346`).
1. Observe that some IDs are blocked while others expose another user’s full wish list.
1. Click **“Add to cart”** on an available item from the exposed list.
1. Confirm the item is added to the attacker’s cart.

-----

## Expected Behavior

The application should verify that:

- The authenticated user owns the requested wish list
- Unauthorized wish list IDs cannot be accessed regardless of the list’s privacy setting

## Actual Behavior

Changing the numeric ID in the URL allowed access to another user’s wish list without any authorization check, and allowed items from that list to be added to a different user’s cart.

-----

## Observed Behavior

### List 2344 — Access Correctly Blocked

Navigating to `/lists/2344` while authenticated as a different user returned:

> *“This list is not publicly available.”*

This is the expected, correct behavior.

### List 2346 — Access Control Not Enforced

Navigating to `/lists/2346` returned the **full wish list contents** of another account (7 items), including:

- Vargo Titanium Hexagon Backpacking Wood Stove — No longer available
- **Lodge Dutch Oven - 4 qt. (#7142490015) — In stock, $74.95**
- SOL Mag Striker — No longer available
- SOL Fire Lite Kit — No longer available
- 3 additional items

### Cart Manipulation Confirmed

Clicking “Add to cart” on the Lodge Dutch Oven successfully added it to the attacker’s cart — confirmed by the “Added to cart” modal and the cart page showing the item at $74.95.

-----

## Security Impact

This issue may allow an attacker to:

- **Enumerate other users’ wish lists** by iterating sequential, predictable IDs
- **View saved products** belonging to other REI members
- **Add items from another user’s list** to their own cart

If additional wish list actions exist (edit, delete, share, purchase on behalf), the impact could increase significantly. The use of sequential integer IDs also makes automated enumeration trivial.

-----

## Root Cause

The endpoint uses sequential, predictable integer IDs with no server-side check verifying that the requesting user owns the list. Access control appears to rely on a per-list privacy flag rather than ownership validation, producing inconsistent results across list IDs.

-----

## Recommendation

1. **Implement server-side ownership validation** on all `/lists/{id}` requests — verify the authenticated user owns or has been explicitly granted access to the list, regardless of its privacy setting.
1. **Replace sequential IDs with UUIDs** (e.g. `/lists/a3f9c2d1-4b8e-...`) to eliminate enumeration risk even if access control gaps exist.
1. **Apply access control uniformly** across all list IDs — the inconsistency between blocked and accessible IDs indicates the check is not globally enforced.

-----

## Evidence

Screenshots are available showing:

|Screenshot|Time |Description                                              |
|----------|-----|---------------------------------------------------------|
|IMG_5121  |11:46|List 2344 — access blocked (correct behavior)            |
|IMG_5122  |11:49|List 2346 — another user’s 7-item wish list fully visible|
|IMG_5123  |11:56|Item added to cart from unauthorized list                |
|IMG_5124  |11:58|Cart confirms Lodge Dutch Oven added ($74.95)            |

*Account usernames and identifying information have been blurred in all screenshots.*

-----

## References

- [OWASP: IDOR](https://owasp.org/www-chapter-ghana/assets/slides/IDOR.pdf)
- [CWE-284: Improper Access Control](https://cwe.mitre.org/data/definitions/284.html)
- [OWASP A01:2021 – Broken Access Control](https://owasp.org/Top10/A01_2021-Broken_Access_Control/)
- [PortSwigger: Insecure Direct Object References](https://portswigger.net/web-security/access-control/idor)

-----

*This report is produced for educational and portfolio purposes. Testing was performed using accounts owned by the tester. No data was exfiltrated, no resources were modified, and no other users were harmed.*

## Evidence

<img width="1280" height="719" alt="idor-proof1" src="https://github.com/user-attachments/assets/b1e8bb7e-52fe-4fe2-a2b1-bc00265b3e79" />
<img width="1280" height="656" alt="idor-proof2" src="https://github.com/user-attachments/assets/30a647c8-ebdc-4097-9668-f6f24263857b" />
<img width="1280" height="650" alt="idor-proof3" src="https://github.com/user-attachments/assets/0263f18e-24a9-4ae8-b0d3-6a26dd4745d5" />
<img width="1280" height="658" alt="idor-proof4" src="https://github.com/user-attachments/assets/fe87d926-8b0f-4ff6-84ac-188331800b6b" />
<img width="1280" height="615" alt="idor-proof5" src="https://github.com/user-attachments/assets/ff7e3d1e-2899-40cd-b6b7-61d0c39db697" />




