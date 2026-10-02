// Read-only API over LSC Retail Product Group (10000705) exposing the fields that the shared RGMC Retail Prod Group
// API (Pag50335) does not publish (it has only code, description and item category). NAV's stg_*_product_group carried
// these columns; this gives BC the same set. Join to retailProductGroups on id (SystemId), or on (companyName, code).
// Not exposed: Primary Key (obsolete, replaced by SystemId) and Item Template Code (obsolete, replaced by Item Templ. Code).
// NAV's warehouse_class_code has no field on this table in LS Central 28.
// defItemDistrType is an Option (Store, Customer, Customer Group): OData returns its members with _xHHHH_ escapes.

page 51008 "RGMC Retail Prod Group Ext"
{
    PageType = API;
    APIPublisher = 'aaronalvarez';
    APIGroup = 'customConnector';
    APIVersion = 'v1.0';
    EntityName = 'retailProductGroupExtended';
    EntitySetName = 'retailProductGroupsExtended';
    Caption = 'RGMC Retail Prod Group Ext';

    SourceTable = "LSC Retail Product Group";
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
            field(description; Rec.Description)
            {
                Caption = 'description';
                Editable = false;
            }
            field(itemCategoryCode; Rec."Item Category Code")
            {
                Caption = 'itemCategoryCode';
                Editable = false;
            }
            field(buyerId; Rec."Buyer ID")
            {
                Caption = 'buyerId';
                Editable = false;
            }
            field(buyerGroupCode; Rec."Buyer Group Code")
            {
                Caption = 'buyerGroupCode';
                Editable = false;
            }
            field(divisionCode; Rec."Division Code")
            {
                Caption = 'divisionCode';
                Editable = false;
            }
            field(barcodeMask; Rec."Barcode Mask")
            {
                Caption = 'barcodeMask';
                Editable = false;
            }
            field(useEanStandardBarc; Rec."Use EAN Standard Barc.")
            {
                Caption = 'useEanStandardBarc';
                Editable = false;
            }
            field(outboundCode; Rec."Outbound Code")
            {
                Caption = 'outboundCode';
                Editable = false;
            }
            field(allocationRuleCode; Rec."Allocation Rule Code")
            {
                Caption = 'allocationRuleCode';
                Editable = false;
            }
            field(posMenuLink; Rec."POS Menu Link")
            {
                Caption = 'posMenuLink';
                Editable = false;
            }
            field(posInventoryLookup; Rec."POS Inventory Lookup")
            {
                Caption = 'posInventoryLookup';
                Editable = false;
            }
            field(suggestedQtyOnPos; Rec."Suggested Qty. on POS")
            {
                Caption = 'suggestedQtyOnPos';
                Editable = false;
            }
            field(dispensePrinterGroup; Rec."Dispense Printer Group")
            {
                Caption = 'dispensePrinterGroup';
                Editable = false;
            }
            field(disableDispensePrinting; Rec."Disable Dispense Printing")
            {
                Caption = 'disableDispensePrinting';
                Editable = false;
            }
            field(shelfLabelDescription; Rec."Shelf Label Description")
            {
                Caption = 'shelfLabelDescription';
                Editable = false;
            }
            field(profitGoalPercent; Rec."Profit Goal %")
            {
                Caption = 'profitGoalPercent';
                Editable = false;
            }
            field(defaultProfitPercent; Rec."Default Profit %")
            {
                Caption = 'defaultProfitPercent';
                Editable = false;
            }
            field(notDiscountable; Rec."Not Discountable")
            {
                Caption = 'notDiscountable';
                Editable = false;
            }
            field(defaultBaseUom; Rec."Default Base UOM")
            {
                Caption = 'defaultBaseUom';
                Editable = false;
            }
            field(qtyNotInDecimal; Rec."Qty not in Decimal")
            {
                Caption = 'qtyNotInDecimal';
                Editable = false;
            }
            field(itemTemplCode; Rec."Item Templ. Code")
            {
                Caption = 'itemTemplCode';
                Editable = false;
            }
            field(itemErrorCheckCode; Rec."Item Error Check Code")
            {
                Caption = 'itemErrorCheckCode';
                Editable = false;
            }
            field(variantFrameworkCode; Rec."Variant Framework Code")
            {
                Caption = 'variantFrameworkCode';
                Editable = false;
            }
            field(minLocProfInventory; Rec."Min Loc. Prof. Inventory")
            {
                Caption = 'minLocProfInventory';
                Editable = false;
            }
            field(replenDataProfile; Rec."Replen. Data Profile")
            {
                Caption = 'replenDataProfile';
                Editable = false;
            }
            field(replenTransferRuleCode; Rec."Replen. Transfer Rule Code")
            {
                Caption = 'replenTransferRuleCode';
                Editable = false;
            }
            field(defItemDistrType; Rec."Def. Item Distr. Type")
            {
                Caption = 'defItemDistrType';
                Editable = false;
            }
            field(defItemDistrCode; Rec."Def. Item Distr. Code")
            {
                Caption = 'defItemDistrCode';
                Editable = false;
            }
            field(lastDateModified; Rec."Last Date Modified")
            {
                Caption = 'lastDateModified';
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
