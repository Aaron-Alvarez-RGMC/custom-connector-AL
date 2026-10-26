// Read-only API over Purch. Rcpt. Line (121), posted purchase receipt lines. quantityInvoiced / qtyRcdNotInvoiced
// change when the vendor invoice is posted, so the incremental sync picks them up. correction = true marks a line that
// undoes an earlier receipt line. Natural key: documentNo + lineNo. Join to Purch. Rcpt. Headers on documentNo = no,
// to the item ledger on documentNo + lineNo = documentNumber + documentLineNo, and to the purchase order on
// orderNo + orderLineNo. itemRcptEntryNo is 0 for lot-tracked items (one receipt line can create several item ledger
// entries), which is every SBIC receipt line checked on UAT on 2026-10-26, so it is not a usable join key.

using Microsoft.Purchases.History;

page 51036 "RGMC Purch Rcpt Line API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'purchRcptLine';
    EntitySetName = 'purchRcptLines';
    Caption = 'RGMC Purch Rcpt Line API';

    SourceTable = "Purch. Rcpt. Line";
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
            field(buyFromVendorNo; Rec."Buy-from Vendor No.")
            {
                Caption = 'buyFromVendorNo';
                Editable = false;
            }
            field(correction; Rec.Correction)
            {
                Caption = 'correction';
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
            field(binCode; Rec."Bin Code")
            {
                Caption = 'binCode';
                Editable = false;
            }
            field(postingDate; Rec."Posting Date")
            {
                Caption = 'postingDate';
                Editable = false;
            }
            field(expectedReceiptDate; Rec."Expected Receipt Date")
            {
                Caption = 'expectedReceiptDate';
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
            field(qtyRcdNotInvoiced; Rec."Qty. Rcd. Not Invoiced")
            {
                Caption = 'qtyRcdNotInvoiced';
                Editable = false;
            }

            // --- Cost ---
            field(directUnitCost; Rec."Direct Unit Cost")
            {
                Caption = 'directUnitCost';
                Editable = false;
            }
            field(unitCostLcy; Rec."Unit Cost (LCY)")
            {
                Caption = 'unitCostLcy';
                Editable = false;
            }

            // --- Links ---
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
            field(itemRcptEntryNo; Rec."Item Rcpt. Entry No.")
            {
                Caption = 'itemRcptEntryNo';
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
