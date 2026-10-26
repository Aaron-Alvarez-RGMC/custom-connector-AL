// Read-only API over open Sales Header for the document types the order page (51012) does not cover: Invoice,
// Credit Memo and Return Order (documentType tells them apart). Needed for the SBIC AR reports Sales Invoice, Sales
// Credit Memo and Sales Return Order (unposted). Flat on purpose; the shared extension's return order page (Pag50313)
// can only be read through a nested route. A document is deleted from this table when it is posted, so, as with the
// order page, the stream captures each state while the document is open and staging keeps the history.
// Amount and Amount Including VAT are FlowFields, so they are calculated per record below.
// Join to lines on documentType + no = documentType + documentNo.

using Microsoft.Sales.Document;

page 51031 "RGMC Sales Doc Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesDocumentHeader';
    EntitySetName = 'salesDocumentHeaders';
    Caption = 'RGMC Sales Doc Header API';

    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = filter(Invoice | "Credit Memo" | "Return Order"));
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
            field(documentType; Rec."Document Type")
            {
                Caption = 'documentType';
                Editable = false;
            }
            field(no; Rec."No.")
            {
                Caption = 'no';
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
            field(status; Rec.Status)
            {
                Caption = 'status';
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
            field(orderDate; Rec."Order Date")
            {
                Caption = 'orderDate';
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

            // --- Amounts (FlowFields) ---
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

            // --- Return / workflow ---
            field(returnReceiptNo; Rec."Return Receipt No.")
            {
                Caption = 'returnReceiptNo';
                Editable = false;
            }
            field(assignedUserId; Rec."Assigned User ID")
            {
                Caption = 'assignedUserId';
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
        Rec.CalcFields(Amount, "Amount Including VAT");
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
