// Read-only API over Bank Account Ledger Entry (271), every posted bank movement (receipts, payments, transfers).
// No existing API page publishes it. Needed for the SBIC accounting report Bank Account Ledger Entries and to follow
// customer receipts to the bank. Bank reconciliation changes statementStatus / statementNo / open on the row, so the
// incremental sync picks those changes up. Natural key: entryNo. Join to G/L and Cust. Ledger Entries on transactionNo.

using Microsoft.Bank.Ledger;

page 51028 "RGMC Bank Acc Ledger Entry API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'bankAccountLedgerEntry';
    EntitySetName = 'bankAccountLedgerEntries';
    Caption = 'RGMC Bank Acc Ledger Entry API';

    SourceTable = "Bank Account Ledger Entry";
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
            field(transactionNo; Rec."Transaction No.")
            {
                Caption = 'transactionNo';
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
            field(externalDocumentNo; Rec."External Document No.")
            {
                Caption = 'externalDocumentNo';
                Editable = false;
            }
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }

            // --- Bank account / dates ---
            field(bankAccountNo; Rec."Bank Account No.")
            {
                Caption = 'bankAccountNo';
                Editable = false;
            }
            field(bankAccPostingGroup; Rec."Bank Acc. Posting Group")
            {
                Caption = 'bankAccPostingGroup';
                Editable = false;
            }
            field(postingDate; Rec."Posting Date")
            {
                Caption = 'postingDate';
                Editable = false;
            }
            field(documentDate; Rec."Document Date")
            {
                Caption = 'documentDate';
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
            field(remainingAmount; Rec."Remaining Amount")
            {
                Caption = 'remainingAmount';
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

            // --- Reconciliation / status ---
            field(open; Rec.Open)
            {
                Caption = 'open';
                Editable = false;
            }
            field(statementStatus; Rec."Statement Status")
            {
                Caption = 'statementStatus';
                Editable = false;
            }
            field(statementNo; Rec."Statement No.")
            {
                Caption = 'statementNo';
                Editable = false;
            }
            field(statementLineNo; Rec."Statement Line No.")
            {
                Caption = 'statementLineNo';
                Editable = false;
            }
            field(closedByEntryNo; Rec."Closed by Entry No.")
            {
                Caption = 'closedByEntryNo';
                Editable = false;
            }
            field(reversed; Rec.Reversed)
            {
                Caption = 'reversed';
                Editable = false;
            }

            // --- Posting source ---
            field(balAccountType; Rec."Bal. Account Type")
            {
                Caption = 'balAccountType';
                Editable = false;
            }
            field(balAccountNo; Rec."Bal. Account No.")
            {
                Caption = 'balAccountNo';
                Editable = false;
            }
            field(journalTemplName; Rec."Journal Templ. Name")
            {
                Caption = 'journalTemplName';
                Editable = false;
            }
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
            field(globalDimension1Code; Rec."Global Dimension 1 Code")
            {
                Caption = 'globalDimension1Code';
                Editable = false;
            }
            field(globalDimension2Code; Rec."Global Dimension 2 Code")
            {
                Caption = 'globalDimension2Code';
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
