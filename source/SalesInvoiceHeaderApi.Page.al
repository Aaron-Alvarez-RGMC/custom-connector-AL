// Read-only API over Sales Invoice Header (112), posted invoices only. No existing API page publishes posted invoices.
// Needed by the SBIC sales models: posted amount and the VAT basis of the amount (pricesIncludingVat), the invoice
// posting date and the link back to the order (orderNo) and the customer PO number (externalDocumentNo).
// Join to Sales Invoice Lines on no = documentNo. Amount, Amount Including VAT, Invoice Discount Amount, Closed,
// Cancelled and Corrective are FlowFields, so they are calculated per record below.

using Microsoft.Sales.History;

page 51010 "RGMC Sales Invoice Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesInvoiceHeader';
    EntitySetName = 'salesInvoiceHeaders';
    Caption = 'RGMC Sales Invoice Header API';

    SourceTable = "Sales Invoice Header";
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
            field(orderNo; Rec."Order No.")
            {
                Caption = 'orderNo';
                Editable = false;
            }
            field(externalDocumentNo; Rec."External Document No.")
            {
                Caption = 'externalDocumentNo';
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
            field(orderDate; Rec."Order Date")
            {
                Caption = 'orderDate';
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

            // --- Amounts (FlowFields, calculated in OnAfterGetRecord) ---
            field(pricesIncludingVat; Rec."Prices Including VAT")
            {
                Caption = 'pricesIncludingVat';
                Editable = false;
            }
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

            // --- Status ---
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
            field(closed; Rec.Closed)
            {
                Caption = 'closed';
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
        Rec.CalcFields(Amount, "Amount Including VAT", "Invoice Discount Amount", Cancelled, Corrective, Closed);
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
