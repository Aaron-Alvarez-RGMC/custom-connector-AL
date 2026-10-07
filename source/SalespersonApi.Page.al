// Read-only API over Salesperson/Purchaser (13). Source of the rep's name and login email for the SBIC models: the
// sales target sheets are matched on the rep's full name and row-level security on the rep's email, so Name must be
// the legacy "FIRST LAST" form and E-Mail the login email. Natural key: code.

using Microsoft.CRM.Team;

page 51019 "RGMC Salesperson API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'salesperson';
    EntitySetName = 'salespeople';
    Caption = 'RGMC Salesperson API';

    SourceTable = "Salesperson/Purchaser";
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
            field(code; Rec.Code)
            {
                Caption = 'code';
                Editable = false;
            }
            field(name; Rec.Name)
            {
                Caption = 'name';
                Editable = false;
            }
            field(email; Rec."E-Mail")
            {
                Caption = 'email';
                Editable = false;
            }
            field(phoneNo; Rec."Phone No.")
            {
                Caption = 'phoneNo';
                Editable = false;
            }
            field(jobTitle; Rec."Job Title")
            {
                Caption = 'jobTitle';
                Editable = false;
            }
            field(blocked; Rec.Blocked)
            {
                Caption = 'blocked';
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
