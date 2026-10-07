// Read-only API over Item Reference (5777): barcodes, customer and vendor item numbers per item and unit of measure.
// Needed by the SBIC models to map the legacy SKU (barcode / sku_code) to a BC item and unit of measure (pieces vs
// case). Natural key: itemNo + variantCode + unitOfMeasure + referenceType + referenceTypeNo + referenceNo.

using Microsoft.Inventory.Item.Catalog;

page 51016 "RGMC Item Reference API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'itemReference';
    EntitySetName = 'itemReferences';
    Caption = 'RGMC Item Reference API';

    SourceTable = "Item Reference";
    ODataKeyFields = SystemId;

    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field(id; Rec.SystemId)
            {
                Caption = 'id';
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
            field(unitOfMeasure; Rec."Unit of Measure")
            {
                Caption = 'unitOfMeasure';
                Editable = false;
            }
            field(referenceType; Rec."Reference Type")
            {
                Caption = 'referenceType';
                Editable = false;
            }
            field(referenceTypeNo; Rec."Reference Type No.")
            {
                Caption = 'referenceTypeNo';
                Editable = false;
            }
            field(referenceNo; Rec."Reference No.")
            {
                Caption = 'referenceNo';
                Editable = false;
            }
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }
            field(startingDate; Rec."Starting Date")
            {
                Caption = 'startingDate';
                Editable = false;
            }
            field(endingDate; Rec."Ending Date")
            {
                Caption = 'endingDate';
                Editable = false;
            }
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
