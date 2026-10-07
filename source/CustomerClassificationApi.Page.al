// Read-only API over Customer (18) exposing the classification and commercial fields no existing customer API page
// publishes: Dept Code / Sub Dept Code / Class Code (RGMC Base Extension, fields 50100-50102, integers), Territory,
// price and discount groups, payment terms and the customer's default salesperson. The legacy SBIC system keeps a
// customer class and group; these are the candidate BC equivalents if the business fills them. Natural key: number.

using Microsoft.Sales.Customer;

page 51017 "RGMC Cust Classification API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'customerClassification';
    EntitySetName = 'customerClassifications';
    Caption = 'RGMC Customer Classification API';

    SourceTable = Customer;
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
            field(number; Rec."No.")
            {
                Caption = 'number';
                Editable = false;
            }
            field(name; Rec.Name)
            {
                Caption = 'name';
                Editable = false;
            }

            // --- RGMC Base Extension classification ---
            field(deptCode; Rec."Dept Code")
            {
                Caption = 'deptCode';
                Editable = false;
            }
            field(subDeptCode; Rec."Sub Dept Code")
            {
                Caption = 'subDeptCode';
                Editable = false;
            }
            field(classCode; Rec."Class Code")
            {
                Caption = 'classCode';
                Editable = false;
            }

            // --- Standard commercial fields ---
            field(salespersonCode; Rec."Salesperson Code")
            {
                Caption = 'salespersonCode';
                Editable = false;
            }
            field(territoryCode; Rec."Territory Code")
            {
                Caption = 'territoryCode';
                Editable = false;
            }
            field(customerPriceGroup; Rec."Customer Price Group")
            {
                Caption = 'customerPriceGroup';
                Editable = false;
            }
            field(customerDiscGroup; Rec."Customer Disc. Group")
            {
                Caption = 'customerDiscGroup';
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
            field(blocked; Rec.Blocked)
            {
                Caption = 'blocked';
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
