// Read-only API over G/L Entry (17), every posted general ledger line. No existing API page publishes it. Needed for
// the SBIC accounting report General Ledger Entries. The largest table here: sync it incrementally from the start
// (modified_from) and backfill in date ranges. G/L Account Name is a FlowField, so it is calculated per record below.
// Natural key: entryNo. Join to Cust. Ledger and Bank Account Ledger Entries on transactionNo (same posting).

using Microsoft.Finance.GeneralLedger.Ledger;

page 51027 "RGMC GL Entry API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'glEntry';
    EntitySetName = 'glEntries';
    Caption = 'RGMC GL Entry API';

    SourceTable = "G/L Entry";
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

            // --- Account / dates ---
            field(glAccountNo; Rec."G/L Account No.")
            {
                Caption = 'glAccountNo';
                Editable = false;
            }
            field(glAccountName; Rec."G/L Account Name")
            {
                Caption = 'glAccountName';
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
            field(amount; Rec.Amount)
            {
                Caption = 'amount';
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
            field(vatAmount; Rec."VAT Amount")
            {
                Caption = 'vatAmount';
                Editable = false;
            }

            // --- Posting setup / source ---
            field(genPostingType; Rec."Gen. Posting Type")
            {
                Caption = 'genPostingType';
                Editable = false;
            }
            field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
            {
                Caption = 'genBusPostingGroup';
                Editable = false;
            }
            field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
            {
                Caption = 'genProdPostingGroup';
                Editable = false;
            }
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
            field(sourceType; Rec."Source Type")
            {
                Caption = 'sourceType';
                Editable = false;
            }
            field(sourceNo; Rec."Source No.")
            {
                Caption = 'sourceNo';
                Editable = false;
            }
            field(sourceCode; Rec."Source Code")
            {
                Caption = 'sourceCode';
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
            field(reasonCode; Rec."Reason Code")
            {
                Caption = 'reasonCode';
                Editable = false;
            }
            field(reversed; Rec.Reversed)
            {
                Caption = 'reversed';
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
            field(dimensionSetId; Rec."Dimension Set ID")
            {
                Caption = 'dimensionSetId';
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
        Rec.CalcFields("G/L Account Name");
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
