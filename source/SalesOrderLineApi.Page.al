// Read-only API over open Sales Line (Document Type = Order). quantity is the ordered (requested) quantity and
// quantityShipped the shipped quantity while the order is open. Once an order is fully invoiced BC deletes it, so
// staging keeps the maximum quantity ever seen per (documentNo, lineNo) from the appended generations. Needed by the
// SBIC service level (requested vs shipped). Natural key: documentNo + lineNo.
// Join to the order header on documentNo = no, to shipment lines on orderNo + orderLineNo, to invoice lines the same.

using Microsoft.Sales.Document;

page 51013 "RGMC Sales Order Line API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderLine';
    EntitySetName = 'salesOrderLines';
    Caption = 'RGMC Sales Order Line API';

    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = const(Order));
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
            field(quantityShipped; Rec."Quantity Shipped")
            {
                Caption = 'quantityShipped';
                Editable = false;
            }
            field(quantityInvoiced; Rec."Quantity Invoiced")
            {
                Caption = 'quantityInvoiced';
                Editable = false;
            }
            field(outstandingQuantity; Rec."Outstanding Quantity")
            {
                Caption = 'outstandingQuantity';
                Editable = false;
            }
            field(qtyToShip; Rec."Qty. to Ship")
            {
                Caption = 'qtyToShip';
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

            // --- Dates ---
            field(requestedDeliveryDate; Rec."Requested Delivery Date")
            {
                Caption = 'requestedDeliveryDate';
                Editable = false;
            }
            field(promisedDeliveryDate; Rec."Promised Delivery Date")
            {
                Caption = 'promisedDeliveryDate';
                Editable = false;
            }
            field(shipmentDate; Rec."Shipment Date")
            {
                Caption = 'shipmentDate';
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
