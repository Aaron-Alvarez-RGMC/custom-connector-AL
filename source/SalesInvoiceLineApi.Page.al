// Read-only API over Sales Invoice Line (113), posted invoice lines. lineAmount is the money figure the SBIC sales
// models use as the net sales amount: it follows the header's Prices Including VAT, is after the line discount and
// before the invoice discount (invAmountDiscount shows the allocated invoice discount).
// Natural key: documentNo + lineNo. Join to Sales Invoice Headers on documentNo = no, to shipment lines on
// shipmentNo + shipmentLineNo, and to the order on orderNo + orderLineNo.

using Microsoft.Sales.History;

page 51011 "RGMC Sales Invoice Line API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesInvoiceLine';
    EntitySetName = 'salesInvoiceLines';
    Caption = 'RGMC Sales Invoice Line API';

    SourceTable = "Sales Invoice Line";
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
            field(postingDate; Rec."Posting Date")
            {
                Caption = 'postingDate';
                Editable = false;
            }

            // --- Quantity / UoM ---
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

            // --- Price / amount ---
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

            // --- Document links ---
            field(orderNo; Rec."Order No.")
            {
                Caption = 'orderNo';
                Editable = false;
            }
            field(orderLineNo; Rec."Order Line No.")
            {
                Caption = 'orderLineNo';
                Editable = false;
            }
            field(shipmentNo; Rec."Shipment No.")
            {
                Caption = 'shipmentNo';
                Editable = false;
            }
            field(shipmentLineNo; Rec."Shipment Line No.")
            {
                Caption = 'shipmentLineNo';
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
