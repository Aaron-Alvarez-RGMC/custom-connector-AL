// Permission set for the new SBIC objects: read access to the standard tables the new API pages expose, full access to
// the account-to-rep assignment table (maintained by the sales team), and execute on the new pages.
// Assign "RGMC CC SBIC" to the user that Airbyte / the gateway authenticates as, and to the sales admins who maintain
// the assignments. Confirm first which permission set that user already holds; if it is SUPER this is not needed.
// 1.0.4.1 adds the SBIC AR / warehouse report sources: customer, G/L and bank ledgers, credit memos, open invoices /
// credit memos / return orders, general journal lines, return receipt headers and purchase receipts.

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using Microsoft.CRM.Team;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Bank.Ledger;
using Microsoft.Purchases.History;

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
        tabledata "Cust. Ledger Entry" = R,
        tabledata "Detailed Cust. Ledg. Entry" = R,
        tabledata "G/L Entry" = R,
        tabledata "Bank Account Ledger Entry" = R,
        tabledata "Sales Cr.Memo Header" = R,
        tabledata "Sales Cr.Memo Line" = R,
        tabledata "Gen. Journal Line" = R,
        tabledata "Gen. Journal Template" = R,
        tabledata "Return Receipt Header" = R,
        tabledata "Purch. Rcpt. Header" = R,
        tabledata "Purch. Rcpt. Line" = R,
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
        page "RGMC Sales Rep Assignment API" = X,
        page "RGMC Cust Ledger Entry API" = X,
        page "RGMC Dtld Cust Ledg Entry API" = X,
        page "RGMC GL Entry API" = X,
        page "RGMC Bank Acc Ledger Entry API" = X,
        page "RGMC Sales Cr Memo Header API" = X,
        page "RGMC Sales Cr Memo Line API" = X,
        page "RGMC Sales Doc Header API" = X,
        page "RGMC Sales Doc Line API" = X,
        page "RGMC Gen Journal Line API" = X,
        page "RGMC Return Receipt Header API" = X,
        page "RGMC Purch Rcpt Header API" = X,
        page "RGMC Purch Rcpt Line API" = X;
}
