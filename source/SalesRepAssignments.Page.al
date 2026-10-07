// Maintenance list for the SBIC account-to-rep assignments (table 51020). Used by the sales team to maintain who owns
// each account, and as the import target for the one-time migration from the legacy assignments.

page 51021 "RGMC Sales Rep Assignments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'RGMC Sales Rep Assignments';
    SourceTable = "RGMC Sales Rep Assignment";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Assignments)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer the rep is assigned to.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salesperson assigned to the customer.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first day of the assignment.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day of the assignment. Leave blank while the assignment is open.';
                }
                field("Is Primary"; Rec."Is Primary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this rep is the primary rep on the account. Only one primary rep can be open per customer.';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies where the assignment came from, for example legacy-migration.';
                }
            }
        }
    }
}
