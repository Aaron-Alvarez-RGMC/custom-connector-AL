// Account-to-rep assignments for the SBIC key account reporting (KAM / KAS). BC has one standard Salesperson Code per
// customer, which cannot express the legacy model: several reps per customer, one of them primary, each with a start
// and end date. This table mirrors the legacy SalesRepCustomer columns (customer, rep, primary flag, start, end).
// The KAM / KAS role is NOT stored; it is derived downstream exactly as in the legacy data model:
//   one active rep and primary          -> KAM (sole owner)
//   several active reps and primary     -> KAS (account owner, supervised by a KAM)
//   not primary                         -> KAM (supervises the KAS)
// A row is active when Ending Date is blank or not before today.

using Microsoft.Sales.Customer;
using Microsoft.CRM.Team;

table 51020 "RGMC Sales Rep Assignment"
{
    Caption = 'RGMC Sales Rep Assignment';
    DataClassification = CustomerContent;
    LookupPageId = "RGMC Sales Rep Assignments";
    DrillDownPageId = "RGMC Sales Rep Assignments";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            NotBlank = true;
        }
        field(2; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
            NotBlank = true;
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(4; "Is Primary"; Boolean)
        {
            Caption = 'Is Primary';
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; Source; Text[30])
        {
            Caption = 'Source';
        }
    }

    keys
    {
        key(PK; "Customer No.", "Salesperson Code", "Starting Date")
        {
            Clustered = true;
        }
        key(CustomerKey; "Customer No.", "Is Primary")
        {
        }
    }

    trigger OnInsert()
    begin
        ValidateAssignment();
    end;

    trigger OnModify()
    begin
        ValidateAssignment();
    end;

    local procedure ValidateAssignment()
    begin
        if ("Ending Date" <> 0D) and ("Ending Date" < "Starting Date") then
            Error('Ending Date %1 cannot be before Starting Date %2.', "Ending Date", "Starting Date");
        if "Is Primary" then
            CheckSinglePrimary();
    end;

    // At most one primary assignment per customer may be open at the same time.
    local procedure CheckSinglePrimary()
    var
        Other: Record "RGMC Sales Rep Assignment";
    begin
        Other.SetRange("Customer No.", "Customer No.");
        Other.SetRange("Is Primary", true);
        if Other.FindSet() then
            repeat
                if (Other."Salesperson Code" <> "Salesperson Code") or (Other."Starting Date" <> "Starting Date") then
                    if PeriodsOverlap(Other."Starting Date", Other."Ending Date", "Starting Date", "Ending Date") then
                        Error('Customer %1 already has a primary rep (%2) for an overlapping period.', "Customer No.", Other."Salesperson Code");
            until Other.Next() = 0;
    end;

    local procedure PeriodsOverlap(StartA: Date; EndA: Date; StartB: Date; EndB: Date): Boolean
    begin
        if (EndA <> 0D) and (EndA < StartB) then
            exit(false);
        if (EndB <> 0D) and (EndB < StartA) then
            exit(false);
        exit(true);
    end;
}
