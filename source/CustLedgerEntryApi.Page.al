// Read-only API over Cust. Ledger Entry (21), one row per posted customer document (invoice, credit memo, payment,
// refund...). No existing API page publishes it. Needed for the SBIC AR reports: Customer Ledger, Statement of Account
// and Customer Detailed Aging (with Detailed Cust. Ledg. Entry).
// Natural key: entryNo. Join to Detailed Cust. Ledg. Entries on entryNo = custLedgerEntryNo, to posted invoices and
// credit memos on documentNo. Amount, Amount (LCY), Original Amount, Original Amt. (LCY), Remaining Amount and
// Remaining Amt. (LCY) are FlowFields over the detailed entries, so they are calculated per record below. A payment
// applied later adds detailed entries without always changing this row, so an incremental sync can keep an old
// remainingAmount: build balances and aging from the detailed entries, not from remainingAmount.

using Microsoft.Sales.Receivables;

page 51024 "RGMC Cust Ledger Entry API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'customerLedgerEntry';
    EntitySetName = 'customerLedgerEntries';
    Caption = 'RGMC Cust Ledger Entry API';

    SourceTable = "Cust. Ledger Entry";
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
            field(transactionNo; Rec."Transaction No.")
            {
                Caption = 'transactionNo';
                Editable = false;
            }

            // --- Customer / rep ---
            field(customerNo; Rec."Customer No.")
            {
                Caption = 'customerNo';
                Editable = false;
            }
            field(customerName; Rec."Customer Name")
            {
                Caption = 'customerName';
                Editable = false;
            }
            field(sellToCustomerNo; Rec."Sell-to Customer No.")
            {
                Caption = 'sellToCustomerNo';
                Editable = false;
            }
            field(customerPostingGroup; Rec."Customer Posting Group")
            {
                Caption = 'customerPostingGroup';
                Editable = false;
            }
            field(salespersonCode; Rec."Salesperson Code")
            {
                Caption = 'salespersonCode';
                Editable = false;
            }

            // --- Dates ---
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
            field(pmtDiscountDate; Rec."Pmt. Discount Date")
            {
                Caption = 'pmtDiscountDate';
                Editable = false;
            }

            // --- Amounts (FlowFields except salesLcy) ---
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
            field(originalAmount; Rec."Original Amount")
            {
                Caption = 'originalAmount';
                Editable = false;
            }
            field(originalAmtLcy; Rec."Original Amt. (LCY)")
            {
                Caption = 'originalAmtLcy';
                Editable = false;
            }
            field(remainingAmount; Rec."Remaining Amount")
            {
                Caption = 'remainingAmount';
                Editable = false;
            }
            field(remainingAmtLcy; Rec."Remaining Amt. (LCY)")
            {
                Caption = 'remainingAmtLcy';
                Editable = false;
            }
            field(salesLcy; Rec."Sales (LCY)")
            {
                Caption = 'salesLcy';
                Editable = false;
            }

            // --- Application / status ---
            field(open; Rec.Open)
            {
                Caption = 'open';
                Editable = false;
            }
            field(onHold; Rec."On Hold")
            {
                Caption = 'onHold';
                Editable = false;
            }
            field(closedByEntryNo; Rec."Closed by Entry No.")
            {
                Caption = 'closedByEntryNo';
                Editable = false;
            }
            field(closedAtDate; Rec."Closed at Date")
            {
                Caption = 'closedAtDate';
                Editable = false;
            }
            field(closedByAmount; Rec."Closed by Amount")
            {
                Caption = 'closedByAmount';
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
            field(paymentMethodCode; Rec."Payment Method Code")
            {
                Caption = 'paymentMethodCode';
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
            field(yourReference; Rec."Your Reference")
            {
                Caption = 'yourReference';
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
        Rec.CalcFields(Amount, "Amount (LCY)", "Original Amount", "Original Amt. (LCY)", "Remaining Amount", "Remaining Amt. (LCY)");
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
