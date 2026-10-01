// Read-only API over Customer exposing its Location Code (standard Base Application field 5700), which no existing
// customer API page publishes. NAV's customer.location_code was used to name the customer behind a store location;
// this gives BC the same join (customer number -> locationCode -> Item Ledger Entry location code).
// Join to Item Ledger Entry / Transfer Shipment on locationCode. Customers with no Location Code come back blank.

using Microsoft.Sales.Customer;

page 51007 "RGMC Customer Location API"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'customerLocation';
    EntitySetName = 'customerLocations';
    Caption = 'RGMC Customer Location API';

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
            field(locationCode; Rec."Location Code")
            {
                Caption = 'locationCode';
                Editable = false;
            }
            field(lastModifiedDateTime; Rec.SystemModifiedAt)
            {
                Caption = 'lastModifiedDateTime';
                Editable = false;
            }
        }
    }
}
