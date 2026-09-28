// Read-only API over Bin (7354) - bin master per location (e.g. WHC001PCWH: DISPATCH, DAMAGE, MEZ* staging bins).
// Karen's request: bins are needed to classify transfers as New/Pullout. Join to warehouseEntries on (locationCode, code).

using Microsoft.Warehouse.Structure;

page 51003 "RGMC Bin API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'bin';
    EntitySetName = 'bins';
    Caption = 'RGMC Bin API';

    SourceTable = Bin;
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
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field("code"; Rec."Code")
            {
                Caption = 'code';
                Editable = false;
            }
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }
            field(zoneCode; Rec."Zone Code")
            {
                Caption = 'zoneCode';
                Editable = false;
            }
            field(binTypeCode; Rec."Bin Type Code")
            {
                Caption = 'binTypeCode';
                Editable = false;
            }
            field(warehouseClassCode; Rec."Warehouse Class Code")
            {
                Caption = 'warehouseClassCode';
                Editable = false;
            }
            field(blockMovement; Rec."Block Movement")
            {
                Caption = 'blockMovement';
                Editable = false;
            }
            field(binRanking; Rec."Bin Ranking")
            {
                Caption = 'binRanking';
                Editable = false;
            }
            field(empty; Rec.Empty)
            {
                Caption = 'empty';
                Editable = false;
            }
            field(crossDockBin; Rec."Cross-Dock Bin")
            {
                Caption = 'crossDockBin';
                Editable = false;
            }
            field(dedicated; Rec.Dedicated)
            {
                Caption = 'dedicated';
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
