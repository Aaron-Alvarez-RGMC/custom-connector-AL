// Permission set for the new SBIC objects: read access to the standard tables the new API pages expose, full access to
// the account-to-rep assignment table (maintained by the sales team), and execute on the new pages.
// Assign "RGMC CC SBIC" to the user that Airbyte / the gateway authenticates as, and to the sales admins who maintain
// the assignments. Confirm first which permission set that user already holds; if it is SUPER this is not needed.

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Team;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Catalog;

permissionset 51026 "RGMC CC SBIC"
{
    Assignable = true;
    Caption = 'RGMC Custom Connector SBIC';

    Permissions =
        tabledata "Sales Shipment Header" = R,
        tabledata "Sales Invoice Header" = R,
        tabledata "Sales Invoice Line" = R,
        tabledata "Sales Header" = R,
        tabledata "Sales Line" = R,
        tabledata "Ship-to Address" = R,
        tabledata Customer = R,
        tabledata "Salesperson/Purchaser" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Item Reference" = R,
        tabledata "RGMC Sales Rep Assignment" = RIMD,
        table "RGMC Sales Rep Assignment" = X,
        page "RGMC Sales Shipment Header API" = X,
        page "RGMC Sales Invoice Header API" = X,
        page "RGMC Sales Invoice Line API" = X,
        page "RGMC Sales Order Header API" = X,
        page "RGMC Sales Order Line API" = X,
        page "RGMC Ship-to Address API" = X,
        page "RGMC Item Unit of Measure API" = X,
        page "RGMC Item Reference API" = X,
        page "RGMC Cust Classification API" = X,
        page "RGMC Salesperson API" = X,
        page "RGMC Sales Rep Assignments" = X,
        page "RGMC Sales Rep Assignment API" = X;
}
