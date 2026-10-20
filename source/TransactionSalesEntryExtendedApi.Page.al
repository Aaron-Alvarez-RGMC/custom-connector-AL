// Read-only API exposing Total Rounded Amt. (field 270, LS Central) from LSC Trans. Sales Entry, which
// is not wired into RGMC_ERAR's RGMCTransactionSalesEntryAPIv2.Page.al (Pag50323) today.
//   - Total Rounded Amt. is the VAT-inclusive line amount NAV's sales models use for total_amount.
//     Net Amount (already exposed elsewhere) is VAT-exclusive and is NOT a substitute.
// storeNo/posTerminalNo/transactionNo/lineNo are the key of LSC Trans. Sales Entry, included so this can
// be joined back to the existing transactionSalesEntries sync once it lands in its own BigQuery table -
// Airbyte has no way to merge two different API sources into one table on its own. Same shape as
// TransactionHeaderExtendedApi.Page.al.
//
// No new app.json dependency: LS Central is already a dependency and field 270 is on its own base table.

page 51023 "RGMC Trans Sales Entry Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'transactionSalesEntryExtended';
    EntitySetName = 'transactionSalesEntriesExtended';
    Caption = 'RGMC Transaction Sales Entry Extended API';

    SourceTable = "LSC Trans. Sales Entry";
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
            field(lineNo; Rec."Line No.")
            {
                Caption = 'lineNo';
                Editable = false;
            }

            // --- The missing field ---
            field(totalRoundedAmt; Rec."Total Rounded Amt.")
            {
                Caption = 'totalRoundedAmt';
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
