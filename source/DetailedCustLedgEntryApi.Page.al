// Read-only API over Detailed Cust. Ledg. Entry (379), the movements behind each customer ledger entry: the initial
// entry, applications (payment against invoice), discounts, rounding, unapplications. No existing API page publishes it.
// Needed for the SBIC AR reports: the balance of a customer ledger entry on any date is the sum of its detailed
// amounts up to that date, which is what Statement of Account and Customer Detailed Aging are built from.
// Rows are only inserted (an unapply adds new rows and flags the old ones as unapplied), so the incremental sync is
// complete. Natural key: entryNo. Join to Cust. Ledger Entries on custLedgerEntryNo = entryNo.

using Microsoft.Sales.Receivables;

page 51025 "RGMC Dtld Cust Ledg Entry API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'detailedCustLedgerEntry';
    EntitySetName = 'detailedCustLedgerEntries';
    Caption = 'RGMC Dtld Cust Ledg Entry API';

    SourceTable = "Detailed Cust. Ledg. Entry";
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
            field(entryNo; Rec."Entry No.")
            {
                Caption = 'entryNo';
                Editable = false;
            }
            field(custLedgerEntryNo; Rec."Cust. Ledger Entry No.")
            {
                Caption = 'custLedgerEntryNo';
                Editable = false;
            }
            field(entryType; Rec."Entry Type")
            {
                Caption = 'entryType';
                Editable = false;
            }
            field(documentType; Rec."Document Type")
            {
                Caption = 'documentType';
                Editable = false;
            }
            field(documentNo; Rec."Document No.")
            {
                Caption = 'documentNo';
                Editable = false;
            }
            field(transactionNo; Rec."Transaction No.")
            {
                Caption = 'transactionNo';
                Editable = false;
            }
            field(applicationNo; Rec."Application No.")
            {
                Caption = 'applicationNo';
                Editable = false;
            }

            // --- Customer / dates ---
            field(customerNo; Rec."Customer No.")
            {
                Caption = 'customerNo';
                Editable = false;
            }
            field(postingDate; Rec."Posting Date")
            {
                Caption = 'postingDate';
                Editable = false;
            }
            field(initialEntryDueDate; Rec."Initial Entry Due Date")
            {
                Caption = 'initialEntryDueDate';
                Editable = false;
            }
            field(initialDocumentType; Rec."Initial Document Type")
            {
                Caption = 'initialDocumentType';
                Editable = false;
            }
            field(postingGroup; Rec."Posting Group")
            {
                Caption = 'postingGroup';
                Editable = false;
            }

            // --- Amounts ---
            field(currencyCode; Rec."Currency Code")
            {
                Caption = 'currencyCode';
                Editable = false;
            }
            field(amount; Rec.Amount)
            {
                Caption = 'amount';
                Editable = false;
            }
            field(amountLcy; Rec."Amount (LCY)")
            {
                Caption = 'amountLcy';
                Editable = false;
            }
            field(debitAmount; Rec."Debit Amount")
            {
                Caption = 'debitAmount';
                Editable = false;
            }
            field(creditAmount; Rec."Credit Amount")
            {
                Caption = 'creditAmount';
                Editable = false;
            }
            field(debitAmountLcy; Rec."Debit Amount (LCY)")
            {
                Caption = 'debitAmountLcy';
                Editable = false;
            }
            field(creditAmountLcy; Rec."Credit Amount (LCY)")
            {
                Caption = 'creditAmountLcy';
                Editable = false;
            }
            field(ledgerEntryAmount; Rec."Ledger Entry Amount")
            {
                Caption = 'ledgerEntryAmount';
                Editable = false;
            }

            // --- Application ---
            field(appliedCustLedgerEntryNo; Rec."Applied Cust. Ledger Entry No.")
            {
                Caption = 'appliedCustLedgerEntryNo';
                Editable = false;
            }
            field(unapplied; Rec.Unapplied)
            {
                Caption = 'unapplied';
                Editable = false;
            }
            field(unappliedByEntryNo; Rec."Unapplied by Entry No.")
            {
                Caption = 'unappliedByEntryNo';
                Editable = false;
            }

            // --- Posting source ---
            field(journalBatchName; Rec."Journal Batch Name")
            {
                Caption = 'journalBatchName';
                Editable = false;
            }
            field(sourceCode; Rec."Source Code")
            {
                Caption = 'sourceCode';
                Editable = false;
            }
            field(reasonCode; Rec."Reason Code")
            {
                Caption = 'reasonCode';
                Editable = false;
            }
            field(userId; Rec."User ID")
            {
                Caption = 'userId';
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
