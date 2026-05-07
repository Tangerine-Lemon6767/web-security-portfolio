
# IDOR in Wishlist Functionality Leading to Unauthorized Access

## Summary

During testing of a wishlist feature, an insecure direct object reference (IDOR) issue was identified by modifying a numeric identifier in the request.

By changing the wishlist ID from one value to another, it was possible to access another user's wishlist without authorization.

Additionally, items from the unauthorized wishlist could be imported into the tester's own account.

---

## Vulnerability Type

- Insecure Direct Object Reference (IDOR)
- Broken Access Control

---

## Testing Scenario

A wishlist request contained a numeric identifier similar to:

http GET /wishlist?id=2344 

The identifier was manually modified:

http GET /wishlist?id=2346 

The server returned a different user's wishlist instead of rejecting the request.

---

## Observed Behavior

The unauthorized wishlist contained multiple items, including products marked as in stock.

The application also allowed importing wishlist items into the tester's own account, demonstrating insufficient authorization checks on wishlist ownership.

---

## Expected Behavior

The application should verify that:
- the authenticated user owns the requested wishlist
- unauthorized wishlist identifiers cannot be accessed

---

## Actual Behavior

Changing the numeric identifier allowed access to another user's wishlist data without authorization.

---

## Security Impact

This issue may allow attackers to:
- access other users' saved items
- enumerate wishlist identifiers
- interact with data belonging to other accounts

If additional functionality exists (edit/delete/share), the impact could increase further.

---

## Notes

Testing was stopped after confirming unauthorized access in order to avoid affecting another user's data or modifying resources outside the permitted scope.

## Evidence

![IDOR Evidence](idor-proof.png)