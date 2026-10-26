// Read-only API over Purch. Rcpt. Header (120), posted purchase receipts. No existing API page publishes them (the
// shared extension has the purchase order, Pag50342, not the receipt). Needed for the SBIC warehouse reports Stock
// Received and GR: vendor, vendor shipment / delivery number and the purchase order behind each receipt. The item
// ledger already has the quantities; this adds the document details.
// Join to Purch. Rcpt. Lines on no = documentNo, to the purchase order on orderNo.

using Microsoft.Purchases.History;

page 51035 "RGMC Purch Rcpt Header API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'purchRcptHeader';
    EntitySetName = 'purchRcptHeaders';
    Caption = 'RGMC Purch Rcpt Header API';

    SourceTable = "Purch. Rcpt. Header";
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
            field(vendorOrderNo; Rec."Vendor Order No.")
            {
                Caption = 'vendorOrderNo';
                Editable = false;
            }
            field(vendorShipmentNo; Rec."Vendor Shipment No.")
            {
                Caption = 'vendorShipmentNo';
                Editable = false;
            }
            field(yourReference; Rec."Your Reference")
            {
                Caption = 'yourReference';
                Editable = false;
            }

            // --- Vendor / location ---
            field(buyFromVendorNo; Rec."Buy-from Vendor No.")
            {
                Caption = 'buyFromVendorNo';
                Editable = false;
            }
            field(buyFromVendorName; Rec."Buy-from Vendor Name")
            {
                Caption = 'buyFromVendorName';
                Editable = false;
            }
            field(payToVendorNo; Rec."Pay-to Vendor No.")
            {
                Caption = 'payToVendorNo';
                Editable = false;
            }
            field(purchaserCode; Rec."Purchaser Code")
            {
                Caption = 'purchaserCode';
                Editable = false;
            }
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field(currencyCode; Rec."Currency Code")
            {
                Caption = 'currencyCode';
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
            field(orderDate; Rec."Order Date")
            {
                Caption = 'orderDate';
                Editable = false;
            }
            field(expectedReceiptDate; Rec."Expected Receipt Date")
            {
                Caption = 'expectedReceiptDate';
                Editable = false;
            }
            field(reasonCode; Rec."Reason Code")
            {
                Caption = 'reasonCode';
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
        CurrentCompanyName := CompanyName();
    end;

    var
        CurrentCompanyName: Text[30];
}
