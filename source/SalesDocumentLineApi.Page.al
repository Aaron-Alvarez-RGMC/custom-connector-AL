// Read-only API over open Sales Line for Invoice, Credit Memo and Return Order (the lines of page 51031). Same money
// fields as the order line page. returnQtyReceived / returnQtyToReceive follow a return order through receiving.
// Natural key: documentType + documentNo + lineNo. Join to Sales Document Headers on documentType + documentNo.

using Microsoft.Sales.Document;

page 51032 "RGMC Sales Doc Line API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesDocumentLine';
    EntitySetName = 'salesDocumentLines';
    Caption = 'RGMC Sales Doc Line API';

    SourceTable = "Sales Line";
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
            field(documentNo; Rec."Document No.")
            {
                Caption = 'documentNo';
                Editable = false;
            }
            field(lineNo; Rec."Line No.")
            {
                Caption = 'lineNo';
                Editable = false;
            }
            field(sellToCustomerNo; Rec."Sell-to Customer No.")
            {
                Caption = 'sellToCustomerNo';
                Editable = false;
            }

            // --- Item ---
            field(lineType; Rec.Type)
            {
                Caption = 'lineType';
                Editable = false;
            }
            field(no; Rec."No.")
            {
                Caption = 'no';
                Editable = false;
            }
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }
            field(variantCode; Rec."Variant Code")
            {
                Caption = 'variantCode';
                Editable = false;
            }
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field(returnReasonCode; Rec."Return Reason Code")
            {
                Caption = 'returnReasonCode';
                Editable = false;
            }

            // --- Quantity ---
            field(unitOfMeasureCode; Rec."Unit of Measure Code")
            {
                Caption = 'unitOfMeasureCode';
                Editable = false;
            }
            field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
            {
                Caption = 'qtyPerUnitOfMeasure';
                Editable = false;
            }
            field(quantity; Rec.Quantity)
            {
                Caption = 'quantity';
                Editable = false;
            }
            field(quantityBase; Rec."Quantity (Base)")
            {
                Caption = 'quantityBase';
                Editable = false;
            }
            field(quantityInvoiced; Rec."Quantity Invoiced")
            {
                Caption = 'quantityInvoiced';
                Editable = false;
            }
            field(returnQtyReceived; Rec."Return Qty. Received")
            {
                Caption = 'returnQtyReceived';
                Editable = false;
            }
            field(returnQtyToReceive; Rec."Return Qty. to Receive")
            {
                Caption = 'returnQtyToReceive';
                Editable = false;
            }

            // --- Money ---
            field(unitPrice; Rec."Unit Price")
            {
                Caption = 'unitPrice';
                Editable = false;
            }
            field(lineDiscountPercent; Rec."Line Discount %")
            {
                Caption = 'lineDiscountPercent';
                Editable = false;
            }
            field(lineDiscountAmount; Rec."Line Discount Amount")
            {
                Caption = 'lineDiscountAmount';
                Editable = false;
            }
            field(lineAmount; Rec."Line Amount")
            {
                Caption = 'lineAmount';
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
            field(invAmountDiscount; Rec."Inv. Discount Amount")
            {
                Caption = 'invAmountDiscount';
                Editable = false;
            }
            field(vatPercent; Rec."VAT %")
            {
                Caption = 'vatPercent';
                Editable = false;
            }

            // --- Links ---
            field(shipmentNo; Rec."Shipment No.")
            {
                Caption = 'shipmentNo';
                Editable = false;
            }
            field(returnReceiptNo; Rec."Return Receipt No.")
            {
                Caption = 'returnReceiptNo';
                Editable = false;
            }
            field(applFromItemEntry; Rec."Appl.-from Item Entry")
            {
                Caption = 'applFromItemEntry';
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
