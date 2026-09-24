// Read-only API exposing Return Receipt Line fields confirmed to exist on BC's real table but
// never wired into whatever connector feeds bc_richfield_raw.returnReceiptLines today (confirmed
// via direct BC Page Inspector check - see bc-bq-data-integrity-handover.md, Section 6):
//   - Item Rcpt. Entry No. (field 39): the join key linking a return receipt line back to the
//     item ledger entry it applies to - NAV's int_richfield_item_ledger_entry_customer_item.sql
//     joins on this exact field (item_rcpt_entry_no).
//   - Item Charge Base Amount (field 5812): used by the same NAV model.
//   - Line Discount % (field 27): included for completeness, but it's a percent, not NAV's flat
//     discount amount - there's no direct equivalent of that on this table at all.
// All three are standard Base Application fields, not custom - no new table extension needed.
//
// documentNo/lineNo are included so this can be joined back to the existing returnReceiptLines
// sync (bc_richfield_raw.returnReceiptLines) once this lands in its own BigQuery table - Airbyte
// has no way to merge two different API sources into one table on its own.

using Microsoft.Sales.History;

page 51001 "RGMC Return Receipt Line Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'returnReceiptLineExtended';
    EntitySetName = 'returnReceiptLinesExtended';
    Caption = 'RGMC Return Receipt Line Extended API';

    SourceTable = "Return Receipt Line";
    ODataKeyFields = SystemId;

    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            // --- Identity / join keys ---
            field(id; Rec.SystemId)
            {
                Caption = 'id';
                Editable = false;
            }
            field(documentNo; Rec."Document No.")
            {
                Caption = 'documentNo';
                Editable = false;
            }
            field(lineNo; Rec."Line No.")
            {
                Caption = 'lineNo';
                Editable = false;
            }

            // --- The missing fields ---
            field(itemRcptEntryNo; Rec."Item Rcpt. Entry No.")
            {
                Caption = 'itemRcptEntryNo';
                Editable = false;
            }
            field(itemChargeBaseAmount; Rec."Item Charge Base Amount")
            {
                Caption = 'itemChargeBaseAmount';
                Editable = false;
            }
            field(lineDiscountPercent; Rec."Line Discount %")
            {
                Caption = 'lineDiscountPercent';
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
