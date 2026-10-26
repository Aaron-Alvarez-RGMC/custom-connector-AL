// Read-only API over Gen. Journal Line (81), lines not yet posted in every general journal. Needed for the SBIC AR
// report Cash Receipt Journal: filter templateType = Cash Receipts. templateType comes from the Gen. Journal Template
// of the line, read per record below; it is not a table field, so it cannot be used in an OData $filter (filter on
// journalTemplateName in the request, or on templateType in staging). Lines are deleted when they are posted (they then live in the customer, bank and
// G/L ledgers), so this stream shows only what is waiting to be posted; a deleted line never comes through the
// incremental sync, so staging must treat the latest full read as the current journal.
// Natural key: journalTemplateName + journalBatchName + lineNo.

using Microsoft.Finance.GeneralLedger.Journal;

page 51033 "RGMC Gen Journal Line API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'genJournalLine';
    EntitySetName = 'genJournalLines';
    Caption = 'RGMC Gen Journal Line API';

    SourceTable = "Gen. Journal Line";
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
            field(journalTemplateName; Rec."Journal Template Name")
            {
                Caption = 'journalTemplateName';
                Editable = false;
            }
            field(templateType; TemplateType)
            {
                Caption = 'templateType';
                Editable = false;
            }
            field(journalBatchName; Rec."Journal Batch Name")
            {
                Caption = 'journalBatchName';
                Editable = false;
            }
            field(lineNo; Rec."Line No.")
            {
                Caption = 'lineNo';
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
            field(comment; Rec.Comment)
            {
                Caption = 'comment';
                Editable = false;
            }

            // --- Account / dates ---
            field(accountType; Rec."Account Type")
            {
                Caption = 'accountType';
                Editable = false;
            }
            field(accountNo; Rec."Account No.")
            {
                Caption = 'accountNo';
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
            field(dueDate; Rec."Due Date")
            {
                Caption = 'dueDate';
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

            // --- Balance / application ---
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
            field(appliesToDocType; Rec."Applies-to Doc. Type")
            {
                Caption = 'appliesToDocType';
                Editable = false;
            }
            field(appliesToDocNo; Rec."Applies-to Doc. No.")
            {
                Caption = 'appliesToDocNo';
                Editable = false;
            }
            field(appliesToId; Rec."Applies-to ID")
            {
                Caption = 'appliesToId';
                Editable = false;
            }
            field(appliedAutomatically; Rec."Applied Automatically")
            {
                Caption = 'appliedAutomatically';
                Editable = false;
            }
            field(paymentMethodCode; Rec."Payment Method Code")
            {
                Caption = 'paymentMethodCode';
                Editable = false;
            }
            field(checkPrinted; Rec."Check Printed")
            {
                Caption = 'checkPrinted';
                Editable = false;
            }

            // --- Posting source ---
            field(salespersPurchCode; Rec."Salespers./Purch. Code")
            {
                Caption = 'salespersPurchCode';
                Editable = false;
            }
            field(reasonCode; Rec."Reason Code")
            {
                Caption = 'reasonCode';
                Editable = false;
            }
            field(sourceCode; Rec."Source Code")
            {
                Caption = 'sourceCode';
                Editable = false;
            }
            field(postingNoSeries; Rec."Posting No. Series")
            {
                Caption = 'postingNoSeries';
                Editable = false;
            }
            field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
            {
                Caption = 'shortcutDimension1Code';
                Editable = false;
            }
            field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
            {
                Caption = 'shortcutDimension2Code';
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
        if GenJournalTemplate.Name <> Rec."Journal Template Name" then
            if not GenJournalTemplate.Get(Rec."Journal Template Name") then
                Clear(GenJournalTemplate);
        TemplateType := GenJournalTemplate.Type;
        CurrentCompanyName := CompanyName();
    end;

    var
        GenJournalTemplate: Record "Gen. Journal Template";
        TemplateType: Enum "Gen. Journal Template Type";
        CurrentCompanyName: Text[30];
}
