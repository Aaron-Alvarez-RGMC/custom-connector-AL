// Read-only API over Item Unit of Measure (5404): every unit of measure of an item with its quantity per base unit.
// Needed by the SBIC models to convert cases to pieces (pcs_in_packaging / default_multiplier) for items that have
// several units of measure. Natural key: itemNo + code.

using Microsoft.Inventory.Item;

page 51015 "RGMC Item Unit of Measure API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'itemUnitOfMeasure';
    EntitySetName = 'itemUnitsOfMeasure';
    Caption = 'RGMC Item Unit of Measure API';

    SourceTable = "Item Unit of Measure";
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
            field(code; Rec.Code)
            {
                Caption = 'code';
                Editable = false;
            }
            field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
            {
                Caption = 'qtyPerUnitOfMeasure';
                Editable = false;
            }
            field(length; Rec.Length)
            {
                Caption = 'length';
                Editable = false;
            }
            field(width; Rec.Width)
            {
                Caption = 'width';
                Editable = false;
            }
            field(height; Rec.Height)
            {
                Caption = 'height';
                Editable = false;
            }
            field(cubage; Rec.Cubage)
            {
                Caption = 'cubage';
                Editable = false;
            }
            field(weight; Rec.Weight)
            {
                Caption = 'weight';
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
