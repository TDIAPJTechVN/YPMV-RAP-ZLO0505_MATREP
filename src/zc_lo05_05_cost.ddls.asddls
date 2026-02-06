@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDSView of Product Costing'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_LO05_05_COST
  as select from I_ProductValuationBasic as _val
  association [0..1] to I_ProductValuationCosting as _cost on  $projection.Product       = _cost.Product
                                                           and $projection.ValuationArea = _cost.ValuationArea
{
  key Product,
  key ValuationArea,
      _val.ValuationClass,
      _val.InventoryValuationProcedure,
      _val.PriceDeterminationControl,
      _val.Currency as CurrencyVal,
      @Semantics.amount.currencyCode: 'CurrencyVal'
      _val.MovingAveragePrice,
      @Semantics.amount.currencyCode: 'CurrencyVal'
      _val.StandardPrice,

      _val.PriceUnitQty,
      _cost.IsMaterialCostedWithQtyStruc,
      _cost.CostOriginGroup,
      _cost.CostingOverheadGroup
}
