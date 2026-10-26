// Read-only API over Sales Cr.Memo Header (114), posted credit memos only. No existing API page publishes them.
// Needed for the SBIC AR report Posted Sales Credit Memo and to net returns and price adjustments out of sales.
// Join to Sales Cr.Memo Lines on no = documentNo, to the return order on returnOrderNo, to the invoice it corrects on
// appliesToDocNo. Amount, Amount Including VAT, Invoice Discount Amount, Cancelled, Corrective, Paid and Remaining
// Amount are FlowFields, so they are calculated per record below (paid / remainingAmount can lag, as on the invoice page).

using Microsoft.Sales.History;

page 51029 "RGMC Sales Cr Memo Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesCrMemoHeader';
    EntitySetName = 'salesCrMemoHeaders';
    Caption = 'RGMC Sales Cr Memo Header API';

    SourceTable = "Sales Cr.Memo Header";
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
            field(no; Rec."No.")
            {
                Caption = 'no';
                Editable = false;
            }
            field(preAssignedNo; Rec."Pre-Assigned No.")
            {
                Caption = 'preAssignedNo';
                Editable = false;
            }
            field(returnOrderNo; Rec."Return Order No.")
            {
                Caption = 'returnOrderNo';
                Editable = false;
            }
            field(externalDocumentNo; Rec."External Document No.")
            {
                Caption = 'externalDocumentNo';
                Editable = false;
            }
            field(yourReference; Rec."Your Reference")
            {
                Caption = 'yourReference';
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
            field(custLedgerEntryNo; Rec."Cust. Ledger Entry No.")
            {
                Caption = 'custLedgerEntryNo';
                Editable = false;
            }

            // --- Customer / ship-to / rep ---
            field(sellToCustomerNo; Rec."Sell-to Customer No.")
            {
                Caption = 'sellToCustomerNo';
                Editable = false;
            }
            field(billToCustomerNo; Rec."Bill-to Customer No.")
            {
                Caption = 'billToCustomerNo';
                Editable = false;
            }
            field(shipToCode; Rec."Ship-to Code")
            {
                Caption = 'shipToCode';
                Editable = false;
            }
            field(salespersonCode; Rec."Salesperson Code")
            {
                Caption = 'salespersonCode';
                Editable = false;
            }
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }

            // --- Dates / terms ---
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
            field(paymentTermsCode; Rec."Payment Terms Code")
            {
                Caption = 'paymentTermsCode';
                Editable = false;
            }
            field(reasonCode; Rec."Reason Code")
            {
                Caption = 'reasonCode';
                Editable = false;
            }
            field(currencyCode; Rec."Currency Code")
            {
                Caption = 'currencyCode';
                Editable = false;
            }
            field(pricesIncludingVat; Rec."Prices Including VAT")
            {
                Caption = 'pricesIncludingVat';
                Editable = false;
            }

            // --- Amounts / status (FlowFields) ---
            field(amount; Rec.Amount)
            {
                Caption = 'amount';
                Editable = false;
            }
            field(amountIncludingVat; Rec."Amount Including VAT")
            {
                Caption = 'amountIncludingVat';
                Editable = false;
            }
            field(invoiceDiscountAmount; Rec."Invoice Discount Amount")
            {
                Caption = 'invoiceDiscountAmount';
                Editable = false;
            }
            field(cancelled; Rec.Cancelled)
            {
                Caption = 'cancelled';
                Editable = false;
            }
            field(corrective; Rec.Corrective)
            {
                Caption = 'corrective';
                Editable = false;
            }
            field(paid; Rec.Paid)
            {
                Caption = 'paid';
                Editable = false;
            }
            field(remainingAmount; Rec."Remaining Amount")
            {
                Caption = 'remainingAmount';
                Editable = false;
            }

            // --- Posting source ---
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
        Rec.CalcFields(Amount, "Amount Including VAT", "Invoice Discount Amount", Cancelled, Corrective, Paid, "Remaining Amount");
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
