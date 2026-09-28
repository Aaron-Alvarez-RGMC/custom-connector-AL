// Read-only API over LSC Trans. Payment Entry (99001474) - fields RGMC_ERAR's Pag50324 doesn't expose, notably
// Quantity (1002), which NAV's tender summary uses. Join back to transactionPaymentEntries on
// (storeNo, posTerminalNo, transactionNo, lineNo).

page 51006 "RGMC Trans Pmt Entry Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'transPaymentEntryExtended';
    EntitySetName = 'transPaymentEntriesExtended';
    Caption = 'RGMC Trans Payment Entry Extended API';

    SourceTable = "LSC Trans. Payment Entry";
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

            // --- The missing fields ---
            field(quantity; Rec.Quantity)
            {
                Caption = 'quantity';
                Editable = false;
            }
            field(amountInCurrency; Rec."Amount in Currency")
            {
                Caption = 'amountInCurrency';
                Editable = false;
            }
            field(exchangeRate; Rec."Exchange Rate")
            {
                Caption = 'exchangeRate';
                Editable = false;
            }
            field(cardOrAccount; Rec."Card or Account")
            {
                Caption = 'cardOrAccount';
                Editable = false;
            }
            field(changeLine; Rec."Change Line")
            {
                Caption = 'changeLine';
                Editable = false;
            }
            field(statementNo; Rec."Statement No.")
            {
                Caption = 'statementNo';
                Editable = false;
            }
            field(zReportId; Rec."Z-Report ID")
            {
                Caption = 'zReportId';
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
