// Read-only API over the RGMC Sales Rep Assignment table (51020): one row per customer, rep and start date, with the
// primary flag and the end date. The KAM / KAS role is derived downstream from isPrimary and the number of active
// reps on the customer. Natural key: customerNo + salespersonCode + startingDate. Blank endingDate = open.

page 51022 "RGMC Sales Rep Assignment API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesRepAssignment';
    EntitySetName = 'salesRepAssignments';
    Caption = 'RGMC Sales Rep Assignment API';

    SourceTable = "RGMC Sales Rep Assignment";
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
            field(customerNo; Rec."Customer No.")
            {
                Caption = 'customerNo';
                Editable = false;
            }
            field(salespersonCode; Rec."Salesperson Code")
            {
                Caption = 'salespersonCode';
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
            field(isPrimary; Rec."Is Primary")
            {
                Caption = 'isPrimary';
                Editable = false;
            }
            field(source; Rec.Source)
            {
                Caption = 'source';
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
