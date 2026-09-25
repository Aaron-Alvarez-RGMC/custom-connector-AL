// Read-only API exposing Transaction Header fields confirmed to exist on the real record but not
// wired into RGMC_ERAR's RGMCTransactionHeaderAPIv2.Page.al (Pag50322) today. Confirmed live via
// Page Inspector on a real Covent (CGI) transaction, 2026-09-25:
//   - Transaction Type (field 10, LS Central) - needed to filter Sale-type transactions, matching
//     NAV's Trans. Header transaction_type = 2 filter.
//   - Payment (field 80, LS Central) - NAV's "payment" field, used for net_sales in the CMSR mall
//     reports. Distinct from Net Amount/Gross Amount, which are already exposed elsewhere and are
//     NOT the same thing.
//   - VAT Difference (field 60013, PHPOS extension) - NAV's "vat_difference".
//   - Official Receipt No. (field 60000, PHPOS extension) - NAV's "official_receipt_no", distinct
//     from the plain Receipt No. already exposed on the standard sync.
//   - Return Exchange No. (field 60010, PHPOS extension) - NAV's "return_exchange".
// storeNo/posTerminalNo/transactionNo are included so this can be joined back to the existing
// transactionHeaders sync (bc_covent_raw.transactionHeaders / bc_richfield_raw.transactionHeaders)
// once this lands in its own BigQuery table - Airbyte has no way to merge two different API
// sources into one table on its own. Same shape as ReturnReceiptLineExtendedApi.Page.al.
//
// REQUIRES: PHPOS added as a dependency in app.json (same as LS Central is) - VAT Difference/
// Official Receipt No./Return Exchange No. are PHPOS table-extension fields, and AL only lets you
// reference a field if you depend on the app that defines it. Transaction Type and Payment don't
// need this - they're on LS Central's own base table, already a dependency.

using Microsoft.Sales.History;

page 51002 "RGMC Trans Header Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'transactionHeaderExtended';
    EntitySetName = 'transactionHeadersExtended';
    Caption = 'RGMC Transaction Header Extended API';

    SourceTable = "LSC Transaction Header";
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
            field(storeNo; Rec."Store No.")
            {
                Caption = 'storeNo';
                Editable = false;
            }
            field(posTerminalNo; Rec."POS Terminal No.")
            {
                Caption = 'posTerminalNo';
                Editable = false;
            }
            field(transactionNo; Rec."Transaction No.")
            {
                Caption = 'transactionNo';
                Editable = false;
            }

            // --- The missing fields ---
            field(transactionType; Rec."Transaction Type")
            {
                Caption = 'transactionType';
                Editable = false;
            }
            field(payment; Rec.Payment)
            {
                Caption = 'payment';
                Editable = false;
            }
            field(vatDifference; Rec."VAT Difference")
            {
                Caption = 'vatDifference';
                Editable = false;
            }
            field(officialReceiptNo; Rec."Official Receipt No.")
            {
                Caption = 'officialReceiptNo';
                Editable = false;
            }
            field(returnExchangeNo; Rec."Return Exchange No.")
            {
                Caption = 'returnExchangeNo';
                Editable = false;
            }

            // --- Audit ---
            field(companyName; CurrentCompanyName)
            {
                Caption = 'companyName';
                Editable = false;
            }
            field(lastModifiedDateTime; Rec.SystemModifiedAt)
            {
                Caption = 'lastModifiedDateTime';
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
