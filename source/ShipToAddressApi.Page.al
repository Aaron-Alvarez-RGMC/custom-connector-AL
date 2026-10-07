// Read-only API over Ship-to Address (222). Gives the SBIC models the ship-to name and address per customer, used to
// resolve the legacy customer branch. Matching is by customer (customerNo) and the normalized ship-to name, because the
// hand-entered Lookup Code is filled on only a few ship-tos. The Lookup Code itself is in the pending file
// ShipToLookupCodeApi.Page.al.pending (needs the RGMC API Extension symbols to compile).
// Natural key: customerNo + code.

using Microsoft.Sales.Customer;

page 51014 "RGMC Ship-to Address API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'shipToAddress';
    EntitySetName = 'shipToAddresses';
    Caption = 'RGMC Ship-to Address API';

    SourceTable = "Ship-to Address";
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
            field(customerNo; Rec."Customer No.")
            {
                Caption = 'customerNo';
                Editable = false;
            }
            field(code; Rec.Code)
            {
                Caption = 'code';
                Editable = false;
            }

            // --- Address ---
            field(name; Rec.Name)
            {
                Caption = 'name';
                Editable = false;
            }
            field(name2; Rec."Name 2")
            {
                Caption = 'name2';
                Editable = false;
            }
            field(address; Rec.Address)
            {
                Caption = 'address';
                Editable = false;
            }
            field(address2; Rec."Address 2")
            {
                Caption = 'address2';
                Editable = false;
            }
            field(city; Rec.City)
            {
                Caption = 'city';
                Editable = false;
            }
            field(postCode; Rec."Post Code")
            {
                Caption = 'postCode';
                Editable = false;
            }
            field(county; Rec.County)
            {
                Caption = 'county';
                Editable = false;
            }
            field(countryRegionCode; Rec."Country/Region Code")
            {
                Caption = 'countryRegionCode';
                Editable = false;
            }
            field(contact; Rec.Contact)
            {
                Caption = 'contact';
                Editable = false;
            }
            field(phoneNo; Rec."Phone No.")
            {
                Caption = 'phoneNo';
                Editable = false;
            }
            field(email; Rec."E-Mail")
            {
                Caption = 'email';
                Editable = false;
            }

            // --- Logistics / rep ---
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field(salespersonCode; Rec."Salesperson Code")
            {
                Caption = 'salespersonCode';
                Editable = false;
            }
            field(shippingAgentCode; Rec."Shipping Agent Code")
            {
                Caption = 'shippingAgentCode';
                Editable = false;
            }
            field(shipmentMethodCode; Rec."Shipment Method Code")
            {
                Caption = 'shipmentMethodCode';
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
