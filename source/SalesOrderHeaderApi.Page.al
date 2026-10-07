// Read-only API over open Sales Header (Document Type = Order). A fully invoiced order is deleted from this table (it
// survives only in the archive), so the stream is meant to capture each state of an order while it is open: Airbyte
// appends one row per change and staging keeps the history. Flat on purpose; the shared extension's order page
// (Pag50315) can only be read through a nested route.
// Completely Shipped, Shipped, Last Shipment Date and No. of Archived Versions are FlowFields, so they are
// calculated per record below. Join to lines on no = documentNo.

using Microsoft.Sales.Document;

page 51012 "RGMC Sales Order Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesOrderHeader';
    EntitySetName = 'salesOrderHeaders';
    Caption = 'RGMC Sales Order Header API';

    SourceTable = "Sales Header";
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
            field(status; Rec.Status)
            {
                Caption = 'status';
                Editable = false;
            }

            // --- Customer / ship-to / rep ---
            field(sellToCustomerNo; Rec."Sell-to Customer No.")
            {
                Caption = 'sellToCustomerNo';
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
            field(paymentTermsCode; Rec."Payment Terms Code")
            {
                Caption = 'paymentTermsCode';
                Editable = false;
            }
            field(pricesIncludingVat; Rec."Prices Including VAT")
            {
                Caption = 'pricesIncludingVat';
                Editable = false;
            }

            // --- Fulfilment (FlowFields) ---
            field(completelyShipped; Rec."Completely Shipped")
            {
                Caption = 'completelyShipped';
                Editable = false;
            }
            field(shipped; Rec.Shipped)
            {
                Caption = 'shipped';
                Editable = false;
            }
            field(lastShipmentDate; Rec."Last Shipment Date")
            {
                Caption = 'lastShipmentDate';
                Editable = false;
            }
            field(noOfArchivedVersions; Rec."No. of Archived Versions")
            {
                Caption = 'noOfArchivedVersions';
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
        Rec.CalcFields("Completely Shipped", Shipped, "Last Shipment Date", "No. of Archived Versions");
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
