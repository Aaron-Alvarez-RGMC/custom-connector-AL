// Read-only API over LSC Tender Type (99001462) - per store (key: Store No., Code). RGMC_ERAR's Pag50336 exposes only
// code/description, so the same 23 codes repeat for 10 stores with nothing to tell them apart. Adds storeNo + setup fields
// used by NAV's stg_covent_tender_type.

page 51005 "RGMC Tender Type Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'tenderTypeExtended';
    EntitySetName = 'tenderTypesExtended';
    Caption = 'RGMC Tender Type Extended API';

    SourceTable = "LSC Tender Type";
    ODataKeyFields = SystemId;

    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            // --- Identity / join keys ---
            field(id; Rec.SystemId)
            {
                Caption = 'id';
                Editable = false;
            }
            field(storeNo; Rec."Store No.")
            {
                Caption = 'storeNo';
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

            // --- Classification ---
            field("function"; Rec."Function")
            {
                Caption = 'function';
                Editable = false;
            }
            field(noInTransaction; Rec."No. in Transaction")
            {
                Caption = 'noInTransaction';
                Editable = false;
            }
            field(foreignCurrency; Rec."Foreign Currency")
            {
                Caption = 'foreignCurrency';
                Editable = false;
            }
            field(changeTendCode; Rec."Change Tend. Code")
            {
                Caption = 'changeTendCode';
                Editable = false;
            }
            field(mayBeUsed; Rec."May Be Used")
            {
                Caption = 'mayBeUsed';
                Editable = false;
            }
            field(doNotPost; Rec."Do Not Post")
            {
                Caption = 'doNotPost';
                Editable = false;
            }

            // --- Posting ---
            field(accountType; Rec."Account Type")
            {
                Caption = 'accountType';
                Editable = false;
            }
            field(accountNo; Rec."Account No.")
            {
                Caption = 'accountNo';
                Editable = false;
            }
            field(accountName; Rec."Account Name")
            {
                Caption = 'accountName';
                Editable = false;
            }
            field(chargePercent; Rec."Charge %")
            {
                Caption = 'chargePercent';
                Editable = false;
            }
            field(chargeToAccountNo; Rec."Charge to Account No.")
            {
                Caption = 'chargeToAccountNo';
                Editable = false;
            }
            field(bankAccountType; Rec."Bank Account Type")
            {
                Caption = 'bankAccountType';
                Editable = false;
            }
            field(bankAccountNo; Rec."Bank Account No.")
            {
                Caption = 'bankAccountNo';
                Editable = false;
            }

            // --- POS behaviour ---
            field(rounding; Rec.Rounding)
            {
                Caption = 'rounding';
                Editable = false;
            }
            field(roundingTo; Rec."Rounding To")
            {
                Caption = 'roundingTo';
                Editable = false;
            }
            field(minChange; Rec."Min. Change")
            {
                Caption = 'minChange';
                Editable = false;
            }
            field(overtenderAllowed; Rec."Overtender Allowed")
            {
                Caption = 'overtenderAllowed';
                Editable = false;
            }
            field(returnMinusAllowed; Rec."Return/Minus Allowed")
            {
                Caption = 'returnMinusAllowed';
                Editable = false;
            }
            field(countingRequired; Rec."Counting Required")
            {
                Caption = 'countingRequired';
                Editable = false;
            }
            field(takenToBank; Rec."Taken to Bank")
            {
                Caption = 'takenToBank';
                Editable = false;
            }
            field(takenToSafe; Rec."Taken to Safe")
            {
                Caption = 'takenToSafe';
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
