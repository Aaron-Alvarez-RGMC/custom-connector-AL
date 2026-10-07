// Read-only API over Sales Shipment Header (110). No existing API page publishes the shipment header, only the lines
// (Pag50340 in the shared extension), which lack the customer PO number, ship-to, payment terms, salesperson and order
// date. Needed by the SBIC sales models (po_ref_number, so_date, payment_terms, branch, rep).
// Join to Sales Shipment Lines on no = documentNo; to the order on orderNo; to Sales Invoice Lines on shipmentNo.

using Microsoft.Sales.History;

page 51009 "RGMC Sales Shipment Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesShipmentHeader';
    EntitySetName = 'salesShipmentHeaders';
    Caption = 'RGMC Sales Shipment Header API';

    SourceTable = "Sales Shipment Header";
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
            field(yourReference; Rec."Your Reference")
            {
                Caption = 'yourReference';
                Editable = false;
            }

            // --- Customer / ship-to ---
            field(sellToCustomerNo; Rec."Sell-to Customer No.")
            {
                Caption = 'sellToCustomerNo';
                Editable = false;
            }
            field(sellToCustomerName; Rec."Sell-to Customer Name")
            {
                Caption = 'sellToCustomerName';
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
            field(shipToName; Rec."Ship-to Name")
            {
                Caption = 'shipToName';
                Editable = false;
            }

            // --- Dates ---
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
            field(shipmentDate; Rec."Shipment Date")
            {
                Caption = 'shipmentDate';
                Editable = false;
            }
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

            // --- Terms / rep / location ---
            field(paymentTermsCode; Rec."Payment Terms Code")
            {
                Caption = 'paymentTermsCode';
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
            field(pricesIncludingVat; Rec."Prices Including VAT")
            {
                Caption = 'pricesIncludingVat';
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
            field(correction; Rec.Correction)
            {
                Caption = 'correction';
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
