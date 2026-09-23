# Reference: existing custom API endpoint pattern (from Erwin's RGMC Base Extension / RGMC_AL_v2)

Saved before deleting the local `RGMC_AL_v2`/`RGMC_AL_v2_fresh` clones, so the pattern isn't lost.
This is Erwin's app, not ours — copied here purely as a style/structure reference for building
our own endpoints consistently. Do not reuse his APIPublisher/APIGroup/object IDs.

## Example: a simple read-only item API page (source: `source/RGMCItems/50205LSCRetailItemAPI.al`)

```al
using Microsoft.Inventory.Item;

page 50205 "LSC Retail Item API"
{
    PageType = API;
    APIPublisher = 'rgmc';
    APIGroup = 'rgmccustom';
    APIVersion = 'v1.0';
    EntityName = 'item';
    EntitySetName = 'items';
    Caption = 'LSC Retail Item API';

    SourceTable = Item;
    ODataKeyFields = SystemId;

    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field(id; Rec.SystemId)
            {
                Caption = 'id';
                Editable = false;
            }
            field(number; Rec."No.")
            {
                Caption = 'number';
                Editable = false;
            }
            field(itemCategoryCode; Rec."Item Category Code")
            {
                Caption = 'itemCategoryCode';
                Editable = false;
            }
            field(familyCode; Rec."LSC Item Family Code")
            {
                Caption = 'familyCode';
                Editable = false;
            }
            field(lastModifiedDateTime; Rec.SystemModifiedAt)
            {
                Caption = 'lastModifiedDateTime';
                Editable = false;
            }
            // ... more fields, same shape: field(camelCaseName; Rec."BC Field Caption")
        }
    }
}
```

**Pattern to follow:**
- `PageType = API`, read-only via `InsertAllowed/ModifyAllowed/DeleteAllowed = false`
- Always expose `id` (`Rec.SystemId`) and a `lastModifiedDateTime` (`Rec.SystemModifiedAt`)
- One `field()` block per exposed column, `camelCase` API name mapped to the real BC `"Field Caption"`
- `ODataKeyFields = SystemId`

## Example: a custom field added via table extension (source: `source/RGMCRetailItem/RetailItem.tableext.al`)

```al
tableextension 50124 "RGMC Retail Item" extends "Item"
{
    fields
    {
        field(50100; "Line Up Season"; Code[20])
        {
            Caption = 'Line Up Season';
            DataClassification = CustomerContent;
        }
    }
}
```

This is how `Line Up Season` (a custom field, not standard BC) got added to the Item table in
the first place — relevant if we ever need to add our own new custom field rather than just
expose an existing one.

## Known existing custom API objects in Erwin's app (v1.0 namespace, `rgmc`/`rgmccustom`)

Confirmed by scanning `RGMC_AL_v2` directly (fresh clone, commit `d56b506`, "Version 28"):

| File | Page ID | EntitySetName |
|---|---|---|
| `50200LSCRetailCustomerAPI.al` | 50200 | (customers) |
| `50201LSCRetailSalesReturnOrderAPI.al` | 50201 | salesReturnOrders |
| `50202LSCRetailSalesReturnOrderLinesAPI.al` | 50202 | salesReturnOrderLines |
| `50203LSCRetailContactAPI.al` | 50203 | contacts |
| `50204LSCRetailContactPictureAPI.al` | 50204 | (contact pictures) |
| `50205LSCRetailItemAPI.al` | 50205 | items |
| `50206LSCRetailItemFamilyAPI.al` | 50206 | (item family) |
| `50209RGMCContactBrandTagAPI.al` | 50209 | (contact brand tag) |
| `50210RGMCItemPriceAPI.al` | 50210 | (item price) |
| `50216RGMCSalesOrderAPI.al` | 50216 | (sales order) |
| `50217RGMCSalesOrderLinesAPI.al` | 50217 | (sales order lines) |

Plus a separate v2.0/v3.0 set (`items` v2, `priceListHeaders`, `priceListLines`, `itemLedgerEntries`,
etc., pages 50310-50340ish) that live in yet another, different AL project we don't have cloned —
per Erwin: "may mga modifications ako sa existing endpoints ko na nasa ibang al project na."

**Takeaway for our own app**: our object ID range and APIPublisher/APIGroup must avoid colliding
with both of these — the ones listed above AND the higher v2/v3 set we've only seen through
`rgmc-bc-api`'s existing routers, not through source we've read directly.
