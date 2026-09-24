# RGMC BC Custom Connector — Handover

**Date:** 2026-09-24
**Status:** AL source written, not yet compiled or published. Nothing tested or published without explicit go-ahead — per standing instruction for this project.

---

## 1. Why this exists

BC's item-related data model is missing several fields that the old NAV implementation relied on
(`season_code`, `attrib_1-5_code`, `vendor_item_no`, `no_2` — confirmed by Karen, who built the
original NAV side, as the fields the dbt int-layer rebuild needs). These fields exist and are
populated on BC's real `Item` table (confirmed via direct BC Page Inspector checks), but are not
exposed through any existing custom API — not the standard `items` OData API, not RGMC's own
custom `items` v1/v2 APIs (Pag50205/Pag50310).

Erwin (owns the existing shared custom API surface, "RGMC Base Extension" + a second app "RGMC
API Extension") recommended a **separate AL app** rather than adding to his, specifically to avoid
his own versioning headaches ("medyo magulo yung shared al project dahil sa versioning"). Confirmed
with him directly: separate app, separate name, separate ID — not building on top of his.

## 2. What's been decided

| Item | Decision |
|---|---|
| Repo | `github.com/Aaron-Alvarez-RGMC/custom-connector-AL` (your own, separate from Erwin's `RGMC_AL_v2`) |
| App ID | `f26e37c0-6ec1-40c0-be12-1894c19cfae5` (freshly generated, unique) |
| App name | `RGMC BC Custom Connector` — deliberately broad/scalable, not item-scoped, since more BC tables' APIs are planned |
| Publisher | `Aaron Alvarez` |
| Object ID range | `51000-51049` — **confirmed clear by Erwin** against his own two apps (`50100`-ish for RGMC Base Extension, `50300-50499` for RGMC API Extension) and the full Extension Management list you pulled |
| API namespace | `aaronalvarez` / `customConnector` / `v1.0` — deliberately **not** reusing Erwin's `rgmc`/`rgmccustom`, to avoid ever touching his versioning again |
| First endpoint | `itemAttributes` (page `51000`) — read-only, exposes `lineUpSeason`, `attrib1Code`-`attrib5Code`, `vendorItemNo`, `no2` off the `Item` table |
| Not included yet | A product-group-code equivalent — the only confirmed field for that (`LSC Retail Product Code`) was found on **Item Ledger Entry**, not Item itself. Needs separate resolution before it can be added anywhere. |

## 3. Current file state (`custom-connector-AL/`)

```
app.json                                — app manifest, see above
.vscode/launch.json                     — gitignored, local only
source/ItemAttributesApi.Page.al        — the new page, read-only (Insert/Modify/DeleteAllowed = false)
reference/existing-endpoint-pattern.md  — Erwin's endpoint pattern + known object IDs, saved before
                                           deleting the local RGMC_AL_v2 clones (no longer needed)
```

`.alpackages/` has real downloaded symbol packages now (see Section 5 — this is exactly what needs
resolving before compiling).

## 4. The `rgmc-bc-api` side — diff written, NOT deployed

In the `rgmc-bc-api` repo (separate from this one), already added but not run/tested/deployed:

- `src/services/bc_functions.py` — new `call_custom_connector_table()` / `custom_connector_get_record()`,
  mirroring the existing `call_rgmc_table` pattern, using a new `_CUSTOM_CONNECTOR_API` constant
  pointed at our namespace instead of Erwin's.
- `src/routers/bc_routes/custom_connector_item_attributes_routes.py` — new router,
  `GET /bc/custom-connector/item-attributes` (list) and `/{record_id}` (single).
- Wired into `src/routers/bc_routes/__init__.py`, `src/routers/__init__.py`, `src/main.py`.

This only becomes runnable once the AL page above is actually published to BC — right now it would
502 since the BC-side endpoint doesn't exist yet.

## 5. Target environment: `TEST`, deliberately — not UAT

`launch.json` targets `"TEST"`, not `"UAT"` — confirmed deliberate: UAT sits next to Production, so
new/unpublished work is meant to go through `TEST` first instead, one step further removed from
Production. Explains the dependency version differences from what we'd seen before under UAT:
`RGMC Base Extension 1.2.0.3` (UAT's is `1.2.0.8`), `Base Application 28.5.54151.54891` (UAT's is
`28.4.53241.54676`), `LS Central 28.2.0.1847` (UAT's is `28.2.6.4060`) — `TEST` is a genuinely
different, independently-patched sandbox, and `app.json`'s dependency versions now correctly
reflect `TEST`'s actual state.

**Worth double-checking before publishing** (not blocking, just not yet confirmed): the
`51000-51049` ID range Erwin confirmed was almost certainly checked against UAT/the main tenant
state — worth a quick sanity check that nothing on `TEST` specifically collides, since it's a
separate environment with its own installed-extension state.

## 6. Next steps, in order

1. Compile-check only (`Ctrl+Shift+B` / `AL: Package`) — no publish yet.
2. Only with explicit go-ahead: publish to sandbox, then verify the `itemAttributes` endpoint
   responds, then flip on the `rgmc-bc-api` router.
3. Tell Erwin which endpoint was actually added (he asked to be kept informed).
4. Once this works end-to-end, resume the dbt int-layer work (`int_bc_richfield_item_ledger_entry_
   customer_item`, `int_bc_richfield_transfer_shipment_header_line_item`,
   `int_bc_richfield_trans_sales_entry_customer_item`) that's currently blocked on these fields.
