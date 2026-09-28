// Read-only API over Warehouse Entry (7312) - bin-level movement ledger (~55k rows on CGI as of 2026-09-28).
// Real table, so SystemId is stable across syncs (unlike Pag50339's CreateGuid). entryNo is the natural key.

using Microsoft.Warehouse.Ledger;

page 51004 "RGMC Warehouse Entry API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'warehouseEntry';
    EntitySetName = 'warehouseEntries';
    Caption = 'RGMC Warehouse Entry API';

    SourceTable = "Warehouse Entry";
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
            field(entryNo; Rec."Entry No.")
            {
                Caption = 'entryNo';
                Editable = false;
            }
            field(entryType; Rec."Entry Type")
            {
                Caption = 'entryType';
                Editable = false;
            }
            field(registeringDate; Rec."Registering Date")
            {
                Caption = 'registeringDate';
                Editable = false;
            }

            // --- Where / what ---
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field(zoneCode; Rec."Zone Code")
            {
                Caption = 'zoneCode';
                Editable = false;
            }
            field(binCode; Rec."Bin Code")
            {
                Caption = 'binCode';
                Editable = false;
            }
            field(binTypeCode; Rec."Bin Type Code")
            {
                Caption = 'binTypeCode';
                Editable = false;
            }
            field(itemNo; Rec."Item No.")
            {
                Caption = 'itemNo';
                Editable = false;
            }
            field(variantCode; Rec."Variant Code")
            {
                Caption = 'variantCode';
                Editable = false;
            }
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }
            field(quantity; Rec.Quantity)
            {
                Caption = 'quantity';
                Editable = false;
            }
            field(qtyBase; Rec."Qty. (Base)")
            {
                Caption = 'qtyBase';
                Editable = false;
            }
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

            // --- Source document (links back to item ledger / transfers) ---
            field(sourceType; Rec."Source Type")
            {
                Caption = 'sourceType';
                Editable = false;
            }
            field(sourceSubtype; Rec."Source Subtype")
            {
                Caption = 'sourceSubtype';
                Editable = false;
            }
            field(sourceNo; Rec."Source No.")
            {
                Caption = 'sourceNo';
                Editable = false;
            }
            field(sourceLineNo; Rec."Source Line No.")
            {
                Caption = 'sourceLineNo';
                Editable = false;
            }
            field(sourceDocument; Rec."Source Document")
            {
                Caption = 'sourceDocument';
                Editable = false;
            }
            field(sourceCode; Rec."Source Code")
            {
                Caption = 'sourceCode';
                Editable = false;
            }
            field(referenceDocument; Rec."Reference Document")
            {
                Caption = 'referenceDocument';
                Editable = false;
            }
            field(referenceNo; Rec."Reference No.")
            {
                Caption = 'referenceNo';
                Editable = false;
            }
            field(whseDocumentType; Rec."Whse. Document Type")
            {
                Caption = 'whseDocumentType';
                Editable = false;
            }
            field(whseDocumentNo; Rec."Whse. Document No.")
            {
                Caption = 'whseDocumentNo';
                Editable = false;
            }
            field(whseDocumentLineNo; Rec."Whse. Document Line No.")
            {
                Caption = 'whseDocumentLineNo';
                Editable = false;
            }
            field(warehouseRegisterNo; Rec."Warehouse Register No.")
            {
                Caption = 'warehouseRegisterNo';
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
