// Read-only API exposing Item fields not covered by any existing custom API (confirmed via
// direct BC Page Inspector checks, and confirmed correct by Karen, who built the original NAV
// implementation this data is meant to line up with):
//   - Line Up Season: custom field added by RGMC Base Extension (TableExt "RGMC Retail Item",
//     field 50100) - this app depends on RGMC Base Extension to reference it.
//   - LSC Attrib. 1-5 Code: custom fields added by LS Central (TableExt "LSC Item", fields
//     10001413-10001417) - this app depends on LS Central to reference them. Deliberately the
//     non-Obsolete set (LSC Attrib 1-5 Code, no period, IDs 10001406-10001410, are
//     ObsoleteState=Pending in favor of these) - per Karen's confirmation.
//   - Vendor Item No. / No. 2: standard Base Application fields, already on Item, just never
//     exposed through any custom API page before now.
//
// Not included here: a Product Group Code equivalent. The closest confirmed field
// ("LSC Retail Product Code") was only found on Item Ledger Entry (table 32), not on Item
// itself - still needs resolving before it can be added to this or another page.
//
// Distinct APIPublisher/APIGroup/EntitySetName from the existing "rgmc"/"rgmccustom" endpoints
// (items, itemFamily, etc.) - a separate app, so a separate identity, per Erwin's guidance to
// avoid the shared app's versioning conflicts. Object ID 51000 is from this app's own idRange
// (51000-51049) - confirm this range doesn't collide with any other installed extension in the
// target environment before publishing.

using Microsoft.Inventory.Item;

page 51000 "RGMC Item Attributes API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'itemAttribute';
    EntitySetName = 'itemAttributes';
    Caption = 'RGMC Item Attributes API';

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
            // --- Identity ---
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

            // --- Season ---
            field(lineUpSeason; Rec."Line Up Season")
            {
                Caption = 'lineUpSeason';
                Editable = false;
            }

            // --- Attributes ---
            field(attrib1Code; Rec."LSC Attrib. 1 Code")
            {
                Caption = 'attrib1Code';
                Editable = false;
            }
            field(attrib2Code; Rec."LSC Attrib. 2 Code")
            {
                Caption = 'attrib2Code';
                Editable = false;
            }
            field(attrib3Code; Rec."LSC Attrib. 3 Code")
            {
                Caption = 'attrib3Code';
                Editable = false;
            }
            field(attrib4Code; Rec."LSC Attrib. 4 Code")
            {
                Caption = 'attrib4Code';
                Editable = false;
            }
            field(attrib5Code; Rec."LSC Attrib. 5 Code")
            {
                Caption = 'attrib5Code';
                Editable = false;
            }

            // --- Vendor / secondary numbering ---
            field(vendorItemNo; Rec."Vendor Item No.")
            {
                Caption = 'vendorItemNo';
                Editable = false;
            }
            field(no2; Rec."No. 2")
            {
                Caption = 'no2';
                Editable = false;
            }

            // --- Audit ---
            field(lastModifiedDateTime; Rec.SystemModifiedAt)
            {
                Caption = 'lastModifiedDateTime';
                Editable = false;
            }
        }
    }
}
